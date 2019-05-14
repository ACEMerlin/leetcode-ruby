# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=202 lang=ruby
#
# [202] Happy Number
#
# https://leetcode.com/problems/happy-number/description/
#
# Write an algorithm to determine if a number is "happy".
#
# A happy number is a number defined by the following process: Starting with
# any positive integer, replace the number by the sum of the squares of its
# digits, and repeat the process until the number equals 1 (where it will
# stay), or it loops endlessly in a cycle which does not include 1. Those
# numbers for which this process ends in 1 are happy numbers.
#
# Example:
#
# Input: 19
# Output: true
# Explanation:
# 12 + 92 = 82
# 82 + 22 = 68
# 62 + 82 = 100
# 12 + 02 + 02 = 1


# Using Hash.

# @param {Integer} n
# @return {Boolean}
def is_happy(n)
  h = Set.new
  x = f(n)
  while x != 1
    puts x
    return false if h.include?(x)
    h << x
    x = f(x)
  end
  true
end

def f(n)
  n.digits.reduce(0) { |s, x| s += x*x }
end


# Floyd Cycle detection algorithm.
#
# See: https://en.wikipedia.org/wiki/Cycle_detection

def is_happy(n)
  t = f(n)
  h = f(f(n))
  while t != h
    t = f(t)
    h = f(f(h))
  end
  return t == 1
end

def f(n)
  n.digits.reduce(0) { |s, x| s += x*x }
end
