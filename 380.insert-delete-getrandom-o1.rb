# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=380 lang=ruby
#
# [380] Insert Delete GetRandom O(1)
#
# https://leetcode.com/problems/insert-delete-getrandom-o1/description/
#
# Design a data structure that supports all following operations in
# average O(1) time.
#
# insert(val): Inserts an item val to the set if not already present.
# remove(val): Removes an item val from the set if present.
# getRandom: Returns a random element from current set of elements. Each
# element must have the same probability of being returned.
#
# Example:
#
# // Init an empty set.
# RandomizedSet randomSet = new RandomizedSet();
#
# // Inserts 1 to the set. Returns true as 1 was inserted successfully.
# randomSet.insert(1);
#
# // Returns false as 2 does not exist in the set.
# randomSet.remove(2);
#
# // Inserts 2 to the set, returns true. Set now contains [1,2].
# randomSet.insert(2);
#
# // getRandom should return either 1 or 2 randomly.
# randomSet.getRandom();
#
# // Removes 1 from the set, returns true. Set now contains [2].
# randomSet.remove(1);
#
# // 2 was already in the set, so return false.
# randomSet.insert(2);
#
# // Since 2 is the only number in the set, getRandom always return 2.
# randomSet.getRandom();



# 1. hash: { val:index }
# 2. nums: [val]
# 3. Insert at the tail of nums.
# 3. Delete the last item from nums, swap with last element if necessary.

class RandomizedSet

  def initialize()
    @h = {}
    @nums = []
  end

  def insert(val)
    return false if @h.has_key?(val)  # already exists
    @h[val] = @nums.size              # new item has index of @num.size
    @nums << val                      # push item
    true
  end

  def remove(val)
    return false if !@h.has_key?(val) # doesn't have the item
    p = @h[val]                       # get item's index
    if p < @nums.size-1               # if it's not the last item
      last = @nums[-1]                # get the last item
      @nums[p] = last                 # swap item with last item
      @h[last] = p                    # update last item's index
    end
    @h.delete(val)                    # delete the item
    @nums.pop
    true
  end

  def get_random()
    @nums.sample
  end
end
