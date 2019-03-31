# -*- coding: utf-8 -*-
#
# If the depth of a tree is smaller than 5, then this tree can be
# represented by a list of three-digits integers.
#
# For each integer in this list:
#   1. The hundreds digit represents the depth D of this node, 1 <= D <= 4.
#   2. The tens digit represents the position P of this node in the level it belongs to, 1 <= P <= 8. The position is the same as that in a full binary tree.
#   3. The units digit represents the value V of this node, 0 <= V <= 9.
#
# Given a list of ascending three-digits integers representing a
# binary with the depth smaller than 5. You need to return the sum of
# all paths from the root towards the leaves.
#
# Example 1:
#
# Input: [113, 215, 221]
# Output: 12
# Explanation:
# The tree that the list represents is:
#     3
#    / \
#   5   1
#
# The path sum is (3 + 5) + (3 + 1) = 12.
#
# Example 2:
#
# Input: [113, 221]
# Output: 4
# Explanation:
# The tree that the list represents is:
#     3
#      \
#       1
#
# The path sum is (3 + 1) = 4.


# For node 'DPV', its left child is a = (D+1)*10+2*P-1, its right
# child is a+1, knowing its left and right child we can use normal dfs
# to solve it, the only question is how to check if a node exists, we
# can use a hash { 'DP':'V' } to do that.

def path_sum(nums)
  dfs(nums[0]/10, nums.inject({}) { |h, n| h[n/10]=n%10; h })
end

def dfs(root, h, x=0)
  return 0 if h[root].nil?
  left = (root/10+1)*10 + 2*(root%10)-1
  right = left+1
  x += h[root]
  return x if h[left].nil? && h[right].nil?
  dfs(left, h, x) + dfs(right, h, x)
end
