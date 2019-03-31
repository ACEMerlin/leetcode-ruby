# Given an array with n integers, you need to find if there are
# triplets (i, j, k) which satisfies following conditions:
#
# 0 < i, i + 1 < j, j + 1 < k < n - 1, sum of subarrays (0, i - 1), (i
# + 1, j - 1), (j + 1, k - 1) and (k + 1, n - 1) should be equal.
# where we define that subarray (L, R) represents a slice of the
# original array starting from the element indexed L to the element
# indexed R.
#
# Example:
#
# Input: [1,2,1,2,1,2,1]
# Output: True
# Explanation:
#   i = 1, j = 3, k = 5.
#   sum(0, i - 1) = sum(0, 0) = 1
#   sum(i + 1, j - 1) = sum(2, 2) = 1
#   sum(j + 1, k - 1) = sum(4, 4) = 1
#   sum(k + 1, n - 1) = sum(6, 6) = 1


# 0,i-1, i, i+1,j-1, j, j+1,k-1, k, k+1,n-1

def split_array(nums)
  n = nums.size
  return false if n < 7
  sum = nums.inject([]) { |a, n| a << (a[-1]||0)+n } << 0
  range_sum = ->(i, j) { sum[j] - sum[i-1] }
  (3..n-4).each do |j|
    st = Set.new
    (1..j-2).each do |i|
      st << range_sum[0, i-1] if range_sum[0, i-1] == range_sum[i+1, j-1]
    end
    (j+2..n-2).each do |k|
      return true if range_sum[k+1, n-1] == range_sum[j+1, k-1] &&
        st.include?(range_sum[j+1, k-1])
    end
  end
  false
end
