# -*- coding: utf-8 -*-
#
# @lc app=leetcode id=535 lang=ruby
#
# [535] Encode and Decode TinyURL
#
# https://leetcode.com/problems/encode-and-decode-tinyurl/description/
#
# Note: This is a companion problem to the System Design problem:
# Design TinyURL.
#
# TinyURL is a URL shortening service where you enter a URL such as
# https://leetcode.com/problems/design-tinyurl and it returns a short
# URL such as http://tinyurl.com/4e9iAk.
#
# Design the encode and decode methods for the TinyURL service. There
# is no restriction on how your encode/decode algorithm should work.
# You just need to ensure that a URL can be encoded to a tiny URL and
# the tiny URL can be decoded to the original URL.


@h = {}
@codes = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

def rand_key
  "".tap do |r|
    6.times do
      r << @codes[rand(@codes.size)]
    end
  end
end

# Encodes a URL to a shortened URL.
#
# @param {string} longUrl
# @return {string}
def encode(longUrl)
  key = rand_key
  key = rand_key while @h.has_key?(key)
  @h[key] = longUrl
  "http://tinyurl.com/#{key}"
end

# Decodes a shortened URL to its original URL.
#
# @param {string} shortUrl
# @return {string}
def decode(shortUrl)
  @h[shortUrl.gsub("http://tinyurl.com/", "")]
end
