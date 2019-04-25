# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=673 lang=ruby
#
# [673] Number of Longest Increasing Subsequence
#
# https://leetcode.com/problems/number-of-longest-increasing-subsequence/description/
#
# Given an unsorted array of integers, find the number of longest
# increasing subsequence.
#
# Example 1:
#
# Input: [1,3,5,4,7]
# Output: 2
# Explanation: The two longest increasing subsequence are [1, 3, 4, 7]
# and [1, 3, 5, 7].
#
# Example 2:
#
# Input: [2,2,2,2,2]
# Output: 5
# Explanation: The length of longest continuous increasing subsequence is 1,
# and there are 5 subsequences' length is 1, so output 5.
#
# Note:
#
# Length of the given array will be not exceed 2000 and the answer is
# guaranteed to be fit in 32-bit signed int.


# O(n^2).

# @param {Integer[]} nums
# @return {Integer}
def find_number_of_lis(nums)
  return 0 if nums.empty?
  n = nums.size
  d, count = Array.new(n, 1), Array.new(n, 1)
  (1..n-1).each do |i|
    (0..i-1).each do |j|
      if nums[j] < nums[i] && d[i] < d[j]+1
        d[i] = d[j]+1
        count[i] = count[j]
      elsif d[j]+1 == d[i]
        count[i] += count[j]
      end
    end
  end
  longest = d.max
  sum = 0
  count.each_with_index do |c, i|
    sum += c if d[i] == longest
  end
  sum
end
