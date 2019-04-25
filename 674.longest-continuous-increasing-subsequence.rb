# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=674 lang=ruby
#
# [674] Longest Continuous Increasing Subsequence
#
# https://leetcode.com/problems/longest-continuous-increasing-subsequence/description/
#
# Given an unsorted array of integers, find the length of longest
# continuous increasing subsequence (subarray).
#
# Example 1:
#
# Input: [1,3,5,4,7]
# Output: 3
# Explanation: The longest continuous increasing subsequence is
# [1,3,5], its length is 3. Even though [1,3,5,7] is also an
# increasing subsequence, it's not a continuous one where 5 and 7 are
# separated by 4.
#
# Example 2:
#
# Input: [2,2,2,2,2]
# Output: 1
# Explanation: The longest continuous increasing subsequence is [2],
# its length is 1.
#
# Note: Length of the array will not exceed 10,000.


# @param {Integer[]} nums
# @return {Integer}
def find_length_of_lcis(nums)
  return 0 if nums.empty?
  i = j = 0
  ans = 1
  while j < nums.size
    if j == nums.size-1 || nums[j] >= nums[j+1]
      ans = [ans, j-i+1].max
      i = j = j+1
    else
      j += 1
    end
  end
  ans
end
