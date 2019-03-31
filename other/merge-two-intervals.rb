# Merge two sorted (ascending) lists of interval and return it as a
# new sorted list. The new sorted list should be made by splicing
# together the intervals of the two lists and sorted in ascending
# order.
#
# Example:
#
# Input: list1 = [[1,2],[3,4]] and list2 = [[2,3],[5,6]]
# Output: [[1,4],[5,6]]


# We just need to pick the smaller one of l1 and l2.
#   1. When run out of l2 then just use l1.
#   2. When run out of l1 then just use l2.
#   3. When still have l1 and l2 left, we use the smaller one of them.

def merge_two_intervals(l1, l2)
  return l2 if l1.empty?
  return l1 if l2.empty?
  i, j = 0, 0
  [].tap do |r|
    while i < l1.length || j < l2.length
      if j == l2.length || (i < l1.length && l1[i].start < l2[j].start)
        k = l1[i]
        i += 1
      elsif i == l1.length || (j < l2.length && l1[i].start >= l2[j].start)
        k = l2[j]
        j += 1
      end
      if r.empty? || r[-1].end < k.start
        r << k
      else
        r[-1].end = [r[-1].end, k.end].max
      end
    end
  end
end
