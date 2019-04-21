# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=123 lang=ruby
#
# [123] Best Time to Buy and Sell Stock III
#
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock-iii/description/
#
# Say you have an array for which the ith element is the price of a
# given stock on day i.
#
# Design an algorithm to find the maximum profit. You may complete at
# most two transactions.
#
# Note: You may not engage in multiple transactions at the same time
# (i.e., you must sell the stock before you buy again).
#
# Example 1:
#
# Input: [3,3,5,0,0,3,1,4]
# Output: 6
# Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3),
# profit = 3-0 = 3. Then buy on day 7 (price = 1) and sell on day 8
# (price = 4), profit = 4-1 = 3.
#
# Example 2:
#
# Input: [1,2,3,4,5]
# Output: 4
# Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5),
# profit = 5-1 = 4. Note that you cannot buy on day 1, buy on day 2
# and sell them later, as you are engaging multiple transactions at
# the same time. You must sell before buying again.
#
# Example 3:
#
# Input: [7,6,4,3,1]
# Output: 0
# Explanation: In this case, no transaction is done, i.e. max profit = 0.


# Man It's really hard to explain this. The key:
#
#   1. Kadane's algorithm.
#   2. *AT MOST* 2 transactions.
#   3. left[i]: max profit of prices[0..i].
#   4. right[i]: max profit of prices[i-1..-1].
#   5. the answer'd be maximum of left[i]+right[i+1].

# @param {Integer[]} prices
# @return {Integer}
def max_profit(prices)
  n = prices.size
  sum, max, left = 0, -Float::INFINITY, Array.new(n, 0)
  (1..n-1).each do |i|
    sum += prices[i]-prices[i-1]
    max = [max, sum].max
    left[i] = max
    sum = [sum, 0].max
  end
  sum, max, right = 0, -Float::INFINITY, Array.new(n, 0)
  (n-1).downto(1).each do |i|
    sum += prices[i] - prices[i-1]
    max = [max, sum].max
    right[i] = max
    sum = [sum, 0].max
  end
  ans = -Float::INFINITY
  (0..n-2).each do |i|
    ans = [ans, left[i]+right[i+1]].max
  end
  ans
end


# From leetcode discussion, I don't fully understand it and I probably
# won't use it in an interview.

def max_profit(prices)
  buy1 = Float::INFINITY
  buy2 = Float::INFINITY
  profit1 = 0
  prices.reduce(0) do |total_profit, price|
    buy1 = [buy1, price].min
    profit1 = [profit1, price - buy1].max
    buy2 = [buy2, price - profit1].min
    [total_profit, price - buy2].max
  end
end
