# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=384 lang=ruby
#
# [384] Shuffle an Array
#
# https://leetcode.com/problems/shuffle-an-array/description/
#
# Shuffle a set of numbers without duplicates.
#
# Example:
#
# // Init an array with set 1, 2, and 3.
# int[] nums = {1,2,3};
# Solution solution = new Solution(nums);
#
# // Shuffle the array [1,2,3] and return its result. Any permutation of
# [1,2,3] must equally likely to be returned.
# solution.shuffle();
#
# // Resets the array back to its original configuration [1,2,3].
# solution.reset();
#
# // Returns the random shuffling of array [1,2,3].
# solution.shuffle();


class Solution

  def initialize(nums)
    @size = nums.size
    @nums = nums
    @orig = nums.dup
  end

  def reset
    @nums = @orig
    @orig = @orig.dup
  end

  def shuffle
    @size.times do |i|
      swap(i, rand(i..@size-1))
    end
    @nums
  end

  private

  def swap(i, j)
    @nums[i], @nums[j] = @nums[j], @nums[i]
  end
end
