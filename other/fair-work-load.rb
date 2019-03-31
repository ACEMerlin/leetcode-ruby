# Topcoder:
#
#   https://community.topcoder.com/stat?c=problem_statement&pm=1901&rd=4650


def fair_work_load(folders, workers)
  lo, hi = folders.max, folders.sum
  (lo..hi).bsearch do |load|
    worker_needed_with_load(folders, load) <= workers
  end
end

def worker_needed_with_load(folders, load)
  need, cur_load = 1, 0
  folders.each do |f|
    cur_load += f
    if cur_load > load
      need += 1
      cur_load = f
    end
  end
  need
end


# Test
require 'test/unit'

class SimpleTest < Test::Unit::TestCase
  def test_simple
    assert_equal fair_work_load([10, 20, 30, 40, 50, 60, 70, 80, 90], 3), 170
    assert_equal fair_work_load([10, 20, 30, 40, 50, 60, 70, 80, 90], 5), 110
    assert_equal fair_work_load([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1000], 2), 1000
  end
end
