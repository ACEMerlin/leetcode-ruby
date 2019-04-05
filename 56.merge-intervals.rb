# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=56 lang=ruby
#
# [56] Merge Intervals
#
# https://leetcode.com/problems/merge-intervals/description/
#
# Given a collection of intervals, merge all overlapping intervals.
#
# Example 1:
#
# Input: [[1,3],[2,6],[8,10],[15,18]]
# Output: [[1,6],[8,10],[15,18]]
# Explanation: Since intervals [1,3] and [2,6] overlaps, merge them
# into [1,6].
#
# Example 2:
#
# Input: [[1,4],[4,5]]
# Output: [[1,5]]
# Explanation: Intervals [1,4] and [4,5] are considered overlapping.
#
# Definition for an interval.
# class Interval
#     attr_accessor :start, :end
#     def initialize(s=0, e=0)
#         @start = s
#         @end = e
#     end
# end


# @param {Interval[]} intervals
# @return {Interval[]}
def merge_a(intervals)
  helper(intervals.sort_by { |i| [i.start, i.end] }, 0)
end

def helper(intervals, i)
  return intervals if i == intervals.length-1 || intervals.empty?
  if intervals[i+1].start == intervals[i].start
    intervals.delete_at(i)
    helper(intervals , i)
  elsif intervals[i].end < intervals[i+1].start
    helper(intervals, i+1)
  else
    intervals[i].end = [intervals[i+1].end, intervals[i].end].max
    intervals.delete_at(i+1)
    helper(intervals, i)
  end
end


# I first come up with above recursive algo, then rewrite it iteratively
# The idea is simple, sort it first then merge one by one.
#
# given [[1, 2], [1, 5], [2, 6], [7, 8]]
#     ~ [[1, 5], [2, 6], [7, 8]]        (1 == 1)
#     ~ [[1, 6], [7, 8]]                (2 < 5, pick max(5, 6))
#     ~ same                            (6 < 7)

def merge(intervals)
  return [] if intervals.empty?
  intervals.sort_by!(&:start)
  [intervals.first].tap do |r|
    intervals[1..-1].each do |i|
      if r[-1].end < i.start
        r << i
      else
        r[-1].end = [i.end, r[-1].end].max
      end
    end
  end
end


# As you can see the key idea is to sort the intervals by 'start'.
# When the interviewer ask you what if we can't do sorting, the answer
# would be using BSTs, they are designed for keeping a list of sorted
# item dynamically.
#
# However Ruby doesn't have any build-in sorted collections. Java has
# TreeSet/TreeMap; C++ has map/set. So I'm not going to implement it
# here, see data-structures/treap.rb for a demo BST implementaton.
#
# C++ version if you're still interested: https://ideone.com/B7tkGs
#
# Another variation of the problem, see other/merget-two-intervals.rb
