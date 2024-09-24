# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/tree'

describe 'build_tree' do
  it 'returns the correct root node' do
    tree = Tree.new([1, 2, 3])
    left_node = Node.new(1)
    right_node = Node.new(3)
    root_node = Node.new(2, left_node, right_node)
    expect(tree.root).to eq(root_node)
  end

  it 'sorts and removes duplicates' do
    tree = Tree.new([2, 2, 1, 9, 3]) # [1, 2, 3, 9]
    left_node2 = Node.new(1)
    left_child = Node.new(2, left_node2)
    right_child = Node.new(9)
    expect(tree.root).to have_attributes(data: 3, left_child:, right_child:)
  end
end

describe 'insert' do
  it 'inserts a node' do
    tree = Tree.new([1, 2, 3])
    tree.insert(4)
    inserted_node = Node.new(4)
    left_child = Node.new(1)
    right_child = Node.new(3, nil, inserted_node)
    expect(tree.root).to have_attributes(data: 2, left_child:, right_child:)
  end
end

describe 'delete' do
  it 'deletes a leaf node' do
    tree = Tree.new([1, 2, 3])
    tree.delete(1)
    right_child = Node.new(3)
    expect(tree.root).to have_attributes(data: 2, left_child: nil, right_child:)
  end

  it 'deletes a node with 1 child' do
    tree = Tree.new([1, 2, 3, 4])
    tree.delete(2)
    left_child = Node.new(1)
    right_child = Node.new(4)
    expect(tree.root).to have_attributes(data: 3, left_child:, right_child:)
  end

  it 'deletes a node with 2 children' do
    tree = Tree.new([1, 2, 3, 4, 5, 6])
    # tree.pretty_print
    tree.delete(2)
    left_child = Node.new(3)
    right_child = Node.new(6)
    expect(tree.root).to have_attributes(data: 4, left_child:, right_child:)
  end
end
