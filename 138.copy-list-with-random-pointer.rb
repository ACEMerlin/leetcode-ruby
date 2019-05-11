# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=138 lang=ruby
#
# [138] Copy List with Random Pointer
#
# https://leetcode.com/problems/copy-list-with-random-pointer/description/
#
# A linked list is given such that each node contains an additional
# random pointer which could point to any node in the list or null.
#
# Return a deep copy of the list.
#
# Definition for singly-linked list.
# class Node
#     attr_accessor :val, :next, :random
#     def initialize(val)
#         @val = val
#         @next, @random = nil, nil
#     end
# end


# O(n) space using Hash.

def copy_random_list(head)
  return if head.nil?
  cur, h = head, {}
  while cur
    h[cur] = Node.new(cur.val)
    cur = cur.next
  end
  cur = head
  while cur
    h[cur].random = h[cur.random] if cur.random
    h[cur].next = h[cur.next] if cur.next
    cur = cur.next
  end
  h[head]
end
