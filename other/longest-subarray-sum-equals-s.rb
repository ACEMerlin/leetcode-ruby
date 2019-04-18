# Codefight: https://app.codesignal.com/interview-practice/task/izLStwkDr5sMS9CEm/

def findLongestSubarrayBySum(s, arr)
  h, sum = {0=>-1}, 0
  max, ans = 0, [-1]
  arr.each_with_index do |n, i|
    sum += n
    if h.has_key?(sum-s)
      length = i-h[sum-s]
      if length > max
        max = length
        ans = [h[sum-s]+2, i+1]
      end
    end
    h[sum] = i if !h.has_key?(sum)
  end
  ans
end
