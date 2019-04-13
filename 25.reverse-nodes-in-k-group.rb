# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=25 lang=ruby
#
# [25] Reverse Nodes in k-Group
#
# https://leetcode.com/problems/reverse-nodes-in-k-group/description/
#
# Given a linked list, reverse the nodes of a linked list k at a time
# and return its modified list.
#
# k is a positive integer and is less than or equal to the length of
# the linked list. If the number of nodes is not a multiple of k then
# left-out nodes in the end should remain as it is.
#
# Example:
#
# Given this linked list: 1->2->3->4->5
# For k = 2, you should return: 2->1->4->3->5
# For k = 3, you should return: 3->2->1->4->5
#
# Note:
#
# Only constant extra memory is allowed.
# You may not alter the values in the list's nodes, only nodes itself
# may be changed.
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# @param {ListNode} head
# @param {Integer} k
# @return {ListNode}
def reverse_k_group(head, k)
  return if head.nil?
  return head if k == 1
  head, tail, cur = reverse_first_k(head, k)
  tail.next = reverse_k_group(cur, k)
  head
end

def reverse_first_k(l, k)
  cur, tail, rev = l, l, nil
  k.times do |i|
    return reverse_first_k(rev, i) if cur.nil?
    rev, rev.next, cur = cur, rev, cur.next
  end
  [rev, tail, cur]
end
