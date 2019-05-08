# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=19 lang=ruby
#
# [19] Remove Nth Node From End of List
#
# https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/
#
# Given a linked list, remove the n-th node from the end of list and
# return its head.
#
# Example:
#
# Given linked list: 1->2->3->4->5, and n = 2.
#
# After removing the second node from the end, the linked list becomes
# 1->2->3->5.
#
# Note:
#
# Given n will always be valid.
#
# Follow up:
#
# Could you do this in one pass?
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# Two pointers: fast and slow, fast is n steps faster than slow.
# The only edge case is to delete the first element.

# @param {ListNode} head
# @param {Integer} n
# @return {ListNode}
def remove_nth_from_end(head, n)
  fast = slow = head
  n.times { fast = fast.next }
  return head.next if fast.nil?
  slow, fast = slow.next, fast.next while !fast.next.nil?
  slow.next = slow.next.next
  head
end
