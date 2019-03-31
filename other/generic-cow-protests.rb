# Farmer John's N (1 <= N <= 100,000) cows are lined up in a row and
# numbered 1..N. The cows are conducting another one of their strange
# protests, so each cow i is holding up a sign with an integer A_i
# (-10,000 <= A_i <= 10,000).
#
# FJ knows the mob of cows will behave if they are properly grouped
# and thus would like to arrange the cows into one or more contiguous
# groups so that every cow is in exactly one group and that every
# group has a nonnegative sum.
#
# Help him count the number of ways he can do this, modulo
# 1,000,000,009.
#
# Example:
#
# Input: [2, 3, -3, 1]
# Output: 4, and the following are the only four valid ways of
# arranging the cows:
# (2 3 -3 1)
# (2 3 -3) (1)
# (2) (3 -3 1)
# (2) (3 -3) (1)


# Very similar to leetcode problem 315, we can solve it using Fenwick
# Tree. Why? Let's see:
#
#   1. S[i] is the prefix sum up to the given point i.
#      S[-1] == 0, it's convenient for i==0.
#      - sum(i, j)=S[j]-S[i-1].
#   2. Then we need to define what's a 'cut': given a fixed index j, a
#      cut is an index i<=j which makes:
#        sum(i, j)>=0 => S[j]-S[i-1]>=0 => S[j]>=S[i-1] && S[i-1]>=0.
#      if F[i] stands for the valid ways of partitioning the sub array
#      a[0..i], then F[j] would be the sum of all F[i]s in 0<=i<=j
#      which makes a cut. Does this "range sum"-ish thing sounds
#      familiar? Yeah, Fenwick Tree it is.
#   3. Also we need to do coordinate compression on S as the indices for
#      the Fenwick Tree, we can do this by sorting the unique values of
#      S and map each value to its index.
#
#  E.g. cows: [2,3,-3,1], S: [2,5,2,3]. R: {0:0, 2:1, 3:2, 5:3}
#
#  5 | |    | |    |2|     |2|          |2|
#  3 | |    | |    | |     | |          |4|
#  2 | | => |1| => |1|  => |3|     =>   |3|
#  0 |1|    |1|    |1|     |1|          |1|
#
#  f(0)    f(1)   f(3)    f(1)         f(2)   # f(i): before insert new prefix sum
#
#    ()     (2)   (2)(3) (2)(3,-3)     (2)(3,-3)(1)
#                 (2,3)  (2,3,-3)      (2,3,-3)(1)
#                                      (2)(3,-3,1)
#                                      (2,3,-3,1)
#    1       1      2       2            4

require 'set'

def generic_cow_protests(cows)
  s = cows.inject([]) { |a, c| a << (a[-1]||0)+c } << 0
  r = {}.tap { |r| Set.new(s).sort.each_with_index { |c, i| r[c] = i } }
  bit, ans = BIT.new(r.size), 0
  bit.update(r[0], 1)
  cows.size.times do |i|
    ans = bit.range_sum(r[0], r[s[i]])
    bit.update(r[s[i]], ans%1000000009)
  end
  ans
end


class BIT

  def initialize(arg)
    @size = arg + 1
    @table = Array.new(@size, 0)
  end

  def update(i, delta)
    i += 1
    while i < @size
      @table[i] += delta
      i += lowest_one_bit(i)
    end
  end

  def sum(i)
    i += 1
    sum = 0
    while i > 0
      sum += @table[i]
      i -= lowest_one_bit(i)
    end
    sum
  end

  def range_sum(i, j)
    sum(j) - sum(i-1)
  end

  private

  def lowest_one_bit(i)
    i & -i
  end
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_cows
    assert_equal generic_cow_protests([2,3,-3,1]), 4
    assert_equal generic_cow_protests([10,7,-4,-8,8,3,4,10,10]), 88
  end
end
