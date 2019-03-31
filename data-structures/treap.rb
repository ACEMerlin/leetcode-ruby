# Treap
#
#   https://cp-algorithms.com/data_structures/treap.html
#   https://www.youtube.com/watch?v=erKlLEXLKyY
#
# From what I learn there are two variants of Treap:
#   1. use rotation to rebalance.
#   2. no rotation and use merge(join)/split to implement insert/delete.
#
# After some benchmark it seems that the first one is faster, but I
# think it's a little complicated to implement in interview. I
# recommend using other BSTs like AVL in contest and use the second
# Treap implementation in interview.


# This one is based on rotation.

class Treap
  include Enumerable

  def initialize
    @root = nil
    @MAX = 1<<63
    @random = Random.new
  end

  def randp
    @random.rand(@MAX)
  end

  def insert(key, val=key)
    @root = insert_(key, val, @root)
  end
  alias_method :<<, :insert

  def delete(key)
    @root = delete_(key, @root)
  end

  def find(key, val=true, node=@root)
    return if node.nil?
    cmp = key <=> node.key
    if cmp < 0
      find(key, val, node.left)
    elsif cmp > 0
      find(key, val, node.right)
    else
      val ? node.val : node
    end
  end
  alias_method :[], :find

  def kth(k, node=@root)
    return if node.nil?
    x = size(node.left)
    if k < x+1
      kth(k, node.left)
    elsif k > x+node.count
      kth(k-x-node.count, node.right)
    else
      node.val
    end
  end

  def merge_to(treap, node=@root)
    return treap.merge_to(self) if treap.size < size
    merge_to_(treap)
  end

  def size(node=@root)
    node&.size.to_i
  end

  def empty?
    @root.nil?
  end

  def debug(n=@root, tab=0)
    return '' if n.nil?
    puts "#{' '*tab} #{n.key} #{n.val}, #{n.prior}, #{n.size}"
    tab += 2
    debug(n.left, tab)
    debug(n.right, tab)
  end

  def min(node=@root)
    return node&.val if node&.left.nil?
    min(node.left)
  end

  def max(node=@root)
    return node&.val if node&.right.nil?
    max(node.right)
  end

  def delete_min
    return if empty?
    @root = delete_min_(@root)
  end

  def delete_max
    return if empty?
    @root = delete_max_(@root)
  end

  def floor(key, node=@root)
    return if node.nil?
    cmp = key <=> node.key
    if cmp < 0
      floor(key, node.left)
    elsif cmp > 0
      floor(key, node.right) || node.val
    else
      node.val
    end
  end

  def ceil(key, node=@root)
    return if node.nil?
    cmp = key <=> node.key
    if cmp < 0
      ceil(key, node.left) || node.val
    elsif cmp > 0
      ceil(key, node.right)
    else
      node.val
    end
  end

  def rank(key, node=@root)
    return 0 if node.nil?
    cmp = key <=> node.key
    if cmp < 0
      rank(key, node.left)
    elsif cmp > 0
      node.count + size(node.left) + rank(key, node.right)
    else
      size(node.left)
    end
  end

  def count(lo, hi)
    hi_node = find(hi, false)
    if !hi_node.nil?
      rank(hi) - rank(lo) + hi_node.count
    else
      rank(hi) - rank(lo)
    end
  end

  def search(lo, hi, node=@root, ans=[])
    return [] if node.nil?
    if node.key < lo
      search(lo, hi, node.right, ans)
    elsif node.key > hi
      search(lo, hi, node.left, ans)
    else
      search(lo, hi, node.left, ans)
      node.count.times { ans << node.val }
      search(lo, hi, node.right, ans)
    end
    ans
  end

  def each(&block)
    return to_enum(:each) unless block_given?
    inorder(@root, &block)
  end

  private

  class Node
    attr_accessor :key, :val, :prior, :left, :right, :size, :count

    def initialize(key, val, prior)
      @key, @val, @prior, @size, @count = key, val, prior, 1, 1
      @left, @right = nil, nil
    end

    def update
      @size = @count + @left&.size.to_i + @right&.size.to_i
    end
  end

  def rotate_right(h)
    x = h.left
    h.left = x.right
    x.right = h
    h.update
    x
  end

  def rotate_left(h)
    x = h.right
    h.right = x.left
    x.left = h
    h.update
    x
  end

  def insert_(key, val, node)
    return Node.new(key, val, randp) if node.nil?
    if key < node.key
      node.left = insert_(key, val, node.left)
      node = rotate_right(node) if node.left.prior > node.prior
    elsif key > node.key
      node.right = insert_(key, val, node.right)
      node = rotate_left(node) if node.right.prior > node.prior
    else
      node.count += 1
    end
    node.update
    node
  end

  def delete_(key, node)
    return if node.nil?
    cmp = key <=> node.key
    if cmp < 0
      node.left = delete_(key, node.left)
    elsif cmp > 0
      node.right = delete_(key, node.right)
    else
      if node.count > 1
        node.count -= 1
      else
        return node.left if node.right.nil?
        return node.right if node.left.nil?
        if node.left.prior > node.right.prior
          node = rotate_right(node)
          node.right = delete_(key, node.right)
        else
          node = rotate_left(node)
          node.left = delete_(key, node.left)
        end
      end
    end
    node.update
    node
  end

  def merge_to_(treap, node=@root)
    return if node.nil?
    merge_to_(treap, node.left)
    treap.insert(node.key, node.val)
    merge_to_(treap, node.right)
    treap
  end

  def delete_min_(node)
    return node.right if node.left.nil?
    node.left = delete_min_(node.left)
    node&.update
    node
  end

  def delete_max_(node)
    return node.left if node.right.nil?
    node.right = delete_max_(node.right)
    node&.update
    node
  end

  def inorder(node, &block)
    return if node.nil?
    inorder(node.left, &block)
    node.count.times { block.call(node.val) }
    inorder(node.right, &block)
  end
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_treap
    t = Treap.new
    xs = [3, 6, 12, 14, 9, 11, 4, 3, 7, 13]
    xs.each { |x| t << x }
    xs.sort.each_with_index { |x, i| assert_equal t.kth(i+1), x }
    assert t.find(8).nil?
    assert_equal t.count(3, 8), 5
    assert_equal t.count(7, 15), 6
    assert_equal t.count(11, 11), 1
    assert_equal t.search(3, 5), [3, 3, 4]
    assert_equal t.search(9, 12), [9, 11, 12]
    assert_equal t.rank(3), 0
    assert_equal t.rank(2), 0
    assert_equal t.rank(8), 5
    assert_equal t.rank(4), 2
    assert_equal t.rank(15), 10
    assert_equal t.to_a, xs.sort
  end
