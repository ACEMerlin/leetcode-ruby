# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=234 lang=ruby
#
# [234] Palindrome Linked List
#
# https://leetcode.com/problems/palindrome-linked-list/description/
#
# Given a singly linked list, determine if it is a palindrome.
#
# Example 1:
#
# Input: 1->2
# Output: false
#
# Example 2:
#
# Input: 1->2->2->1
# Output: true
#
# Follow up:
# Could you do it in O(n) time and O(1) space?
#
# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end


# 1. Find the middle, see proble 876.
# 2. Reverse the first half while finding the middle.
# 3. Compare the frist half and the second half.

# @param {ListNode} head
# @return {Boolean}
def is_palindrome(head)
  rev = nil
  slow = fast = head
  while !fast.nil? && !fast.next.nil?
    fast = fast.next.next
    rev, rev.next, slow = slow, rev, slow.next
  end
  slow = slow.next if !fast.nil?
  while !rev.nil? && rev.val == slow.val
    slow, rev = slow.next, rev.next
  end
  rev.nil?
end
