# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=163 lang=ruby
#
# [163] Missing Ranges
#
# https://leetcode.com/problems/missing-ranges/description/
#
# Given a sorted integer array where the range of elements are in the
# inclusive range [lower, upper], return its missing ranges.
#
# For example, given [0, 1, 3, 50, 75], lower = 0 and upper = 99,
# return ["2", "4->49", "51->74", "76->99"].

def find_missing_ranges(nums, lower, upper)
  return [] if nums.empty? || upper < nums[0] || lower > nums[-1]
  ans = []
  nums.each_with_index do |n, i|
    break if n > upper
    if lower < n
      ans << range_str(lower, [n-1, upper].min)
      lower = nums[i]+1
    elsif lower == n
      lower += 1
    end
  end
  ans << range_str(lower, upper) if lower <= upper
  ans
end

def range_str(a, b)
  a == b ? a.to_s : "#{a}->#{b}"
end
