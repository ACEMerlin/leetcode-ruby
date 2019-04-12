# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=76 lang=ruby
#
# [76] Minimum Window Substring
#
# https://leetcode.com/problems/minimum-window-substring/description/
#
# Given a string S and a string T, find the minimum window in S which
# will contain all the characters in T in complexity O(n).
#
# Example:
#
# Input: S = "ADOBECODEBANC", T = "ABC"
# Output: "BANC"
#
# Note:
#
# If there is no such window in S that covers all characters in T, return the
# empty string "".
# If there is such window, you are guaranteed that there will always be only
# one unique minimum window in S.


# I really don't like this kind of problem...
# Interesting problem? Yes. Interesting to code? Nope.

# @param {String} s
# @param {String} t
# @return {String}
def min_window_naive(s, t)
  return '' if t == '' || s.size < t.size
  h = t.chars.reduce(Hash.new(0)) { |h, c| h[c] += 1; h }
  i, j, ans = 0, 0
  need = t.size
  while j < s.length
    while j < s.length && need > 0
      if h.has_key?(s[j])
        need -= 1 if h[s[j]] > 0
        h[s[j]] -= 1
      end
      j += 1
    end
    return '' if ans.nil? && j == s.length && need > 0
    j -= 1
    while i <= j && need == 0
      if h.has_key?(s[i])
        need += 1 if h[s[i]] >= 0
        h[s[i]] += 1
      end
      i += 1
    end
    ans = s[i-1..j] if ans.nil? || j-i+2 < ans.size
    j += 1
  end
  ans
end

def min_window(s, t)
  return "" if t == "" || s.size < t.size
  h = t.chars.reduce(Hash.new(0)) { |h, c| h[c] += 1; h }
  i, need, ans = 0, t.size
  (0..s.size-1).each do |j|
    if h.has_key?(s[j])
      need -= 1 if h[s[j]] > 0
      h[s[j]] -= 1
    end
    while need == 0
      if h.has_key?(s[i])
        if h[s[i]] >= 0
          need += 1 if h[s[i]] >= 0
          ans = s[i..j] if ans.nil? || j-i+1 < ans.size
        end
        h[s[i]] += 1
      end
      i += 1
    end
  end
  ans || ''
end
