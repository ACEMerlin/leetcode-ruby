# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=166 lang=ruby
#
# [166] Fraction to Recurring Decimal
#
# https://leetcode.com/problems/fraction-to-recurring-decimal/description/
#
# Given two integers representing the numerator and denominator of a
# fraction, return the fraction in string format.
#
# If the fractional part is repeating, enclose the repeating part in
# parentheses.
#
# Example 1:
#
# Input: numerator = 1, denominator = 2
# Output: "0.5"
#
# Example 2:
#
# Input: numerator = 2, denominator = 1
# Output: "2"
#
# Example 3:
#
# Input: numerator = 2, denominator = 3
# Output: "0.(6)"


# 0. Determine the sign.
# 1. n is divisible by d, return sign+"n/d"
# 2. Otherwise do division till we meet a known remainder.

# @param {Integer} numerator
# @param {Integer} denominator
# @return {String}
def fraction_to_decimal(n, d)
  return "0" if n.zero?
  ans = (n<0) ^ (d<0) ? "-" : ""
  n, d = n.abs, d.abs
  a, b = n.divmod(d)
  return "#{ans}#{a}" if b.zero?
  ans << "#{a}."
  h = {}
  while !b.zero?
    if h.has_key?(b)
      ans.insert(h[b], "(")
      ans << ")"
      break
    end
    h[b] = ans.size
    a, b = (b*10).divmod(d)
    ans << a.to_s
  end
  ans
end
