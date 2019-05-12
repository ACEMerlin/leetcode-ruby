# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=1041 lang=ruby
#
# [1041] Robot Bounded In Circle
#
# https://leetcode.com/problems/robot-bounded-in-circle/description/
#
# On an infinite plane, a robot initially stands at (0, 0) and faces north.
# The robot can receive one of three instructions:
#
# "G": go straight 1 unit;
# "L": turn 90 degrees to the left;
# "R": turn 90 degress to the right.
#
# The robot performs the instructions given in order, and repeats them
# forever.
#
# Return true if and only if there exists a circle in the plane such that the
# robot never leaves the circle.
#
# Example 1:
#
# Input: "GGLLGG"
# Output: true
# Explanation:
# The robot moves from (0,0) to (0,2), turns 180 degrees, and then returns to
# (0,0).
# When repeating these instructions, the robot remains in the circle of radius
# 2 centered at the origin.
#
# Example 2:
#
# Input: "GG"
# Output: false
# Explanation:
# The robot moves north indefinetely.
#
# Example 3:
#
# Input: "GL"
# Output: true
# Explanation:
# The robot moves from (0, 0) -> (0, 1) -> (-1, 1) -> (-1, 0) -> (0, 0) ->
#
# Note:
#
# 1 <= instructions.length <= 100
# instructions[i] is in {'G', 'L', 'R'}


# The robot'll get back to (0,0) with at most 4 passes.
# Proof:
# Let d be the degrees the robot rotate after one pass.
#   - when d == 90, then it'll need 270/90=3 passes to get back.
#   - when d == 180, then it'll need 180/180=1 passes to get back.
#   - when d == 270, then it'll need (1080-270)/270=3 passes to get back.

# @param {String} instructions
# @return {Boolean}
def is_robot_bounded(instructions)
  x, y = 0, 0
  dx, dy = 0, 1
  one_pass = -> {
    instructions.each_char do |c|
      case c
      when 'G'
        x += dx
        y += dy
      when 'L'
        case [dx, dy]
        when [0, 1]
          dx, dy = -1, 0
        when [-1, 0]
          dx, dy = 0, -1
        when [0, -1]
          dx, dy = 1, 0
        when [1, 0]
          dx, dy = 0, 1
        end
      when 'R'
        case [dx, dy]
        when [0, 1]
          dx, dy = 1, 0
        when [1, 0]
          dx, dy = 0, -1
        when [0, -1]
          dx, dy = -1, 0
        when [-1, 0]
          dx, dy = 0, 1
        end
      end
    end
  }
  4.times do
    one_pass.call
    return true if x == 0 || y == 0
  end
  false
end
