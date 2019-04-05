# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=57 lang=ruby
#
# [57] Insert Interval
#
# https://leetcode.com/problems/insert-interval/description/
#
# Given a set of non-overlapping intervals, insert a new interval into
# the intervals (merge if necessary).
#
# You may assume that the intervals were initially sorted according to
# their start times.
#
# Example 1:
#
# Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
# Output: [[1,5],[6,9]]
#
# Example 2:
#
# Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
# Output: [[1,2],[3,10],[12,16]]
# Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].
#
# Definition for an interval.
# class Interval
#     attr_accessor :start, :end
#     def initialize(s=0, e=0)
#         @start = s
#         @end = e
#     end
# end


# 1. Find first interval x that x.end >= new_interval.start, meaning
#    that x overlaps with new_interval.
# 2. Find first interval y that y.start > new_interval.end, meaning
#    that the y doesn't overlap with new_interval and previous interval
#    could overlap with y if it exists.
# 3. Intervals between x and y-1 are the overlapping intervals.

# @param {Interval[]} intervals
# @param {Interval} new_interval
# @return {Interval[]}
def insert(intervals, new_interval)
  n = intervals.size
  i = intervals.bsearch_index { |x| x.end >= new_interval.start } || n
  j = intervals.bsearch_index { |x| x.start > new_interval.end } || n
  new_interval.start = [new_interval.start, intervals[i].start].min if i < n
  new_interval.end = [new_interval.end, intervals[j-1].end].max if j > 0
  intervals[0...i] + [new_interval] + intervals[j..-1]
end
