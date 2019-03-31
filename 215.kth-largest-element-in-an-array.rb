# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=215 lang=ruby
#
# [215] Kth Largest Element in an Array
#
# https://leetcode.com/problems/kth-largest-element-in-an-array/description/
#
# Find the kth largest element in an unsorted array. Note that it is
# the kth largest element in the sorted order, not the kth distinct
# element.
#
# Example 1:
#
# Input: [3,2,1,5,6,4] and k = 2
# Output: 5
#
# Example 2:
#
# Input: [3,2,3,1,2,4,5,5,6] and k = 4
# Output: 4
#
# Note: You may assume k is always valid, 1 ≤ k ≤ array's length.


# Too bad Ruby has no build-in heap / priority queue.
#
#   1. min heap: O(k+(n-k)*log(k)).
#   2. max heap: O(n+k*log(n)).
#
# if k<<n then is k*log(n)<nlog(k) ?
# min heap might be good with data stream tho. (you don't have all the number at first).

# @param {Integer[]} nums
# @param {Integer} k
# @return {Integer}
def find_kth_largest_a(nums, k)
  mh = MinHeap.new(nums[0..(k-1)])
  nums[k..-1].each do |n|
    if n > mh.min
      mh.pop
      mh << n
    end
  end
  mh.min
end

class MinHeap

  def initialize(array=[])
    @arr = [nil]
    array.each do |item|
      push(item)
    end
  end

  def push(item)
    @arr << item
    swim(size)
  end
  alias_method :<<, :push

  def pop()
    item = @arr[1]
    @arr[1] = @arr[-1]
    @arr.pop
    sink(1)
    item
  end

  def min()
    @arr[1]
  end

  private

  def swim(i)
    while i > 1 && @arr[parent(i)] > @arr[i]
      swap(parent(i), i)
      i = parent(i)
    end
  end

  def sink(i)
    until lchild(i) > size
      lesser = lchild(i)
      lesser += 1 if lesser < size && @arr[rchild(i)] < @arr[lchild(i)]
      break if @arr[i] < @arr[lesser]
      swap(i, lesser)
      i = lesser
    end
  end

  def size()
    @arr.length - 1
  end

  def swap(i, p)
    @arr[i], @arr[p] = @arr[p], @arr[i]
  end

  def parent(i)
    i/2
  end

  def lchild(i)
    2*i
  end

  def rchild(i)
    2*i+1
  end
end



# Special quick sort. It's crucial that the input is shuffled, it
# reduce my run time from 1994ms to 56ms.

# Example:
#
# k = 3, nums = [5, 4, 1, 1, 4, 3, 5, 7]
#
#  three way partition, v = 5
#  [5, 4, 1, 1, 4, 3, 5, 7]
#   |  |                 |
#   lt i                 gt
#  4<5, swap(lt,i) then lt++, i++
#  [4, 5, 1, 1, 4, 3, 5, 7]
#      |  |              |
#      lt i              gt
#  1<5, swap(lt,i) then lt++, i++
#  [4, 1, 5, 1, 4, 3, 5, 7]
#         |  |           |
#         lt i           gt
#  1<5, swap(lt,i) then lt++, i++
#  [4, 1, 1, 5, 4, 3, 5, 7]
#            |  |        |
#            lt i        gt
#  4<5, swap(lt,i) then lt++, i++
#  [4, 1, 1, 4, 5, 3, 5, 7]
#               |  |     |
#               lt i     gt
#  3<5, swap(lt,i) then lt++, i++
#  [4, 1, 1, 4, 3, 5, 5, 7]
#                  |  |  |
#                  lt i  gt
#  5==5, i++
#  [4, 1, 1, 4, 3, 5, 5, 7]
#                  |    /\
#                  lt  i  gt
#  7>5, swap(gt,i), then gt--
#  [4, 1, 1, 4, 3, 5, 5, 7]
#                  |  |  |
#                  lt gt i
#  i > gt, break, return [5, 6]

# this is the first three way partition
# we find that k==3, length-k==5, it's between [5,6]
# so we found the kth largest time, it's 5
# if k>3, we just repeat above step within [0,4], aka the left side
# else we search the right side

def find_kth_largest(nums, k)
  nums.shuffle!
  helper(nums, 0, nums.length-1, k)
end

def helper(nums, lo, hi, k)
  left, right = three_way_partition(nums, lo, hi)
  pos = nums.length-k
  if pos < left
    helper(nums, lo, left-1, k)
  elsif pos > right
    helper(nums, right+1, hi, k)
  else
    nums[left]
  end
end

def three_way_partition(nums, lo, hi)
  i, lt, gt, v = lo+1, lo, hi, nums[lo]
  while i <= gt
    if nums[i] > v
      swap(nums, i, gt)
      gt -= 1
    elsif nums[i] < v
      swap(nums, i, lt)
      i += 1
      lt += 1
    else
      i += 1
    end
  end
  [lt, gt]
end

def swap(nums, i, j)
  nums[i], nums[j] = nums[j], nums[i]
end
