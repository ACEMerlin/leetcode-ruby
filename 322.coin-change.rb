# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=322 lang=ruby
#
# [322] Coin Change
#
# https://leetcode.com/problems/coin-change/description/
#
# You are given coins of different denominations and a total amount of
# money amount. Write a function to compute the fewest number of coins
# that you need to make up that amount. If that amount of money cannot
# be made up by any combination of the coins, return -1.
#
# Example 1:
#
# Input: coins = [1, 2, 5], amount = 11
# Output: 3
# Explanation: 11 = 5 + 5 + 1
#
# Example 2:
#
# Input: coins = [2], amount = 3
# Output: -1
# Note: You may assume that you have an infinite number of each kind
# of coin.


# $i represent the answer to when total amount is i.
# Then: $i: min($(i-{for x in coins if x<=i}))+1
#
# e.g.
# [1,2,5] 11

# $0: => 0
# $1: $(1-1)+1=1 => 1
# $2: $(2-1)+1=2 / $(2-2)+1=1 => 1
# $3: $(3-1)+1=2 / $(3-2)+1=2 => 2
# $4: $(4-1)+1=3 / $(4-2)+1=2 => 2
# $5: $(5-1)+1=3 / $(5-2)+1=3 / $(5-5)+1=1 => 1
# $6: $(6-1)+1=2 / $(6-2)+1=3 / $(6-5)+1=2 => 2
# $7: $(7-1)+1=3 / $(7-2)+1=2 / $(7-5)+1=2 => 2
# $8: $(8-1)+1=3 / $(8-2)+1=3 / $(8-5)+1=3 => 3
# $9: $(9-1)+1=4 / $(9-2)+1=3 / $(9-5)+1=3 => 3
# $10: $(10-1)+1=4 / $(10-2)+1=4 / $(10-5)+1=2 => 2
# $11: $(11-1)+1=3 / $(11-2)+1=4 / $(11-5)+1=3 => 3
# $i: min($(i-{for x in 1,2,5 if x<=i}))+1

# @param {Integer[]} coins
# @param {Integer} amount
# @return {Integer}
def coin_change(coins, amount)
  dp = Array.new(amount+1, Float::INFINITY)
  dp[0] = 0
  (1..amount).each do |i|
    coins.each do |c|
      dp[i] = [dp[i], dp[i-c]+1].min if i >= c
    end
  end
  dp[amount] == Float::INFINITY ? -1 : dp[amount]
end


# More FP flavor.

def coin_change_a(coins, amount)
  dp = [0]
  (1..amount).each do |i|
    dp[i] = coins.select { |x| x <= i }.map { |x| dp[i-x] }.compact.min&.+1
  end
  dp[amount] || -1
end
