# Given string contains only 'a' and 'b', their are 2 ops you can do:
#
#   1. flip a to b at certain index.
#   2. flip b to a at certain index.
#
# Find minimum ops you can do after which the string is sorted
# (a...ab...b), return the sorted string.


# Given "ababbab"
#   1. From right to left count the number of 'a's up to given point.
#      there is a dummy node 0 at the end.
#      [3, 2, 2, 1, 1, 1, 0, 0]
#   2. From left to right count the number of 'b's up to given point.
#      there is a dummy node 0 at the start.
#      [0, 0, 1, 1, 2, 3, 3, 4]
#   3. For each character, check how many 'b's are there to the left,
#      and how many 'a's to the right, sum it together, update the minimum
#      if it's smaller, keep record of the current index, after iteration,
#      rebuild the string using the index.

def abstring(str)
  min, sep = Float::INFINITY
  count = 0
  bs = (0...str.length).reduce([0]) do |b, i|
    count += 1 if str[i] == 'b'
    b << count
  end
  count = 0
  as = (str.length-1).downto(0).reduce([0]) do |a, i|
    count += 1 if str[i] == 'a'
    a.unshift(count)
  end
  (0..str.length).each do |i|
    flips = as[i] + bs[i]
    if flips <= min
      min = flips
      sep = i
    end
  end
  'a'*sep + 'b'*(str.size-sep)
end
