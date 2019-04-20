# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=141 lang=ruby
#
# [141] Linked List Cycle
#
# https://leetcode.com/problems/linked-list-cycle/description/
#
# Given a linked list, determine if it has a cycle in it.
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

def hasCycle(head)
  return false if head.nil? || head.next.nil?
  slow, fast = head, head.next
  while !fast.nil? && !fast.next.nil?
    return true if fast == slow
    slow, fast = slow.next, fast.next.next
  end
  false
end
