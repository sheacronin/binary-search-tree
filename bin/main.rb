# frozen_string_literal: true

require_relative '../lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print

tree2 = Tree.new([1, 2, 3])
tree2.insert(4)
tree2.pretty_print
