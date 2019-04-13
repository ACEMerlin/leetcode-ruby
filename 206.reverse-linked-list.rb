# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=206 lang=ruby
#
# [206] Reverse Linked List
#
# https://leetcode.com/problems/reverse-linked-list/description/
#
# Reverse a singly linked list.
#
# Example:
#
# Input: 1->2->3->4->5->NULL
# Output: 5->4->3->2->1->NULL
#
# Follow up:
#
# A linked list can be reversed either iteratively or recursively.
# Could you implement both?


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
def reverse_list(head)
  return head if head.nil? || head.next.nil?
  p = reverse_list(head.next).next
  head.next.next = head
  head.next = nil
  p
end


# Iterative.
def reverse_list(head)
  cur, rev = head, nil
  while !cur.nil?
    rev, rev.next, cur = cur, rev, cur.next
  end
  rev
end
