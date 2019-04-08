# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=69 lang=ruby
#
# [69] Sqrt(x)
#
# https://leetcode.com/problems/sqrtx/description/
#
# Implement int sqrt(int x).
#
# Compute and return the square root of x, where x is guaranteed to be
# a non-negative integer.
#
# Since the return type is an integer, the decimal digits are truncated and
# only the integer part of the result is returned.
#
# Example 1:
#
# Input: 4
# Output: 2
#
# Example 2:
#
# Input: 8
# Output: 2
# Explanation: The square root of 8 is 2.82842..., and since
# the decimal part is truncated, 2 is returned.


# Binary Search.

# @param {Integer} x
# @return {Integer}
def my_sqrt_a(x)
  (0..x).bsearch { |i| (i+1)**2 > x }
end


# Newton's method. See https://youtu.be/eCaXlAaN2uE?list=PLUl4u3cNGP61Oq3tWYp6V_F-5jb5L2iHb&t=1452
#
#   0. Given f(x)=x**2-a, we want to find x that f(x) == 0.
#   1. f(x2)-f(x1)=(x2-x1)*f'(x1)
#   2. we want f(x2)==0: f(x1)/f'(x1)=(x2-x1) => x2=x1-f(x1)/f'(x1) => x2=x1-(x1**2-a)/(2*x1)
#      => x2=(x1+(a/x1))/2

def my_sqrt(x)
  n = x
  n = (n+x/n)/2 while n*n > x
  n
end
