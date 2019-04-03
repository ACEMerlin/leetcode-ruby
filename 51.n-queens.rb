# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=51 lang=ruby
#
# [51] N-Queens
#
# https://leetcode.com/problems/n-queens/description/
#
# The n-queens puzzle is the problem of placing n queens on an n×n
# chessboard such that no two queens attack each other.
#
# Given an integer n, return all distinct solutions to the n-queens puzzle.
#
# Each solution contains a distinct board configuration of the
# n-queens' placement, where 'Q' and '.' both indicate a queen and an
# empty space respectively.
#
# Example:
#
# Input: 4
# Output: [
# ⁠[".Q..",  // Solution 1
# ⁠ "...Q",
# ⁠ "Q...",
# ⁠ "..Q."],
#
# ⁠["..Q.",  // Solution 2
# ⁠ "Q...",
# ⁠ "...Q",
# ⁠ ".Q.."]
# ]
# Explanation: There exist two distinct solutions to the 4-queens puzzle as
# shown above.


# The problem with recursive programs:
#   1. It doesn't work. WHY?
#   2. Wow, it works. BUT WHY?

# See problem 46, we just need to check the diagonals.
# The checking is O(n).

# @param {Integer} n
# @return {String[][]}
def solve_n_queens(n)
  permute((0...n).to_a)
end

def permute(a, k=0, ans=[])
  n = a.size
  if k == n
    ans << a.map { |x| ("." * n).tap { |s| s[x] = 'Q' } }
    return
  end
  (k...n).each do |i|
    next if !valid_move(a, k, i) # k: row, a[i]: column
    swap(a, k, i)
    permute(a, k+1, ans)
    swap(a, k, i)
  end
  ans
end

def swap(a, i, j)
  a[i], a[j] = a[j], a[i]
end

def valid_move(a, k, i)
  (0...k).each do |j|
    return false if a[j]+j == a[i]+k || a[j]-j == a[i]-k
  end
  true
end


# We can do the checking in O(1).
#
#   1. Right diagonals have column + row == Constant.
#   2. Left diagonals have column - row == Constant.
#   3. Keep all diagonals in the same set by subtracting an offset of
#      n+1 from all left diagonals so that they are all negative and
#      won’t clash with right diagonals.

def solve_n_queens(n)
  permute((0...n).to_a)
end

def permute(a, k=0, ans=[], diags=Set.new)
  n = a.size
  if k == n
    ans << a.map { |x| ("." * n).tap { |s| s[x] = 'Q' } }
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
  ans
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
