# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=213 lang=ruby
#
# [213] House Robber II
#
# https://leetcode.com/problems/house-robber-ii/description/
#
# You are a professional robber planning to rob houses along a street.
# Each house has a certain amount of money stashed. All houses at this
# place are arranged in a circle. That means the first house is the
# neighbor of the last one. Meanwhile, adjacent houses have security
# system connected and it will automatically contact the police if two
# adjacent houses were broken into on the same night.
#
# Given a list of non-negative integers representing the amount of
# money of each house, determine the maximum amount of money you can
# rob tonight without alerting the police.
#
# Example 1:
#
# Input: [2,3,2]
# Output: 3
# Explanation: You cannot rob house 1 (money = 2) and then rob house 3
# (money = 2), because they are adjacent houses.
#
# Example 2:
#
# Input: [1,2,3,1]
# Output: 4
# Explanation: Rob house 1 (money = 1) and then rob house 3 (money =
# 3). Total amount you can rob = 1 + 3 = 4.


# @param {Integer[]} nums
# @return {Integer}
def rob(nums)
  return 0 if nums.empty?
  return nums[0] if nums.size == 1
  [sub_rob(nums[1..-1]), sub_rob(nums[0..-2])].max
end

def sub_rob(nums)
  d2 = d1 = 0
  nums.each do |n|
    d1, d2 = [d2+n, d1].max, d1
  end
  d1
end
