# Build a Node class. It should have an attribute for the data it stores 
# as well as its left and right children.

class Node
  attr_accessor :value, :right, :left
  
  def initialize
    @value = nil
    @left = nil
    @right = nil
  end

  def value(value)
    @value = value
  end

  def r_value
    @value
  end

  def right_node(pointer)
    @right = pointer
  end

  def right
    @right
  end

  def left_node(pointer)
    @left = pointer
  end

  def left
    @left
  end
end
