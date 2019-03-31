# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=862 lang=ruby
#
# [862] Shortest Subarray with Sum at Least K
#
# https://leetcode.com/problems/shortest-subarray-with-sum-at-least-k/description/
#
# Return the length of the shortest, non-empty, contiguous subarray of
# A with sum at least K.
#
# If there is no non-empty subarray with sum at least K, return -1.
#
# Example 1:
#
# Input: A = [1], K = 1
# Output: 1
#
# Example 2:
#
# Input: A = [1,2], K = 4
# Output: -1
#
# Example 3:
#
# Input: A = [2,-1,2], K = 3
# Output: 3
#
# Note:
#
# 1 <= A.length <= 50000
# -10 ^ 5 <= A[i] <= 10 ^ 5
# 1 <= K <= 10 ^ 9


# Solution Bags
#
#   See: https://youtu.be/oaYsWnohXpA?t=139
#
# The idea:
#   1. Whats a bag? For a sub array a of size k+1, the bag b is:
#      {[0,a[0]+...a[k]],...,[i,a[i]+...+a[k]],...,[k,a[k]]}
#   2. When adding a new item x into a, we need to increment the bag
#      with this new item x: b[i][1] += x for all i.
#   3. Given array w of size n, we can generate all the bags by adding
#      one item at a time, and for each bag we have
#      {sum(0,j),...,sum(i,j),...,sum(j,j)}, and we can find the
#      minium length which makes sum(i,j)>=k.
#   4. The above method for now is still O(n^2), nothing spetial, but
#      if for each bag we can find some invariant to reduce its size,
#      we can have better time complexity:
#      -  if sum(i1, j)<sum(i2, j) and i1<i2 then there is no point of keeping
#         sum(i1, j) because sum(i2, j) is closer to our goal.
#      -  if we found that sum(i, j)>=k, then there is no point of keeping
#         it in the bag for later use because extending j makes j-i bigger
#         and we already have sum(i, j)>=k.
#   5. For each item, we add it to the bag once and remove from bag once, so the
#      total time complexity is O(N).

# @param {Integer[]} a
# @param {Integer} k
# @return {Integer}
def shortest_subarray(a, k)
  delta, q, min = 0, [], Float::INFINITY
  a.size.times do |j|
    delta += a[j]
    q.pop while !q.empty? && q[-1][1]+delta < a[j]
    q << [j, a[j]-delta]
    last = q.shift while !q.empty? && q[0][1]+delta >= k
    min = [min, j-last[0]+1].min if last
  end
  min == Float::INFINITY ? -1 : min
end
