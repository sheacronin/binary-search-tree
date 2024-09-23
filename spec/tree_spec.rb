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
    left_node = Node.new(2, left_node2)
    right_node = Node.new(9)
    root_node = Node.new(3, left_node, right_node)
    expect(tree.root).to eq(root_node)
  end
end

describe 'insert' do
  it 'inserts a node' do
    tree = Tree.new([1, 2, 3])
    tree.insert(4)
    inserted_node = Node.new(4)
    left_node = Node.new(1)
    right_node = Node.new(3, nil, inserted_node)
    root_node = Node.new(2, left_node, right_node)
    expect(tree.root).to eq(root_node)
  end
end
