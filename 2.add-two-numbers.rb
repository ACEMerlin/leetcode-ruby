# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=2 lang=ruby
#
# [2] Add Two Numbers
#
# https://leetcode.com/problems/add-two-numbers/description/
#
# You are given two non-empty linked lists representing two
# non-negative integers. The digits are stored in reverse order and
# each of their nodes contain a single digit. Add the two numbers and
# return it as a linked list.
#
# You may assume the two numbers do not contain any leading zero,
# except the number 0 itself.
#
# Example:
#
# Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
# Output: 7 -> 0 -> 8
# Explanation: 342 + 465 = 807.
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
  curr, carry = ListNode.new(nil), 0
  ans = curr
  while !l1.nil? || !l2.nil? || !carry.zero?
    sum = carry + l1&.val.to_i + l2&.val.to_i
    carry = sum / 10
    curr.next = ListNode.new(sum % 10)
    curr = curr.next
    l1 = l1.next if !l1.nil?
    l2 = l2.next if !l2.nil?
  end
  ans.next
end
