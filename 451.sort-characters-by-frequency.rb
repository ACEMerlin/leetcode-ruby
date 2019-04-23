# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=451 lang=ruby
#
# [451] Sort Characters By Frequency
#
# https://leetcode.com/problems/sort-characters-by-frequency/description/
#
# Given a string, sort it in decreasing order based on the frequency
# of characters.
#
# Example 1:
#
# Input:
# "tree"
# Output:
# "eert"
# Explanation:
# 'e' appears twice while 'r' and 't' both appear once. So 'e' must
# appear before both 'r' and 't'. Therefore "eetr" is also a valid
# answer.
#
# Example 2:
#
# Input:
# "cccaaa"
# Output:
# "cccaaa"
# Explanation:
# Both 'c' and 'a' appear three times, so "aaaccc" is also a valid
# answer. Note that "cacaca" is incorrect, as the same characters must
# be together.
#
# Example 3:
#
# Input:
# "Aabb"
# Output:
# "bbAa"
# Explanation:
# "bbaA" is also a valid answer, but "Aabb" is incorrect. Note that
# 'A' and 'a' are treated as two different characters.


# Bucket sort.

# @param {String} s
# @return {String}
def frequency_sort(s)
  freq = s.chars.reduce(Hash.new(0)) { |h, k| h[k] += 1; h }
  buckets = Array.new(s.size+1) {[]}
  freq.each { |n, c| buckets[c] << n }
  ans = ""
  buckets.each_with_index do |a, i|
    a.each do |c|
      ans << c*i
    end
  end
  ans.reverse
end
