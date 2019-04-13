# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=61 lang=ruby
#
# [61] Rotate List
#
# https://leetcode.com/problems/rotate-list/description/
#
# Given a linked list, rotate the list to the right by k places, where
# k is non-negative.
#
# Example 1:
#
# Input: 1->2->3->4->5->NULL, k = 2
# Output: 4->5->1->2->3->NULL
# Explanation:
# rotate 1 steps to the right: 5->1->2->3->4->NULL
# rotate 2 steps to the right: 4->5->1->2->3->NULL
#
# Example 2:
#
# Input: 0->1->2->NULL, k = 4
# Output: 2->0->1->NULL
# Explanation:
# rotate 1 steps to the right: 2->0->1->NULL
# rotate 2 steps to the right: 1->2->0->NULL
# rotate 3 steps to the right: 0->1->2->NULL
# rotate 4 steps to the right: 2->0->1->NULL


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
def rotate_right(head, k)
  return if head.nil?
  tail, size = head, 1
  while !tail.next.nil?
    size += 1
    tail = tail.next
  end
  k %= size
  return head if k == 0
  tail.next = head
  front = head
  (size-k-1).times do
    front = front.next
  end
  head = front.next
  front.next = nil
  head
end
