# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=134 lang=ruby
#
# [134] Gas Station
#
# https://leetcode.com/problems/gas-station/description/
#
# There are N gas stations along a circular route, where the amount of
# gas at station i is gas[i].
#
# You have a car with an unlimited gas tank and it costs cost[i] of
# gas to travel from station i to its next station (i+1). You begin
# the journey with an empty tank at one of the gas stations.
#
# Return the starting gas station's index if you can travel around the
# circuit once in the clockwise direction, otherwise return -1.
#
# Note:
#
# If there exists a solution, it is guaranteed to be unique.
# Both input arrays are non-empty and have the same length.
# Each element in the input arrays is a non-negative integer.
#
# Example 1:
#
# Input:
# gas  = [1,2,3,4,5]
# cost = [3,4,5,1,2]
# Output: 3
# Explanation:
# Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 +
# 4 = 4
# Travel to station 4. Your tank = 4 - 1 + 5 = 8
# Travel to station 0. Your tank = 8 - 2 + 1 = 7
# Travel to station 1. Your tank = 7 - 3 + 2 = 6
# Travel to station 2. Your tank = 6 - 4 + 3 = 5
# Travel to station 3. The cost is 5. Your gas is just enough to travel back to
# station 3.
# Therefore, return 3 as the starting index.
#
# Example 2:
#
# Input:
# gas  = [2,3,4]
# cost = [3,4,3]
# Output: -1
# Explanation:
# You can't start at station 0 or 1, as there is not enough gas to travel to
# the next station.
# Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 =
# 4
# Travel to station 0. Your tank = 4 - 3 + 2 = 3
# Travel to station 1. Your tank = 3 - 3 + 3 = 3
# You cannot travel back to station 2, as it requires 4 unit of gas but you
# only have 3.
# Therefore, you can't travel around the circuit once no matter where you
# start.


# Two key points:
#
#   1. If the sum of gas >= the sum of cost, then there must exists a solution.
#      I can't prove it tho. :(
#   2. If A can not reach C in a the sequence of A-->B-->C, then B can
#      not make it either. Proof:
#      If gas[A] < cost[A], then A can not even reach B. So to reach C
#      from A, gas[A] must >= cost[A]. Given that A can not reach C,
#      we have gas[A] + gas[B] < cost[A] + cost[B], and gas[A] >=
#      cost[A], Therefore, gas[B] < cost[B], i.e., B can not reach C.

# @param {Integer[]} gas
# @param {Integer[]} cost
# @return {Integer}
def can_complete_circuit(gas, cost)
  m, t, ans = 0, 0, 0
  gas.size.times do |i|
    diff = gas[i] - cost[i]
    t += diff
    m += diff
    if m  < 0
      m = 0
      ans = i+1
    end
  end
  t >= 0 ? ans : -1
end
