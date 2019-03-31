# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=88 lang=ruby
#
# [88] Merge Sorted Array
#
# https://leetcode.com/problems/merge-sorted-array/description/
#
# Given two sorted integer arrays nums1 and nums2, merge nums2 into
# nums1 as one sorted array.
#
# Note:
#
# The number of elements initialized in nums1 and nums2 are m and n
# respectively. You may assume that nums1 has enough space (size that
# is greater or equal to m + n) to hold additional elements from
# nums2.
#
# Example:
#
# Input:
# nums1 = [1,2,3,0,0,0], m = 3
# nums2 = [2,5,6],       n = 3
# Output: [1,2,2,3,5,6]


# @param {Integer[]} nums1
# @param {Integer} m
# @param {Integer[]} nums2
# @param {Integer} n
# @return {Void} Do not return anything, modify nums1 in-place instead.
def merge(nums1, m, nums2, n)
  i, j, k = m-1, n-1, m+n-1
  until i < 0 || j < 0
    if nums1[i] > nums2[j]
      nums1[k] = nums1[i]
      i -= 1
    else
      nums1[k] = nums2[j]
      j -= 1
    end
    k -= 1
  end
  until j < 0
    nums1[k] = nums2[j]
    k -= 1
    j -= 1
  end
end
