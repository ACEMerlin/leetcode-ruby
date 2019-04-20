# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=155 lang=ruby
#
# [155] Min Stack
#
# https://leetcode.com/problems/min-stack/description/
#
# Design a stack that supports push, pop, top, and retrieving the
# minimum element in constant time.
#
# push(x) -- Push element x onto stack.
# pop() -- Removes the element on top of the stack.
# top() -- Get the top element.
# getMin() -- Retrieve the minimum element in the stack.
#
# Example:
#
# MinStack minStack = new MinStack();
# minStack.push(-2);
# minStack.push(0);
# minStack.push(-3);
# minStack.getMin();   --> Returns -3.
# minStack.pop();
# minStack.top();      --> Returns 0.
# minStack.getMin();   --> Returns -2.


# Stack: [[num, current_min]].

class MinStack

  def initialize
    @h = []
  end

  def push(x)
    if @h.empty?
      @h << [x, x]
    else
      @h << [x, [@h[-1][1], x].min]
    end
  end

  def pop
    @h.pop
  end

  def top
    @h[-1][0]
  end

  def get_min
    @h[-1][1]
  end
end
