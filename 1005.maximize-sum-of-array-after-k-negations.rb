# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1005 lang=ruby
#
# [1005] Maximize Sum Of Array After K Negations
#
# https://leetcode.com/problems/maximize-sum-of-array-after-k-negations/description/
#
# Given an array A of integers, we must modify the array in the
# following way: we choose an i and replace A[i] with -A[i], and we
# repeat this process K times in total.  (We may choose the same index
# i multiple times.)
#
# Return the largest possible sum of the array after modifying it in
# this way.
#
# Example 1:
#
# Input: A = [4,2,3], K = 1
# Output: 5
# Explanation: Choose indices (1,) and A becomes [4,-2,3].
#
# Example 2:
#
# Input: A = [3,-1,0,2], K = 3
# Output: 6
# Explanation: Choose indices (1, 2, 2) and A becomes [3,1,0,2].
#
# Example 3:
#
# Input: A = [2,-3,-1,5,-4], K = 2
# Output: 13
# Explanation: Choose indices (1, 4) and A becomes [2,3,-1,5,4].
#
# Note:
#
# 1 <= A.length <= 10000
# 1 <= K <= 10000
# -100 <= A[i] <= 100


# We always want to flip the smallest element, does it remind you of
# something? Yeah, Heap. Time complexity: O(n+k*log(n))

# @param {Integer[]} a
# @param {Integer} k
# @return {Integer}
def largest_sum_after_k_negations(a, k)
  q = MinHeap.new(a)
  while k > 0
    q.negat_min
    k -= 1
  end
  q.sum
end

class MinHeap

  def initialize(arr=[])
    @arr = [nil]
    @arr.concat(arr)
    (arr.size/2).downto(1).each { |i| sink(i) }
  end

  def <<(v)
    @arr << v
    swim(size)
  end

  def negat_min
    x = @arr[1]
    @arr[1] = -@arr[1]
    sink(1)
    x
  end

  def min
    @arr[1]
  end

  def sum
    sum = 0
    (1...@arr.size).each do |i|
      sum += @arr[i]
    end
    sum
  end

  private

  def swim(i)
    while i > 1 && @arr[i] < @arr[i/2]
      swap(i, i/2)
      i = i/2
    end
  end

  def sink(i)
    while 2*i <= size
      j = 2*i
      j += 1 if @arr[j+1] && @arr[j+1] < @arr[j]
      break if @arr[i] <= @arr[j]
      swap(i, j)
      i = j
    end
  end

  def swap(i, j)
    @arr[i], @arr[j] = @arr[j], @arr[i]
  end

  def size
    @arr.size - 1
  end
end


# If you are too lazy to implement a Heap, just use array.
#
# Time complexity: O(n*k+n), It's weird that this method is faster
# than using Heap.

def largest_sum_after_k_negations_a(a, k)
  while k > 0
    min = a.index(a.min)
    a[min] = -a[min]
    k -= 1
  end
  a.sum
end
