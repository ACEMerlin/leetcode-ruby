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
  class EmptyNode

    def method_missing(m, *args, &block); end

    def empty?
      true
    end

    def size
      0
    end

    def d(tab=0)
      puts "#{' '*tab}E"
    end

    def insert(key, value)
      Node.new(key, value)
    end

    def delete(_)
      self
    end

    def rank(_)
      0
    end

    def split(_)
      [EMPTY, EMPTY]
    end
  end

  EMPTY = EmptyNode.new.freeze
end

class Treap
  MAX = (2<<63).freeze

  class Node
    include Comparable

    attr_accessor :key, :val, :prior, :left, :right, :size

    def initialize(key, val)
      @key, @val, = key, val
      @prior, @size = Random.rand(MAX), 1, 1
      @left = @right = EMPTY
    end

    def update
      @size = 1 + @left.size + @right.size
    end

    def <=>(o)
      @key <=> o.key
    end

    def empty?
      false
    end

    def rotate_right
      x = @left
      @left = x.right
      x.right = self
      update
      x
    end

    def rotate_left
      x = @right
      @right = x.left
      x.left = self
      update
      x
    end

    def insert(key, val)
      n = self
      case key <=> @key
      when -1
        @left = @left.insert(key, val)
        n = rotate_right if @left.prior > @prior
      when 1
        @right = @right.insert(key, val)
        n = rotate_left if @right.prior > @prior
      else
        @val = val
      end
      n.update
      n
    end

    def delete(key)
      n = self
      cmp = key <=> @key
      case cmp
      when -1
        @left = @left.delete(key)
      when 1
        @right = @right.delete(key)
      else
        return @left if @right.empty?
        return @right if @left.empty?
        if @left.prior > @right.prior
          n = rotate_right
          n.right = n.right.delete(key)
        else
          n = rotate_left
          n.left = n.left.delete(key)
        end
      end
      n.update
      n
    end

    def find(key)
      cmp = key <=> @key
      case cmp
      when  -1
        @left.find(key)
      when 1
        @right.find(key)
      when 0
        @val
      end
    end

    def rank(key)
      cmp = key <=> @key
      case cmp
      when -1
        @left.rank(key)
      when 1
        1 + @left.size + @right.rank(key)
      else
        @left.size
      end
    end

    def kth(k)
      x = @left.size+1
      cmp = k <=> x
      case cmp
      when -1
        @left.kth(k)
      when 1
        @right.kth(k-x)
      else
        @val
      end
    end

    def floor(key)
      cmp = key <=> @key
      case cmp
      when -1
        @left.floor(key)
      when 1
        @right.floor(key) || @val
      else
        @val
      end
    end

    def ceil(key)
      cmp = key <=> @key
      case cmp
      when -1
        @left.ceil(key) || @val
      when 1
        @right.ceil(key)
      else
        @val
      end
    end

    def count_between(lo, hi)
      if !find(hi).nil?
        rank(hi) - rank(lo) + 1
      else
        rank(hi) - rank(lo)
      end
    end

    def between(lo, hi, ans=[])
      if @key < lo
        @right.between(lo, hi, ans)
      elsif @key > hi
        @left.between(lo, hi, ans)
      else
        @left.between(lo, hi, ans)
        ans << @val
        @right.between(lo, hi , ans)
      end
      ans
    end

    def split(key)
      if key <= @key
        l, r = @left.split(key)
        @left = r
        update
        [l, self]
      else
        l, r = @right.split(key)
        @right = l
        update
        [self, r]
      end
    end

    def merge(o)
      return self if o.nil?
      return o if self.empty?
      if @prior < o.prior
        o.left = merge(self, o.left)
        o.update
        o
      else
        @right = merge(@right, o)
        update
        self
      end
    end

    def each(&block)
      return to_enum if !block_given?
      @left.each(&block)
      yield [@key, @val]
      @right.each(&block)
    end

    def each_key(&block)
      return to_enum(:each_key) if !block_given?
      @left.each_key(&block)
      yield @key
      @right.each_key(&block)
    end

    def each_val(&block)
      return to_enum(:each_val) if !block_given?
      @left.each_val(&block)
      yield @val
      @right.each_val(&block)
    end

    def d(tab=0)
      puts "#{' '*tab}#{@key} #{@val}, #{@prior}, #{@size}"
      tab += 2
      @left.d(tab)
      @right.d(tab)
    end
  end
end

class Treap
  include Enumerable

  def initialize
    @root = EMPTY
  end

  def method_missing(m, *args, &block)
    if @root.respond_to?(m)
      @root.send(m, *args, &block)
    else
      raise ArgumentError.new("Method `#{m}` doesn't exist.")
    end
  end

  def []=(key, val)
    @root = @root.insert(key, val)
  end

  def [](key)
    @root.find(key)
  end

  def delete(key)
    @root = @root.delete(key)
  end
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_treap
    t = Treap.new
    xs = [3, 6, 12, 14, 9, 11, 4, 5, 7, 13]
    xs.each { |x| t[x] = x  }
    xs.sort.each_with_index { |x, i| assert_equal t.kth(i+1), x }
    assert t[8].nil?
    assert_equal t.count_between(3, 8), 5
    assert_equal t.count_between(7, 15), 6
    assert_equal t.count_between(11, 11), 1
    assert_equal t.between(3, 5), [3, 4, 5]
    assert_equal t.between(9, 12), [9, 11, 12]
    assert_equal t.rank(3), 0
    assert_equal t.rank(2), 0
    assert_equal t.rank(8), 5
    assert_equal t.rank(4), 1
    assert_equal t.rank(15), 10
    assert_equal t.each_val.to_a, xs.sort
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

  def size(node=@root)
    node&.size.to_i
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
