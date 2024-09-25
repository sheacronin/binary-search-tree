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

  def find(value)
    current_node = root
    while current_node
      return current_node if value == current_node.data

      current_node = next_node(value, current_node)
    end
  end

  def level_order(&block)
    queue = [root]
    data = []
    until queue.empty?
      node = queue.shift
      queue << node.left_child if node.left_child
      queue << node.right_child if node.right_child
      node = block.call(node) if block
      data << node.data
    end
    data
  end

  def preorder(node = root, data = [], &block)
    return if node.nil?

    node = block.call(node) if block
    data << node.data
    preorder(node.left_child, data, &block)
    preorder(node.right_child, data, &block)

    data
  end

  def inorder(node = root, data = [], &block)
    return if node.nil?

    inorder(node.left_child, data, &block)
    node = block.call(node) if block
    data << node.data
    inorder(node.right_child, data, &block)

    data
  end

  def postorder(node = root, data = [], &block)
    return if node.nil?

    postorder(node.left_child, data, &block)
    postorder(node.right_child, data, &block)
    node = block.call(node) if block
    data << node.data

    data
  end

  def height(node = root, height = 0)
    return 0 if node.nil?

    left_height = height(node.left_child, 1)
    right_height = height(node.right_child, 1)

    height + (left_height > right_height ? left_height : right_height)
  end

  def depth(node)
    depth = 0
    postorder do |current|
      node = current if [current.right_child, current.left_child].include?(node)
      depth += 1 if current == node && current != root
      current
    end
    depth
  end

  def balanced?
    left_height = height(root.left_child)
    right_height = height(root.right_child)
    diff = left_height - right_height
    diff.abs <= 1
  end

  # Written by The Odin Project student to visualize Tree
  def pretty_print(node = root, prefix = '', is_left = true)
    puts "\n" if node == root
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

  def next_node(value, node)
    if value < node.data
      node.left_child
    elsif value > node.data
      node.right_child
    end
  end
end
