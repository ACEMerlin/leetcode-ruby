# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=461 lang=ruby
#
# [461] Hamming Distance
#
# https://leetcode.com/problems/hamming-distance/description/
#
# The Hamming distance between two integers is the number of positions
# at which the corresponding bits are different.
#
# Given two integers x and y, calculate the Hamming distance.
#
# Note:
# 0 ≤ x, y < 231.
#
# Example:
#
# Input: x = 1, y = 4
# Output: 2
# Explanation:
# 1   (0 0 0 1)
# 4   (0 1 0 0)
# ⁠       ↑   ↑
#
# The above arrows point to positions where the corresponding bits are
# different.


# See Fenwick Tree for the idea behind (n & -n).

# @param {Integer} x
# @param {Integer} y
# @return {Integer}
def hamming_distance(x, y)
  n, count = x ^ y, 0
  while n > 0
    n -= (n & -n)
    count += 1
  end
  count
end
