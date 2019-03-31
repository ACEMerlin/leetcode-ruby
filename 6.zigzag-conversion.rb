# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=6 lang=ruby
#
# [6] ZigZag Conversion
#
# https://leetcode.com/problems/zigzag-conversion/description/
#
# The string "PAYPALISHIRING" is written in a zigzag pattern on a
# given number of rows like this: (you may want to display this
# pattern in a fixed font for better legibility)
#
# P   A   H   N
# A P L S I I G
# Y   I   R
#
# And then read line by line: "PAHNAPLSIIGYIR"
#
# Write the code that will take a string and make this conversion
# given a number of rows:
#
# string convert(string s, int numRows);
#
# Example 1:
# # 0, 4, 8, 12, 1, 3, 5, 7, 9, 11, 13, 2, 6, 10
# Input: s = "PAYPALISHIRING", numRows = 3
# Output: "PAHNAPLSIIGYIR"
#
#
# Example 2:
# (4 - 1 - 0) * 2 = 6
# (4 - 1 - 1) * 2 = 4    1 * 2 = 2
# (4 - 1 - 2) * 2 = 2    2 * 2 = 4
# (4 - 1 - 3) * 2 = 0    3 * 2 = 6
# # 0, 6, 12, 1, 5, 7, 11, 13, 2, 4, 8, 10, 3, 9
# Input: s = "PAYPALISHIRING", numRows = 4
# Output: "PINALSIGYAHRPI"
# Explanation:
#
# P     I    N
# A   L S  I G
# Y A   H R
# P     I


# @param {String} s
# @param {Integer} num_rows
# @return {String}
def convert(s, num_rows)
  return s if num_rows == 1
  indices = []
  for i in 0...num_rows
    m, n = (num_rows - 1 - i) * 2, i * 2
    j = i
    indices << j
    while j < s.length
      unless m.zero?
	j += m
	indices << j if j < s.length
      end
      unless n.zero?
	j += n
	indices << j if j < s.length
      end
    end
  end
  s.chars.values_at(*indices).join
end
