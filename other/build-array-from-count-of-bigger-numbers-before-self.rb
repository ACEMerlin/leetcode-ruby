# You are given an integer array 'counts' of size n. The counts array
# has the property where counts[i] is the number of bigger elements to
# the left of nums[i], the range of nums is 1..n, build the original
# nums array.
#
# Example:
#
# Input: [0,1,2,1,0]
# Output: [4,2,1,3,5]


def build_array(data)
  n = data.size
  x = Array.new(n) { |i| i+1 }
  result = []
  (n-1).downto(0) do |i|
    k = -data[i]-1
    result[i] = x[k]
    x.delete_at(k)
  end
  result
end

def build_array(data)
  n = data.size
  x = Array.new(n) { |i| i+1 }
  result = []
  (n-1).downto(0) do |i|
    k, count = -1, 0
    while true
      if x[k] != 0
        count += 1
        break if count > data[i]
      end
      k -= 1
    end
    result[i] = x[k]
    x[k] = 0
  end
  result
end
