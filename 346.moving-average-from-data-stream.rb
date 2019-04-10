# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=346 lang=ruby
#
# [346] Moving Average from Data Stream
#
# https://leetcode.com/problems/moving-average-from-data-stream/description/
#
# Given a stream of integers and a window size, calculate the moving average of all integers in the sliding window.
#
# For example,
# MovingAverage m = new MovingAverage(3);
# m.next(1) = 1
# m.next(10) = (1 + 10) / 2
# m.next(3) = (1 + 10 + 3) / 3
# m.next(5) = (10 + 3 + 5) / 3

class MovingAverage

  def initialize(size)
    @q, @size, @sum = [], size, 0
  end

  def next(val)
    if @q.size == @size
      @sum -= @q.pop
    end
    @q.unshift(val)
    @sum += val
    @sum.fdiv(@q.size)
  end
end
