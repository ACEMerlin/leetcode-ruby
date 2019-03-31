# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=295 lang=ruby
#
# [295] Find Median from Data Stream
#
# https://leetcode.com/problems/find-median-from-data-stream/description/
#
# Median is the middle value in an ordered integer list. If the size
# of the list is even, there is no middle value. So the median is the
# mean of the two middle value. For example:
#
# [2,3,4], the median is 3
#
# [2,3], the median is (2 + 3) / 2 = 2.5
#
# Design a data structure that supports the following two operations:
#
# void addNum(int num) - Add a integer number from the data stream to the data
# structure.
# double findMedian() - Return the median of all elements so far.
#
# Example:
#
# addNum(1)
# addNum(2)
# findMedian() -> 1.5
# addNum(3)
# findMedian() -> 2
#
# Follow up:
#
# If all integer numbers from the stream are between 0 and 100, how would you
# optimize it?
# If 99% of all integer numbers from the stream are between 0 and 100, how
# would you optimize it?


# BST. I use Treap here cuz its easier to implement.
#
# See: data-structures/treap.rb

class MedianFinder

  def initialize
    @treap = Treap.new
  end


  def add_num(num)
    @treap << num
  end


  def find_median
    s = @treap.size
    if s.odd?
      @treap.kth((s+1)/2)
    else
      (@treap.kth(s/2) + @treap.kth(s/2+1)) / 2.0
    end
  end
end

class Treap

  def initialize
    @root = nil
    @MAX = 1<<63
    @random = Random.new
  end

  def randp
    @random.rand(@MAX)
  end

  def insert(key, val=key)
    @root = insert_(key, val, @root)
  end
  alias_method :<<, :insert

  def kth(k, node=@root)
    return if node.nil?
    x = size(node.left)+1
    if k < x
      kth(k, node.left)
    elsif k > x
      kth(k-x, node.right)
    else
      node.val
    end
  end

  def size(node=@root)
    node&.size.to_i
  end

  private

  class Node
    attr_accessor :key, :val, :prior, :left, :right, :size

    def initialize(key, val, prior)
      @key, @val, @prior, @size = key, val, prior, 1
      @left, @right = nil, nil
    end

    def update
      @size = 1 + @left&.size.to_i + @right&.size.to_i
    end
  end

  def rotate_right(h)
    x = h.left
    h.left = x.right
    x.right = h
    h.update
    x
  end

  def rotate_left(h)
    x = h.right
    h.right = x.left
    x.left = h
    h.update
    x
  end

  def insert_(key, val, node)
    return Node.new(key, val, randp) if node.nil?
    if key <= node.key
      node.left = insert_(key, val, node.left)
      node = rotate_right(node) if node.left.prior > node.prior
    else
      node.right = insert_(key, val, node.right)
      node = rotate_left(node) if node.right.prior > node.prior
    end
    node.update
    node
  end
end
