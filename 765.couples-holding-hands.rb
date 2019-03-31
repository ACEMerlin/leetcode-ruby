# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=765 lang=ruby
#
# [765] Couples Holding Hands
#
# https://leetcode.com/problems/couples-holding-hands/description/
#
# N couples sit in 2N seats arranged in a row and want to hold hands.
# We want to know the minimum number of swaps so that every couple is
# sitting side by side. A swap consists of choosing any two people,
# then they stand up and switch seats.
#
# The people and seats are represented by an integer from 0 to 2N-1,
# the couples are numbered in order, the first couple being (0, 1),
# the second couple being (2, 3), and so on with the last couple being
# (2N-2, 2N-1).
#
# The couples' initial seating is given by row[i] being the value of
# the person who is initially sitting in the i-th seat.
#
# Example 1:
#
# Input: row = [0, 2, 1, 3]
# Output: 1
# Explanation: We only need to swap the second (row[1]) and third (row[2])
# person.
#
# Example 2:
#
# Input: row = [3, 2, 0, 1]
# Output: 0
# Explanation: All couples are already seated side by side.
#
# Note:
# ⁠
# ⁠len(row) is even and in the range of [4, 60].
# ⁠row is guaranteed to be a permutation of 0...len(row)-1.


# This problem seems interesting. Easy to write hard to prove.
# I'll look into this if I got interviewed.

# @param {Integer[]} row
# @return {Integer}
def min_swaps_couples(row)
  i, j = 0, 1
  count = 0
  while j < row.length
    if !is_cp(row, i, j)
      cp = other(row[i])
      swap(row, row.find_index(cp), j)
      count += 1
    end
    i += 2
    j += 2
  end
  count
end

def is_cp(row, i, j)
  row[j] == other(row[i])
end

def swap(row, i, j)
  row[i], row[j] = row[j], row[i]
end

def other(p)
  if p.odd?
    p-1
  else
    p+1
  end
end
