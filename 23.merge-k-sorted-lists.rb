# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=23 lang=ruby
#
# [23] Merge k Sorted Lists
#
# https://leetcode.com/problems/merge-k-sorted-lists/description/
#
# Merge k sorted linked lists and return it as one sorted list.
# Analyze and describe its complexity.
#
# Example:
#
# Input:
# [
# 1->4->5,
# 1->3->4,
# 2->6
# ]
# Output: 1->1->2->3->4->4->5->6
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# Divide and Conquer. See https://www.coursera.org/learn/algorithms-divide-conquer.
#
# The method to analyse the time complexity is the same as merge sort.
#
#   1. Initailly there are k lists at level 1, we merge every 2 lists, now there
#      are k/2 lists at level 2. Same goes on: k/4, ..., logk.
#   2. At each level, the work being done is time proportional to the
#      size of all numbers N (n1+n2+n3+...+nk).
#   3. The total time complexity would be
#      work_at_each_level*number_of_levels: N*logk

# @param {ListNode[]} lists
# @return {ListNode}
def merge_k_lists(lists)
  return [] if lists.empty?
  while lists.size != 1
    lists = lists.each_slice(2).map do |a, b|
      merge_two_lists(a, b)
    end
  end
  lists[0]
end

def merge_two_lists(l1, l2)
  return l2 if l1.nil?
  return l1 if l2.nil?
  if l1.val <= l2.val
    l1.next = merge_two_lists(l1.next, l2)
    l1
  else
    l2.next = merge_two_lists(l1, l2.next)
    l2
  end
end
