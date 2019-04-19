# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=204 lang=ruby
#
# [204] Count Primes
#
# https://leetcode.com/problems/count-primes/description/
#
# Count the number of prime numbers less than a non-negative number, n.
#
# Example:
#
# Input: 10
# Output: 4
# Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.


# @param {Integer} n
# @return {Integer}
def count_primes(n)
  primes = Array.new(n, true)
  (2...Math.sqrt(n)).each do |i|
    next if !primes[i]
    (i*i..n-1).step(i).each do |j|
      primes[j] = false
    end
  end
  primes[2..(n-1)]&.count(true) || 0
end


# Ruby

require 'prime'

def count_primes(n)
  Prime.each(n-1).count
end
