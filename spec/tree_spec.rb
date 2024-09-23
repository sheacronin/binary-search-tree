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
end
