# Given an array of meeting time intervals consisting of start and end
# times [[s1,e1],[s2,e2],...] (si < ei), determine if a person could
# attend all meetings.
#
# Example:
#
# Given [[0, 30],[5, 10],[15, 20]],
#
# return false.
#
# Definition for an interval.
# class Interval
#     attr_accessor :start, :end
#     def initialize(s=0, e=0)
#         @start = s
#         @end = e
#     end
# end

def can_attend_mettings(intervals)
  intervals.sort_by { |x| [x.start, x.end] }
  intervals[0].tap do |r|
    (1...intervals.size).each do |i|
      return false if intervals[i].start < r.end
      r.end = [r.end, intervals[i].end].max
    end
  end
  true
end
