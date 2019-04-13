# Codefight: https://app.codesignal.com/interview-practice/task/5vXzdE9yzjsoMZ9sk

eval <<-Ruby
class UF

  attr_accessor :arr

  def initialize(size)
    @arr = Array.new(size, &:itself)
    @weight = Array.new(size, 1)
  end

  def union(i, j)
    p, q = root(i), root(j)
    return if p == q
    if @weight[p] <= @weight[q]
      @arr[p] = q
      @weight[q] += @weight[p]
    else
      @arr[q] = p
      @weight[p] += @weight[q]
    end
  end

  def connected?(i, j)
    root(i) == root(j)
  end

  def root(i)
    while @arr[i] != i
      @arr[i] = @arr[@arr[i]]
      i = @arr[i]
    end
    i
  end
end
Ruby

def swapLexOrder(str, pairs)
  uf = UF.new(str.size)
  pairs.each do |(i, j)|
    uf.union(i-1, j-1)
  end
  uf.arr
    .map { |i| uf.root(i) }
    .each_with_index
    .reduce(Hash.new { |h, k| h[k] = [] }) { |h, (n, i)| h[n] << [i, str[i]]; h}
    .values
    .each { |xs|
    next if xs.size == 1
    order = xs.sort_by(&:last).reverse
    xs.each_with_index { |(i, _), j| str[i] = order[j][1] }
  }
  str
end
