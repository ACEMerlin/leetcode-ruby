# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=381 lang=ruby
#
# [381] Insert Delete GetRandom O(1) - Duplicates allowed
#
# https://leetcode.com/problems/insert-delete-getrandom-o1-duplicates-allowed/description/
#
# Design a data structure that supports all following operations in
# average O(1) time.
#
# Note: Duplicate elements are allowed.
#
# insert(val): Inserts an item val to the collection.
# remove(val): Removes an item val from the collection if present.
# getRandom: Returns a random element from current collection of elements. The
# probability of each element being returned is linearly related to the number
# of same value the collection contains.
#
# Example:
#
# // Init an empty collection.
# RandomizedCollection collection = new RandomizedCollection();
#
# // Inserts 1 to the collection. Returns true as the collection did not
# contain 1.
# collection.insert(1);
#
# // Inserts another 1 to the collection. Returns false as the collection
# contained 1. Collection now contains [1,1].
# collection.insert(1);
#
# // Inserts 2 to the collection, returns true. Collection now contains
# [1,1,2].
# collection.insert(2);
#
# // getRandom should return 1 with the probability 2/3, and returns 2 with the
# probability 1/3.
# collection.getRandom();
#
# // Removes 1 from the collection, returns true. Collection now contains
# [1,2].
# collection.remove(1);
#
# // getRandom should return 1 and 2 both equally likely.
# collection.getRandom();


# See problem 380.

# 1. hash: { val:[indices] }
# 2. nums: [[val, index]]
# 3. hash[nums[k][0]][nums[k][1]] == nums.index(nums[k][0])

class RandomizedCollection

  def initialize()
    @st = {}
    @nums = []
  end

  def insert(val)
    if @st.has_key?(val)
      @nums << [val, @st[val].size]
      @st[val] << @nums.size-1
      false
    else
      @nums << [val, 0]
      @st[val] = [@nums.size-1]
      true
    end
  end

  def remove(val)
    return false if !@st.has_key?(val)
    p = @st[val].pop
    @st.delete(val) if @st[val].empty?
    if p != @nums.size-1
      last = @nums[-1]
      @nums[p] = last
      @st[last[0]][last[1]] = p
    end
    @nums.pop
    true
  end

  def get_random()
    @nums.sample[0]
  end
end
