# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=169 lang=ruby
#
# [169] Majority Element
#
# https://leetcode.com/problems/majority-element/description/
#
# Given an array of size n, find the majority element. The majority
# element is the element that appears more than ⌊ n/2 ⌋ times.
#
# You may assume that the array is non-empty and the majority element
# always exist in the array.
#
# Example 1:
#
# Input: [3,2,3]
# Output: 3
#
# Example 2:
#
# Input: [2,2,1,1,1,2,2]
# Output: 2


# Using Hash.

# @param {Integer[]} nums
# @return {Integer}
def majority_element_a(nums)
  freq, max_f, max_n = Hash.new(0), 0
  nums.each do |n|
    freq[n] += 1
    max_f, max_n = freq[n], n if freq[n] > max_f
  end
  max_n
end


# Using Boyer-Moore majority vote algorithm, see:
#
#   https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm
#
# However even when the input sequence has no majority, the algorithm
# will report one of the sequence elements as its result, but that's
# not a problem since this problem guarantee to have one.

def majority_element(nums)
  i, m = 0
  nums.each do |x|
    if i == 0
      m = x
      i = 1
    elsif m == x
      i += 1
    else
      i -= 1
    end
  end
  m
end
