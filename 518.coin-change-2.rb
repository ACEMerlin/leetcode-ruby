# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=518 lang=ruby
#
# [518] Coin Change 2
#
# https://leetcode.com/problems/coin-change-2/description/
#
# You are given coins of different denominations and a total amount of
# money. Write a function to compute the number of combinations that
# make up that amount. You may assume that you have infinite number of
# each kind of coin.
#
# Example 1:
#
# Input: amount = 5, coins = [1, 2, 5]
# Output: 4
# Explanation: there are four ways to make up the amount:
# 5=5
# 5=2+2+1
# 5=2+1+1+1
# 5=1+1+1+1+1
#
# Example 2:
#
# Input: amount = 3, coins = [2]
# Output: 0
# Explanation: the amount of 3 cannot be made up just with coins of 2.
#
# Example 3:
#
# Input: amount = 10, coins = [10]
# Output: 1
# Note: You can assume that
#
# 0 <= amount <= 5000
# 1 <= coin <= 5000
# the number of coins is less than 500
# the answer is guaranteed to fit into signed 32-bit integer


# To simplify this problem for my brain, I think of this problem as
# Integer partition. Integer partition is number of ways a number can
# be represented as sum of positive integers. e.g. 4 => 4 / 3+1 / 2+2
# / 2+1+1 / 1+1+1+1, so there are 4 ways, also 3+1 and 1+3 are
# considered as only one. you can imagine a big table of size N*N
# where N is size of all natural number, e.g. table[4][4] = 4, so it
# contains all the solutions for any combination of coins and given
# amount. now intead of all natural number, you're given only some
# certain integers, aka coins.

# for coins: [2,3,5], sum: 7, we represent it as f([2,3,5],7)

# |   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
# |---+---+---+---+---+---+---+---+---|
# | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
# | 2 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 |
# | 3 | 1 | 0 | 1 | 1 | 1 | 1 | 2 | 1 |
# | 5 | 1 | 0 | 1 | 1 | 1 | 2 | 2 | 2 |

# f([0],0) == 1 because 0 add up to 0, f([0],0..7) == 0 because you
# can't add up to any number using only 0, if sum < new_coin then
# f([0,..,new_coin],sum) = f([0,..], sum) because we just can't use
# the new coin, e.g. f([0,2,3],2) is the same as f([0,2],2), otherwise
# e.g. f([0,2,3,5],7) = f([0,2,3],7) + f([0,2,3,5],7-5).

# @param {Integer} amount
# @param {Integer[]} coins
# @return {Integer}
def change(amount, coins)
  dp = Array.new(coins.length+1) { Array.new(amount+1,0) }
  dp[0][0] = 1
  (1..coins.length).each do |i|
    (0..amount).each do |j|
        dp[i][j] = dp[i-1][j] + (j < coins[i-1] ? 0 : dp[i][j-coins[i-1]])
    end
  end
  dp[coins.length][amount]
end
