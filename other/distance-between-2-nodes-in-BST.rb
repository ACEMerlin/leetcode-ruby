# Find the distance between two nodes in BST.
#
# Example:
#
# Given tree:
#               5
#             /   \
#            1     7
#           / \   / \
#          0   3 6   8
#             / \
#            2   4
#
# The distance between 1 and 8 is 3: 1->5->7->8
# The distance between 0 and 2 is 3: 0->1->3->2
#
# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end


# 1. get depth of p
# 2. get depth of q
# 3. get LCA of p and q
# 4. dist(p,q) = depth(p) + depth(q) - 2 * dist(lca(p,q))

def distance_in_bst(root, p, q)
  p, q = q, p if p > q
  depth(root, p) + depth(root, q) - 2 * depth(root, lca(root, p, q))
end

def depth(root, p, d=0)
  return if root.nil?
  cmp = p <=> root.val
  if cmp < 0
    depth(root.left, p, d+1)
  elsif cmp > 0
    depth(root.right, p, d+1)
  else
    d
  end
end

def lca(root, p, q)
  if root.val < p
    lca(root.right, p, q)
  elsif root.val > q
    lca(root.left, p, q)
  else
    root.val
  end
end
