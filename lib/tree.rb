# frozen_string_literal: true

require_relative './node'

# Balanced binary search tree containing Nodes of data
class Tree
  attr_reader :root

  def initialize(data)
    @root = build_tree(data)
  end

  def build_tree(data)
    return nil if data.empty?

    data = data.uniq.sort

    middle_index = (data.length / 2).floor
    left = data[...middle_index]
    right = data[middle_index + 1...]

    Node.new(data[middle_index], build_tree(left), build_tree(right))
  end

  def insert(value, current_node = root)
    return nil if value == current_node.data

    next_side = value < current_node.data ? 'left' : 'right'
    next_node = current_node.send("#{next_side}_child")

    if next_node.nil?
      current_node.send("#{next_side}_child=", Node.new(value))
    else
      insert(value, next_node)
    end
  end

  # Written by The Odin Project student to visualize Tree
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end
end
