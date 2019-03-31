# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=719 lang=ruby
#
# [719] Find K-th Smallest Pair Distance
#
# https://leetcode.com/problems/find-k-th-smallest-pair-distance/description/
#
# Given an integer array, return the k-th smallest distance among all
# the pairs. The distance of a pair (A, B) is defined as the absolute
# difference between A and B.
#
# Example 1:
#
# Input:
# nums = [1,3,1]
# k = 1
# Output: 0
# Explanation:
# Here are all the pairs:
# (1,3) -> 2
# (1,1) -> 0
# (3,1) -> 2
# Then the 1st smallest distance pair is (1,1), and its distance is 0.


# 1. Sort the nums.
# 2. The minimum distance is 0 and the maximum is a[-1]-a[0].
# 3. Binary search on min and max using how many paris have that distance.

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def smallest_distance_pair(nums, k)
  a = nums.sort
  lo, hi = 0, a[-1]-a[0]
  (lo..hi).bsearch do |dist|
    pairs_within_dist(a, dist) >= k
  end
end

# We can binary search the index j which makes a[j]-a[i]<=dist for all
# 0<=i<size.

def pairs_within_dist_a(a, dist)
  ans = 0
  (0...a.size).each do |i|
    ans += ((i+1...a.size).bsearch { |j| a[j] - a[i] > dist } || a.size) - (i+1)
  end
  ans
end

# Or we can use sliding window:
#   1. Why binary search is slow in this case? for a fixed i, let j be
#      the last index which makes a[j]-a[i] <= dist, then
#      (i,i+1),(i,i+1),...,(i,j) are the pairs <= dist, then for i+1,
#      there is no need to check (i+1,i+2),...,(i+1,j), because its
#      definitely smaller than dist.
#   2. We keep a sliding window of [i, j], for every 0<=j<size, i is the
#      smallest index such that a[j]-a[i]<=dist, then the number of pairs
#      with j as its right-most endpoint is j-i.

def pairs_within_dist(a ,dist)
  ans, i = 0, 0
  (1...a.size).each do |j|
    i += 1 while a[j] - a[i] > dist
    ans += j - i
  end
  ans
end
