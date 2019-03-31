# Seraja and Brackets
#
#   http://codeforces.com/contest/380/problem/C
#   https://www.spoj.com/problems/BRCKTS

require '../data-structures/segment-tree'

class ParenTree < SegmentTree

  def leaf(c)
    {
      ans: 0,
      o: c == '(' ? 1 : 0,
      c: c == ')' ? 1 : 0
    }
  end

  def combine(left, right)
    t = [left[:o], right[:c]].min
    {
      ans: left[:ans] + right[:ans] + 2*t,
      o: left[:o] + right[:o] - t,
      c: left[:c] + right[:c] - t
    }
  end
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_parens
    t = ParenTree.new("())(())(())(")
    assert_equal t.query(0, 0)[:ans], 0
    assert_equal t.query(1, 2)[:ans], 0
    assert_equal t.query(0, 1)[:ans], 2
    assert_equal t.query(0, 11)[:ans], 10
    assert_equal t.query(7, 11)[:ans], 4
    assert_equal t.query(4, 10)[:ans], 6
    assert_equal t.query(1, 9)[:ans], 6
  end
end
