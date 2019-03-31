# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1013 lang=ruby
#
# [1013] Pairs of Songs With Total Durations Divisible by 60
#
# https://leetcode.com/problems/pairs-of-songs-with-total-durations-divisible-by-60/description/
#
# In a list of songs, the i-th song has a duration of time[i] seconds.
#
# Return the number of pairs of songs for which their total duration
# in seconds is divisible by 60. Formally, we want the number of
# indices i < j with (time[i] + time[j]) % 60 == 0.
#
# Example 1:
#
# Input: [30,20,150,100,40]
# Output: 3
# Explanation: Three pairs have a total duration divisible by 60:
# (time[0] = 30, time[2] = 150): total duration 180
# (time[1] = 20, time[3] = 100): total duration 120
# (time[1] = 20, time[4] = 40): total duration 60
#
# Example 2:
#
# Input: [60,60,60]
# Output: 3
# Explanation: All three pairs have a total duration of 120, which is
# divisible by 60.
#
# Note:
#
# 1 <= time.length <= 60000
# 1 <= time[i] <= 500


# (20%60=20) + (40%60=40) => 60
# 20%60=(20+60)%60=(20+60+60)%60=(20+...)%60=20
# 40%60=(40+60)%60=(40+60+60)%60=(40+...)%60=40
# x%60=(x+60)%60=(x+60+60)%60=(x+...)%60
# y%60=(y+60)%60=(y+60+60)%60=(y+...)%60
# we want (x+y)%60==0, then x%60+y%60==60, ehmmm, it's two sum problem...
# the only exception is when x%60=0, then we also want y%60=0

# @param {Integer[]} time
# @return {Integer}
def num_pairs_divisible_by60(time)
  h, count = Hash.new(0), 0
  time.each do |t|
    x = 60-t%60
    count += h[x == 60 ? 0 : x]
    h[t%60] += 1
  end
  count
end
