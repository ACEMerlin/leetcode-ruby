# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=17 lang=ruby
#
# [17] Letter Combinations of a Phone Number
#
# https://leetcode.com/problems/letter-combinations-of-a-phone-number/description/
#
# Given a string containing digits from 2-9 inclusive, return all
# possible letter combinations that the number could represent.
#
# A mapping of digit to letters (just like on the telephone buttons)
# is given below. Note that 1 does not map to any letters.
#
# Example:
#
# Input: "23"
# Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
#
# Note:
#
# Although the above answer is in lexicographical order, your answer
# could be in any order you want.


# DFS.

# @param {String} digits
# @return {String[]}
def letter_combinations(digits)
  map = { "2" => ["a", "b", "c"],
         "3" => ["d", "e", "f"],
         "4" => ["g", "h", "i"],
         "5" => ["j", "k", "l"],
         "6" => ["m", "n", "o"],
         "7" => ["p", "q", "r", "s"],
         "8" => ["t", "u", "v"],
         "9" => ["w", "x", "y", "z"] }
  dfs(digits, map)
end

def dfs(digits, map, k=0, path="", paths=[])
  if k == digits.size
    paths << path.dup
  else
    map[digits[k]].each do |c|
      dfs(digits, map, k+1, path+c, paths)
    end
  end
  paths
end
