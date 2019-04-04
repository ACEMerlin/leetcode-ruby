# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=347 lang=ruby
#
# [347] Top K Frequent Elements
#
# https://leetcode.com/problems/top-k-frequent-elements/description/
#
# Given a non-empty array of integers, return the k most frequent elements.
#
# Example 1:
#
# Input: nums = [1,1,1,2,2,3], k = 2
# Output: [1,2]
#
# Example 2:
#
# Input: nums = [1], k = 1
# Output: [1]
#
# Note: You may assume k is always valid, 1 ≤ k ≤ number of unique
# elements. Your algorithm's time complexity must be better than O(n
# log n), where n is the array's size.


# First method: Hashmap + Prority Queue(min heap)
#
#   1. Map all nums to a frequency hash { num:count }
#   2. Put hash into a minheap with size k
#      - minheap is 'sorted' by count, so put (count, num)
#      - if the size of current minheap <= k, then just put (count, num)
#      - if the size of current minheap > k, then pop (to get rid of
#        num with smallercount)
#   3. After step 2 minheap contains the result, iterate and get the result

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer[]}
def top_k_frequent_a(nums, k)
  freq = nums.inject(Hash.new(0)) { |h, n| h[n] += 1; h }
  mh = MinHeap.new
  freq.each do |num, count|
    mh.push(count, num)
    mh.pop if mh.size > k
  end
  [].tap { |r| r.unshift mh.pop until mh.empty? }
end

class PQueue

  def initialize(array=[], &block)
    @fn = block || ->(x, y) { (x <=> y) == 1}
    @arr = [nil]
    return if array.empty?
    if array[0].is_a? Array
      @arr.concat(array.map { |k, v| Node.new(k, v) })
    else
      @arr.concat(array.map { |k| Node.new(k) })
    end
    (array.size/2).downto(1).each { |i| sink(i) }
  end

  def push(k, v=k)
    @arr << Node.new(k, v)
    swim(size)
  end
  alias_method :<<, :push

  def pop
    x = @arr[1]
    @arr[1] = @arr[-1]
    @arr.pop
    sink(1)
    x&.val
  end

  def top
    @arr[1]&.val
  end

  def size
    @arr.length - 1
  end

  def empty?
    size == 0
  end

  private

  class PQueue::Node
    attr_accessor :key, :val
    def initialize(key, val)
      @key, @val = key, val
    end
  end

  def sink(i)
    until lchild(i) > size
      j = lchild(i)
      j += 1 if j+1 <= size && @fn[@arr[j+1].key, @arr[j].key]
      break if @fn[@arr[i].key, @arr[j].key]
      swap(i, j)
      i = j
    end
  end

  def swim(i)
    while i > 1 && @fn[@arr[i].key, @arr[parent(i)].key]
      swap(i, parent(i))
      i = parent(i)
    end
  end

  def parent(i)
    i/2
  end

  def lchild(i)
    i*2
  end

  def rchild(i)
    i*2+1
  end

  def swap(i, j)
    @arr[i], @arr[j] = @arr[j], @arr[i]
  end
end

class MinHeap < PQueue
  def initialize(array=[])
    super(array) { |x, y| (x <=> y) == -1 }
  end

  alias_method :min, :top
end


# Second method:
#
#   1. Map all nums to a frequency hash { num:count }
#   2. Map hash into a bucket of size nums.length+1, bucket[count]
#      contains a array of numbers with frequency of count.
#   3. Scan bucket from back to front, add all entries until we have
#      more than k numbers, get k numbers from the result.

def top_k_frequent(nums, k)
  freq = nums.inject(Hash.new(0)) { |h, n| h[n] += 1; h }
  buckets = Array.new(nums.length+1)
  freq.each { |num, count| (buckets[count] ||= []) << num }
  [].tap do |r|
    i = buckets.length-1
    while i >= 0 && r.length <= k
      r.concat(buckets[i]) unless buckets[i].nil?
      i -= 1
    end
  end[0...k]
end


# Actually I'd prefer the ruby way, or FP way if you like, but I guess
# the interviewer wouldn't accept this, sad.

def top_k_frequent_b(nums, k)
  nums
    .inject(Hash.new(0)) { |h, n| h[n] += 1; h }
    .sort_by { |_, v| -v }
    .first(k)
    .map(&:first)
end
