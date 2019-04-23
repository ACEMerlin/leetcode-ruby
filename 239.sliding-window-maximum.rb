# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=239 lang=ruby
#
# [239] Sliding Window Maximum
#
# https://leetcode.com/problems/sliding-window-maximum/description/
#
# Given an array nums, there is a sliding window of size k which is
# moving from the very left of the array to the very right. You can
# only see the k numbers in the window. Each time the sliding window
# moves right by one position. Return the max sliding window.
#
# Example:
#
# Input: nums = [1,3,-1,-3,5,3,6,7], and k = 3
# Output: [3,3,5,5,6,7]
# Explanation:
#
# Window position                Max
# ---------------               -----
# [1  3  -1] -3  5  3  6  7       3
# ⁠1 [3  -1  -3] 5  3  6  7       3
# ⁠1  3 [-1  -3  5] 3  6  7       5
# ⁠1  3  -1 [-3  5  3] 6  7       5
# ⁠1  3  -1  -3 [5  3  6] 7       6
# ⁠1  3  -1  -3  5 [3  6  7]      7
#
# Note:
# You may assume k is always valid, 1 ≤ k ≤ input array's size for non-empty
# array.
#
# Follow up:
# Could you solve it in linear time?


# See problem 862. Only this time we keep a bag of monotonically
# decreasing numbers.
#
#   1. If i < j and nums[i] < nums[j], then no matter what window
#      nums[i] is in, it won't contribute to the maximum number inside
#      that window. Se we need i < j && nums[i] >= nums[j].
#   2. We need to remove the first number from the bag when sliding to
#      the right if it equals the maximum number in the bag.

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}
def max_sliding_window(nums, k)
  q, ans, i = [], [], 0
  while i < nums.size
    q.pop while !q.empty? && q[-1] < nums[i]
    q << nums[i]
    q.shift if i >= k && nums[i-k] == q[0]
    ans << q[0] if i >= k-1
    i += 1
  end
  ans
end
