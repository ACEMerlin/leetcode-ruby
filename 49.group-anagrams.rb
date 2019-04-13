# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=49 lang=ruby
#
# [49] Group Anagrams
#
# https://leetcode.com/problems/group-anagrams/description/
#
# Given an array of strings, group anagrams together.
#
# Example:
#
# Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
# Output:
# [
# ⁠ ["ate","eat","tea"],
# ⁠ ["nat","tan"],
# ⁠ ["bat"]
# ]
#
# Note:
#
# All inputs will be in lowercase.
# The order of your output does not matter.


# Ruby can use mutable object as hash key.

# @param {String[]} strs
# @return {String[][]}
def group_anagrams_a(strs)
  strs.map { |x| [x, x.chars.reduce(Hash.new(0)) { |h, c| h[c] += 1; h }] }
    .group_by(&:last).map { |k, vs| vs.map { |v| v.first } }
end


# Or use sorted string as identifier.

def group_anagrams(strs)
  strs.group_by { |s| s.chars.sort }.values
end
