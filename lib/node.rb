# frozen_string_literal: true

# Contains data and references to left and right child Nodes
class Node
  include Comparable

  attr_accessor :data, :left_child, :right_child

  def <=>(other)
    return if other.nil?

    data <=> other.data
  end

  def initialize(data, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end
