# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=280 lang=ruby
#
# [280] Wiggle Sort
#
# https://leetcode.com/problems/wiggle-sort/description/
#
# Given an unsorted array nums, reorder it in-place such that nums[0]
# <= nums[1] >= nums[2] <= nums[3]....
#
# For example, given nums = [3, 5, 2, 1, 6, 4], one possible answer is
# [1, 6, 2, 5, 3, 4].


def wiggle_sort(nums)
  i, j = 0, 1
  while j < nums.size
    if i.even?
      if nums[i] > nums[j]
        swap(nums, i, j)
      end
    else
      if nums[i] < nums[j]
        swap(nums, i, j)
      end
    end
    i += 1
    j += 1
  end
  nums
end

def swap(nums, i, j)
  nums[i], nums[j] = nums[j], nums[i]
end
