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

  def delete(value, current_node = root)
    return nil if current_node.nil?

    if value < current_node.data
      current_node.left_child = delete(value, current_node.left_child)
    elsif value > current_node.data
      current_node.right_child = delete(value, current_node.right_child)
    else # Delete this node with the value
      handle_deletion(current_node)
    end
  end

  # Written by The Odin Project student to visualize Tree
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  private

  def handle_deletion(node)
    # Leaf node
    return nil if node.left_child.nil? && node.right_child.nil?

    # Node with one child
    if node.left_child.nil?
      return node.right_child
    elsif node.right_child.nil?
      return node.left_child
    end

    # Node with two children
    delete_with_two_children(node)
  end

  def delete_with_two_children(node)
    replacement = node.right_child
    replacement = replacement.left_child while replacement.left_child

    node.data = replacement.data
    node.right_child = delete(replacement.data, node.right_child)
    node
  end
end
