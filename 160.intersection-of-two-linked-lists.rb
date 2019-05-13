# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=160 lang=ruby
#
# [160] Intersection of Two Linked Lists
#
# https://leetcode.com/problems/intersection-of-two-linked-lists/description/
#
# Write a program to find the node at which the intersection of two
# singly linked lists begins.
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# O(m+n) space.
def get_intersection_node(headA, headB)
  h = Set.new
  while !headA.nil?
    h << headA
    headA = headA.next
  end
  while !headB.nil?
    return headB if h.include?(headB)
    headB = headB.next
  end
end


# O(1) space.

def get_intersection_node(headA, headB)
  return if headA.nil? || headB.nil?
  a, b= headA, headB
  while a != b
    a = a.next
    b = b.next
    return if a.nil? && b.nil?
    a = headB if a.nil?
    b = headA if b.nil?
  end
  a
end
