# There is a village with two kinds of people- villagers (represented
# by 0) and defenders (represented by 1). When enemy attacks the
# defenders stand in front as shown below:
#
# 110000
# 100000
# 111000
# 110000
#
# The enemy will attack in that row which is most vulnerable (i.e. has
# the least number of defenders. Write a program to find the row where
# the enemy will attack.

# O(m+n)

def attack(grid)
  j, ans = grid[0].size-1, 0
  grid.each_with_index do |n, i|
    next if n[j] == 1
    j -= 1 while n[j] == 0
    ans = i
  end
  ans
end
