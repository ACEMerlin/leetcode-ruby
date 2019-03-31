# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=4 lang=ruby
#
# [4] Median of Two Sorted Arrays
#
# https://leetcode.com/problems/median-of-two-sorted-arrays/description/
#
# There are two sorted arrays nums1 and nums2 of size m and n respectively.
#
# Find the median of the two sorted arrays. The overall run time
# complexity should be O(log (m+n)).
#
# You may assume nums1 and nums2 cannot be both empty.
#
# Example 1:
#
# nums1 = [1, 3]
# nums2 = [2]
#
# The median is 2.0
#
# Example 2:
#
# nums1 = [1, 2]
# nums2 = [3, 4]
#
# The median is (2 + 3)/2 = 2.5


# The key the to find the kth number in two sorted array.

# kth([3,4,6,9],[1,5,7,10,15],7) => [3, 3] meaning that if we split
# nums1 by index 3 and nums2 by index 3, we can identify the 7th
# element. [3,4,6] + [1,5,7] are the numbers smaller than 7th element,
# the rest of them contains the 7th element which is the smaller one
# of nums1[3] and nums2[3], now let's look deeper.

# k = 7, imagine we already have 6 numbers merged, it would be in one
# of these states: from left to right:nums1 state,last used(nums1),
# nums2 state,last used(nums2), rule1?, rule2? I'll explain
# what rule1 and rule2 are later. below is the first possible state:

# [3,4,6,9],3,[1,5,7,10,15],15,true,false
#    |                    |
#    i                    j

# left of i and j are the merged numbers. In this case it's [3] +
# [1,5,7,10,15], we take 1 number from nums1 and 5 from nums2, the
# last used number from nums1 is 3, and the last used number from
# nums2 is 15.

# i start with 1 because we have k == 7 and nums2.length == 5 which
# means we don't have enough if we only use nums2, so we need another
# 1(6 - 5) from nums1, j points to the right side of 15 because we
# need all 5 numbers from nums2.

# To be possible, a status must obey two rules:
# 1. The last number used from nums1 can't be larger than the next
#   remaining number in nums2.
# 2. The last number used from nums2 can't be larger than the next
#   remaining number in nums1 (because it would've been a mistake to use
#   it first).

# So in this case 3 need to be smaller than nums[j](next remaining
# number in nums2), since it's nil it represents that we don't need
# number from nums2 to merge 3, so rule1 is true. As for rule2, 15
# needs to be smaller than 4(nums[i]: next remaining number in nums1),
# it's false.

# we repeat above step by taking more numbers from nums1 and less
# from nums2 until we find a state where rule1 and rule2 are both
# satisfied, and this can be done using binary search:

# [3,4,6,9],4,[1,5,7,10,15],10,true,false
#      |                 |
#      i                 j
# [3,4,6,9],6,[1,5,7,10,15],7,true,true  (found it!!)
#        |            |
#        i            j
# [3,4,6,9],6,[1,5,7,10,15],7,false,true
#         |        |
#         i        j

# and above states can be searched using binary search, why? cuz:
# it's a discrete binary search, see:
#   https://www.topcoder.com/community/competitive-programming/tutorials/binary-search

# rule 1: yyyyyyyyyyyyynnnnnnnnnnnnnnnnn   (monotone from y to n)
# rule 2: nnnnnnnnnyyyyyyyyyyyyyyyyyyyyy   (monotone from n to y)
#                  ||||
#                  Here both rules are obeyed,
#                  so we can take any of these
#                  indexes. I just use the first,
#                  which is the first that obeys rule 2.

# now we've found the indices i and j, you know what to do.

# @param {Integer[]} nums1
# @param {Integer[]} nums2
# @return {Float}
def find_median_sorted_arrays(nums1, nums2)
  return find_median_sorted_arrays(nums2, nums1) if nums1.length > nums2.length
  l = nums1.length + nums2.length
  i, j = kth(nums1, nums2, (l+1)/2)
  nextfew = (nums1[i,2] + nums2[j,2]).sort
  (nextfew[0] + nextfew[1-l%2]) / 2.0
end

def kth(nums1, nums2, k)
  return [0, 0] if k == 1
  m, n = nums1.length, nums2.length
  merged = k - 1
  nums1_needed = merged - n
  nums1_start = nums1_needed >= 0 ? nums1_needed : 0
  nums1_end = [m, merged].min
  i = (nums1_start..nums1_end).bsearch do |i|
    i == m || merged-i-1 < 0 || nums2[merged-i-1] < nums1[i]
  end
  [i, merged-i]
end
