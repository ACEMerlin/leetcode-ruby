# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=52 lang=ruby
#
# [52] N-Queens II
#
# https://leetcode.com/problems/n-queens-ii/description/
#
# The n-queens puzzle is the problem of placing n queens on an n×n
# chessboard such that no two queens attack each other.
#
# Given an integer n, return the number of distinct solutions to the
# n-queens puzzle.
#
# Example:
#
# Input: 4
# Output: 2
# Explanation: There are two distinct solutions to the 4-queens puzzle as shown
# below.
# [
# [".Q..",  // Solution 1
# "...Q",
# "Q...",
# "..Q."],
#
# ["..Q.",  // Solution 2
# "Q...",
# "...Q",
# ".Q.."]
# ]


# WTF leetcode, it's the same as problem 51...

# @param {Integer} n
# @return {Integer}
def total_n_queens(n)
  permute((0...n).to_a)
end

def permute(a, k=0, ans=[0], diags=Set.new)
  n = a.size
  if k == n
    ans[0] += 1
    return
  end
  (k...n).each do |i|
    next if !valid_move(a, k, i, diags) # k: row, a[i]: column
    swap(a, k, i)
    make_move(a, k, diags)
    permute(a, k+1, ans, diags)
    undo_move(a, k, diags)
    swap(a, k, i)
  end
  ans[0]
end

def swap(a, i, j)
  a[i], a[j] = a[j], a[i]
end

def make_move(a, k, diags)
  diags << a[k]+k << a[k]-k-a.size-1
end

def undo_move(a, k, diags)
  diags.delete(a[k]+k)
  diags.delete(a[k]-k-a.size-1)
end

def valid_move(a, k, i, diags)
  !diags.include?(a[i]-k-a.size-1) && !diags.include?(a[i]+k)
end