end


# This one is based on merge/split.

class Treap2

  def initialize
    @root = nil
    @MAX = 1<<63
    @random = Random.new
  end

  def randp
    @random.rand(@MAX)
  end

  def insert(key, val=key)
    l, r = split(key)
    @root = merge(merge(l, Node.new(key, val, randp)), r)
  end
  alias_method :<<, :insert

  def delete(key)
    @root = delete_(key, @root)
  end

  def find(key, node=@root)
    return if node.nil?
    cmp = key <=> node.key
    if cmp < 0
      find(key, node.left)
    elsif cmp > 0
      find(key, node.right)
    else
      node.val
    end
  end
  alias_method :[], :find

  def kth(k, node=@root)
    return if node.nil?
    x = size(node.left)+1
    if k < x
      kth(k, node.left)
    elsif k > x
      kth(k-x, node.right)
    else
      node.val
    end
  end

  def size(node=@root)
    node&.size.to_i
  end

  def debug(n=@root, tab=0)
    return '' if n.nil?
    puts "#{' '*tab} #{n.key} #{n.val}, #{n.prior}, #{n.size}"
    tab += 2
    debug(n.left, tab)
    debug(n.right, tab)
  end

  private

  class Node
    attr_accessor :key, :val, :prior, :left, :right, :size

    def initialize(key, val, prior)
      @key, @val, @prior, @size = key, val, prior, 1
      @left, @right = nil, nil
    end

    def update
      @size = 1 + @left&.size.to_i + @right&.size.to_i
    end
  end

  def merge(l, r)
    return l if r.nil?
    return r if l.nil?
    if l.prior < r.prior
      r.left = merge(l, r.left)
      r.update
      r
    else
      l.right = merge(l.right, r)
      l.update
      l
    end
  end

  def split(key, node=@root)
    return [nil, nil] if node.nil?
    if key <= node.key
      l, r = split(key, node.left)
      node.left = r
      node.update
      [l, node]
    else
      l, r = split(key, node.right)
      node.right = l
      node.update
      [node, r]
    end
  end

  def delete_(key, node)
    return if node.nil?
    cmp = key <=> node.key
    if cmp < 0
      node.left = delete_(key, node.left)
    elsif cmp > 0
      node.right = delete_(key, node.right)
    else
      node = merge(node.left, node.right)
    end
    node.update if !node.nil?
    node
  end
end
