# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=445 lang=ruby
#
# [445] Add Two Numbers II
#
# https://leetcode.com/problems/add-two-numbers-ii/description/
#
# You are given two non-empty linked lists representing two
# non-negative integers. The most significant digit comes first and
# each of their nodes contain a single digit. Add the two numbers and
# return it as a linked list.
#
# You may assume the two numbers do not contain any leading zero,
# except the number 0 itself.
#
# Follow up:
# What if you cannot modify the input lists? In other words, reversing the
# lists is not allowed.
#
# Example:
#
# Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
# Output: 7 -> 8 -> 0 -> 7
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# Two stacks.

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  a1, a2 = list_to_a(l1), list_to_a(l2)
  ans, carry = nil, 0
  while !a1.empty? || !a2.empty? || !carry.zero?
    sum = a1.pop.to_i + a2.pop.to_i + carry
    carry = sum / 10
    ans, ans.next = ListNode.new(sum % 10), ans
  end
  ans
end

def list_to_a(l)
  ans = []
  while !l.nil?
    ans << l.val
    l = l.next
  end
  ans
end


# Reverse List.

def add_two_numbers(l1, l2)
  l1, l2 = reverse_list(l1),reverse_list(l2)
  ans, carry = nil, 0
  while !l1.nil? || !l2.nil? || !carry.zero?
    sum = l1&.val.to_i + l2&.val.to_i + carry
    carry = sum / 10
    ans, ans.next = ListNode.new(sum % 10), ans
  end
  ans.next
end

def reverse_list(l)
  rev = nil
  while !l.nil?
    rev, rev.next, l = l, rev, l.next
  end
  rev
end
