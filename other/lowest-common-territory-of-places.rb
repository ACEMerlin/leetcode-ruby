# Find the lowest common territory that holds the given two places.
# First column of each row is enclosing region, and following columns
# are all the regions within that row.
#
# Example:
#
# data = [
#   ['America', 'NA', 'SA'],
#   ['NA', 'MXC', 'USA', 'CAN'],
#   ['SA', 'Argentina', 'Brazil', 'Chile'],
#   ['MXC', 'Oaxaca', 'Puebla'],
#   ['USA', 'CA', 'WY', 'NY'],
#   ['CAN', 'ON', 'QU', 'SAS']]
#
# lca(data, "CA", "Puebla") => "NA"
# lca(data, "WY", "NY")     => "USA"


def build_parents(data)
  data.inject({}) do |h, d|
    (1...d.length).each { |i| h[d[i]] = d[0] }; h
  end
end

def lca(data, p, q)
  parents = build_parents(data)
  ancestors = Set.new
  until p.nil?
    ancestors << p
    p = parents[p]
  end
  q = parents[q] until q.nil? || ancestors.include?(q)
  q
end
