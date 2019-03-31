# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=560 lang=ruby
#
# [560] Subarray Sum Equals K
#
# https://leetcode.com/problems/subarray-sum-equals-k/description/
#
# Given an array of integers and an integer k, you need to find the
# total number of continuous subarrays whose sum equals to k.
#
# Example 1:
#
# Input:nums = [1,1,1], k = 2
# Output: 2
#
# Note: The length of the array is in range [1, 20,000]. The range of
# numbers in the array is [-1000, 1000] and the range of the integer k
# is [-1e7, 1e7].


# Hash+Prefix Sum
#
#   1. s is the prefix sum array, s[i]=nums[0]+...+nums[i-1].
#   2. Range sum from i to j: nums[i]+...nums[j]=s[j]-s[i-1].
#   3. So we want s[j]-s[i-1]==k, for all 0<=i<=j<=n-1. in other
#      words, we want s[j]-k=s[i-1], so we scan nums from left to
#      right, at each index j, we check how many s[j]-k exists before
#      j, and use hash to check it with efficiency ({ s[j]: count }).

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def subarray_sum(nums, k)
  h = Hash.new(0)
  h[0] = 1
  sum, count = 0, 0
  nums.each do |n|
    sum += n
    count += h[sum-k]
    h[sum] += 1
  end
  count
end
