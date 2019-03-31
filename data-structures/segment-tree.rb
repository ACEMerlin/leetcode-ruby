# SegmentTree
#
#   https://cp-algorithms.com/data_structures/segment_tree.html
#
# API:
#   - subclass.new(array): initialize segment tree using array.
#   - update(p, val): update elment at p in array to val.
#   - query(a, b): return the thing you want in range (a..b).
#
# See the subclasses below for how to use SegmentTree.

class SegmentTree

  def update(p, val, i=1, lo=0, hi=@size-1)
    if lo == hi
      @nodes[i] = leaf(val)
    else
      m = (lo+hi)/2
      if p <= m
        update(p, val, i*2, lo, m)
      else
        update(p, val, i*2+1, m+1, hi)
      end
      @nodes[i] = combine(@nodes[i*2], @nodes[i*2+1])
    end
  end

  def query(a, b, i=1, lo=0, hi=@size-1)
    return @nodes[i] if lo == a && hi == b
    m = (lo+hi)/2
    return query(a, b, i*2, lo, m) if b <= m
    return query(a, b, i*2+1, m+1, hi) if a > m
    left = query(a, m, i*2, lo, m)
    right = query(m+1, b, i*2+1, m+1, hi)
    combine(left, right)
  end

  def leaf(num)
    num
  end

  private

  def build(nums, i, lo, hi)
    if lo == hi
      @nodes[i] = leaf(nums[lo])
    else
      m = (lo+hi)/2
      build(nums, i*2, lo, m)
      build(nums, i*2+1, m+1, hi)
      @nodes[i] = combine(@nodes[i*2], @nodes[i*2+1])
    end
  end

  def initialize(nums)
    @size = nums.size
    n = tree_size(@size)
    @nodes = Array.new(n)
    build(nums, 1, 0, @size-1)
  end

  def tree_size(n)
    s = 1
    s <<= 1 while s < n
    s << 1
  end
end


# Compute the sum of all numbers of given range.
# (a + b) + c === a + (b + c)

class SumSegmentTree < SegmentTree

  def combine(left, right)
    left + right
  end
end


# Find the maximum of given range.
# max(max(a, b), c) === max(a, max(b, c))

class MaxSegmentTree < SegmentTree

  def combine(left, right)
    [left, right].max
  end
end


# Find the maximum and the number of times it appears of given range.

class MaxAndCountSegmentTree < SegmentTree

  def leaf(num)
    [num, 1]
  end

  def combine(left, right)
    return left if left.first > right.first
    return right if right.first > left.first
    [left.first, left.last+right.last]
  end
end


# Compute the GCD of all numbers of given ranges.
# gcd(gcd(a, b), c) === gcd(a, gcd(b, c))

class GCDSegmentTree < SegmentTree

  def combine(left, right)
    left.gcd(right)
  end
end


# Find the number of zeros in a given range, and additionally find the
# index of the k-th zero using a second function.

class KthZeroSegmentTree < SegmentTree

  def leaf(num)
    num == 0 ? 1 : 0
  end

  def combine(left, right)
    left + right
  end

  def kth(k, i=1, lo=0, hi=@size-1)
    return if k > @nodes[i]
    return lo if lo == hi
    m = (lo+hi)/2
    if k <= @nodes[i*2]
      kth(k, i*2, lo, m)
    else
      kth(k-@nodes[i*2], i*2+1, m+1, hi)
    end
  end
end


# Searching for an array prefix with a given amount: for a given value
# x we have to quickly find smallest index i such that the sum of the
# first i elements of the array is greater or equal to x, assuming
# that the array only contains non-negative values.

class PrefixSumSegmentTree < SegmentTree

  def combine(left, right)
    left + right
  end

  def search(sum, i=1, lo=0, hi=@size-1)
    return if sum > @nodes[i]
    return lo if lo == hi
    m = (lo+hi)/2
    if sum <= @nodes[i*2]
      search(sum, i*2, lo, m)
    else
      search(sum-@nodes[i*2], i*2+1, m+1, hi)
    end
  end
end


# Finding subsegments with the maximal sum of given range.
#
# Given: [-1, 2, 3, -4], the segment tree:
#               0/4/1/5 (sum/pref/suff/max)
#             /        \
#       1/1/2/2        -1/3/-1/3
#       /     \         /     \
# -1/-1/-1/-1 2/2/2/2  3/3/3/3  -4/-4/-4/-4

class MaxSumSegmentTree < SegmentTree

  def leaf(num)
    {
      sum: num,
      pref: num,
      suff: num,
      max: num
    }
  end

  def combine(left, right)
    {
      sum: left[:sum] + right[:sum],
      pref: [left[:pref], left[:sum]+right[:pref]].max,
      suff: [right[:suff], right[:sum]+left[:suff]].max,
      max: [left[:max], right[:max], left[:suff]+right[:pref]].max
    }
  end
end


# For this Segment Tree, in each vertex we store a sorted list of all
# numbers occurring in the corresponding segment, similar to merge
# sort algorithm. The qurey is to find the minimum number greater than
# or equal to a given number x.
#
# You can't use the update api in this implementation. If you do,
# the list for each interval node clearly isn't efficient enough for
# delete/add operations. One can use multiset if using C++, but in
# Ruby there is no build-in multiset, so I'll not implement it here.

class MergeSortTree < SegmentTree

  def leaf(num)
    [num]
  end

  def combine(left, right)
    left, right= right, left if left.size > right.size
    m, n = left.size, right.size
    i = j = 0
    [].tap do |r|
      while i < m || j < n
        if i == m || (j != n && left[i] > right[j])
          r << right[j]
          j += 1
        else
          r << left[i]
          i += 1
        end
      end
    end
  end

  def search(x, a, b, i=1, lo=0, hi=@size-1)
    return @nodes[i].bsearch { |n| n >= x } if a == lo && b == hi
    m = (lo+hi)/2
    return search(x, a, b, i*2, lo, m) if b <= m
    return search(x, a, b, i*2+1, m+1, hi) if a > m
    left = search(x, a, m, i*2, lo, m)
    right = search(x, m+1, b, i*2+1, m+1, hi)
    [left, right].compact.min
  end
end
