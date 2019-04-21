# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1029 lang=ruby
#
# [1029] Two City Scheduling
#
# https://leetcode.com/problems/two-city-scheduling/description/
#
# There are 2N people a company is planning to interview. The cost of
# flying the i-th person to city A is costs[i][0], and the cost of
# flying the i-th person to city B is costs[i][1].
#
# Return the minimum cost to fly every person to a city such that
# exactly N people arrive in each city.
#
# Example 1:
#
# Input: [[10,20],[30,200],[400,50],[30,20]]
# Output: 110
# Explanation:
# The first person goes to city A for a cost of 10.
# The second person goes to city A for a cost of 30.
# The third person goes to city B for a cost of 50.
# The fourth person goes to city B for a cost of 20.
#
# The total minimum cost is 10 + 30 + 50 + 20 = 110 to have half the people
# interviewing in each city.
#
# Note:
#
# 1 <= costs.length <= 100
# It is guaranteed that costs.length is even.
# 1 <= costs[i][0], costs[i][1] <= 1000


# Cost of flying the i-th person to A instead of B:
#   d[i] = costs[i][0]-costs[i][1].
# if d[i] < 0, then we've saved -d[i] money.
# if d[i] > 0, then we've spent d[i] more money.
# we want to save the most amount for A then spend the rest for B.
# So sort by d[i], the first half is for A, the last half is for B.

# @param {Integer[][]} costs
# @return {Integer}
def two_city_sched_cost(costs)
  x = cost.sort_by { |(a, b)| a-b }
  m = costs.size/2-1
  x[0..m].sum { |a, _| a } + x[m+1..-1].sum { |_, b| b }
end
