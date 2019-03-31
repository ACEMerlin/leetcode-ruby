# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=327 lang=ruby
#
# [327] Count of Range Sum
#
# https://leetcode.com/problems/count-of-range-sum/description/
#
# Given an integer array nums, return the number of range sums that
# lie in [lower, upper] inclusive. Range sum S(i, j) is defined as the
# sum of the elements in nums between indices i and j (i ≤ j),
# inclusive.
#
# Note: A naive algorithm of O(n2) is trivial. You MUST do better than
# that.
#
# Example:
#
# Input: nums = [-2,5,-1], lower = -2, upper = 2,
# Output: 3
# Explanation: The three ranges are : [0,0], [2,2], [0,2] and their
# respective sums are: -2, -1, 2.


# Similar to problem 315, we can use Fenwick Tree:
#
#   1. S[i] is the prefix sum up to the given point i.
#      S[-1] == 0, it's convenient for i==0.
#      - sum(i, j) = S[j] - S[i-1], we want:
#      - lower <= sum(i, j) <= upper, so that:
#      - lower + S[i-1] <= S[j] <= upper + S[i-1]
#      for all 0 <= i <= j < nums.size-1.
#      each [lower+S[i-1], S[i], S[i-1]+upper] for all i is a candidate.
#   2. R[x] is the rank of x in candidates.
#   3. P is the Fenwick tree for all candidates and it's using rank as index.
#      P[R[lower+S[i-1]], R[upper+S[i-1]]] is the current count of range
#      sum to the right of i. As it indicates that we should scan nums from
#      right to left (we need j >= i), at each index i, update current R[S[i]]
#      by 1, and add the current count of range sum to the result.
#   4. In the end, return the count number.

# @param {Integer[]} nums
# @param {Integer} lower
# @param {Integer} upper
# @return {Integer}
def count_range_sum(nums, lower, upper)
  s = nums.inject([]) { |a, n| a << (a[-1]||0)+n } << 0
  r, st = {}, Set.new
  (0...nums.size).each_with_index do |i|
    st << s[i] << lower+s[i-1] << upper+s[i-1]
  end
  st.sort.each_with_index { |n, i| r[n] = i }
  p, ret = BIT.new(r.size), 0
  (nums.size-1).downto(0) do |i|
    p.update(r[s[i]], 1)
    ret += p.range_sum(r[lower+s[i-1]], r[upper+s[i-1]])
  end
  ret
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
