# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=121 lang=ruby
#
# [121] Best Time to Buy and Sell Stock
#
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/
#
# Say you have an array for which the ith element is the price of a
# given stock on day i.
#
# If you were only permitted to complete at most one transaction
# (i.e., buy one and sell one share of the stock), design an algorithm
# to find the maximum profit.
#
# Note that you cannot sell a stock before you buy one.
#
# Example 1:
#
# Input: [7,1,5,3,6,4]
# Output: 5
# Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6),
# profit = 6-1 = 5. Not 7-1 = 6, as selling price needs to be larger
# than buying price.
#
# Example 2:
#
# Input: [7,6,4,3,1]
# Output: 0
# Explanation: In this case, no transaction is done, i.e. max profit = 0.


# We want prices[j]-prices[i](j>i) to be maximum:
#
#   1. Keep track of and update the minimum price up to the given
#      point (min), there are possible larger profit to its right.
#   2. Keep track of and update the current profit if it's larger.
#   3. The current profit at index i is prices[i]-min.

# @param {Integer[]} prices
# @return {Integer}
def max_profit_a(prices)
  i = 1
  max, min = 0, prices[0]
  while i < prices.size
    profit = prices[i] - min
    if profit > max
      max = profix
    elsif profit < 0
      min = prices[i]
    end
    i += 1
  end
  max
end


# You may not see this at first, but this problem is similar to
# problem 53:
#
#   1. Build an array of prices diff, diff[i] = prices[i]-prices[i-1].
#   2. The max profit is the maximum sum of diff's contiguous subarray.
#      I give you 7 dollars, you spend 5, make 4, you left with 6,
#      your profit is 4-5=-1=(7-5)-7+(7-5+4)-(7-5).

def max_profit_b(prices)
  diff = (1...prices.size).reduce([0]) do |a, i|
    a << prices[i] - prices[i-1]
  end
  max_sub_array(diff)
end

def max_sub_array(nums)
  ans = nums[0]
  sum = 0
  (0...nums.size).each do |i|
    sum += nums[i]
    ans = [ans, sum].max
    sum = [sum, 0].max
  end
  ans
end


# You don't need to build the diff array since you already know all diff[i].

def max_profit(prices)
  ans = sum = 0
  (1...prices.size).each do |i|
    sum += prices[i]-prices[i-1]
    ans = [ans, sum].max
    sum = [sum, 0].max
  end
  ans
end
