# Given an array of meeting time intervals consisting of start and end
# times [[s1,e1],[s2,e2],...] (si < ei), find the minimum number of
# conference rooms required.
#
# Example:
#
# Given [[0, 30],[5, 10],[15, 20]],
#
# return 2.
#
# Definition for an interval.
# class Interval
#     attr_accessor :start, :end
#     def initialize(s=0, e=0)
#         @start = s
#         @end = e
#     end
# end

# If you put all intervals on a 1d line, then the rooms we need at any
# given point x would be the same as the number of intersections if we
# draw a vertical line at point x. Using this idea, we can do simple
# line-sweep from left to right and keep record of the maximum number
# of intersections. To calculate the intersections, we don't have to
# iterate through all integers, we just need to consider all the start
# points and end points.

def min_meeting_rooms(intervals)
  s, e = [], []
  intervals.each do |i|
    s << i[0]
    e << i[1]
  end
  s.sort!
  e.sort!
  i = j = 0
  x = ans = 0
  n = intervals.size
  while i < n
    if s[i] < e[j]
      x += 1
      ans = [ans, x].max
      i += 1
    else
      x -= 1
      j += 1
    end
  end
  ans
end

require './data-structures/treap'

def min_meeting_rooms_bst(intervals)
  st = Treap.new
  intervals.each do |i|
    st.insert(i[0], :start)
    st.insert(i[1], :end)
  end
  ans = 0
  st.reduce(0) do |c, i|
    if i == :start
      c += 1
      ans = [ans, c].max
    else
      c -= 1
    end
  end
  ans
end
