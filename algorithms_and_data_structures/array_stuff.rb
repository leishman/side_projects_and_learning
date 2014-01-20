# Modify Array class to prevent negative indicies
# This makes it easier to catch errors

class Array

  alias_method :init, :initialize

  def initialize(size = 0, base_index = 0)
    init(size, nil)
    @base_index = base_index
  end

  alias_method :getitem, :[]
  alias



end









a = Array.new(5)
b = a.clone

puts a
puts b