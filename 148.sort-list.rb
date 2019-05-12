# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=148 lang=ruby
#
# [148] Sort List
#
# https://leetcode.com/problems/sort-list/description/
#
# Sort a linked list in O(n log n) time using constant space complexity.
#
# Example 1:
#
# Input: 4->2->1->3
# Output: 1->2->3->4
#
# Example 2:
#
# Input: -1->5->3->4->0
# Output: -1->0->3->4->5
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# Recursive.

# @param {ListNode} head
# @return {ListNode}
def sort_list(head)
  return head if head.nil? || head.next.nil?
  l1, l2 = split_list(head)
  merge_two_lists(sort_list(l1), sort_list(l2))
end

def split_list(head)
  slow, fast = head, head.next
  while !fast.nil? && !fast.next.nil?
    slow, fast = slow.next, fast.next.next
  end
  m, slow.next = slow.next, nil
  [head, m]
end

def merge_two_lists(l1, l2)
  return l1 if l2.nil?
  return l2 if l1.nil?
  if l1 < l2
    l1.next = merge_two_lists(l1.next, l2)
    l1
  else
    l2.next = merge_two_lists(l1, l2.next)
    l2
  end
end


# TODO
# O(1) space.
