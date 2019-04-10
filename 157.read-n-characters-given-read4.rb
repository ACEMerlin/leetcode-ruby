# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=157 lang=ruby
#
# [157] Read N Characters Given Read4
#
# https://leetcode.com/problems/read-n-characters-given-read4/description/
#
# The API: int read4(char *buf) reads 4 characters at a time from a file.
#
# The return value is the actual number of characters read. For
# example, it returns 3 if there is only 3 characters left in the file.
#
# By using the read4 API, implement the function int read(char *buf, int n)
# that reads n characters from the file.
#
# Note: The read function will only be called once for each test case.


def read(buf, n)
  x, eof, count = [], false, 0
  while n > 0 && !eof
    c = read4(x)
    eof = true if c < 4
    x[0..c].each do |i|
      buf << i
      count += 1
      break if count == n
    end
  end
  count
end
