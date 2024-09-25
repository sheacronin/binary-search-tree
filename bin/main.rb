# frozen_string_literal: true

require_relative '../lib/tree'

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print

puts 'balanced?'
puts tree.balanced? # should be true

puts 'level order'
p tree.level_order
puts 'preorder'
p tree.preorder
puts 'postorder'
p tree.postorder
puts 'inorder'
p tree.inorder

puts 'inserting nodes...'
tree.insert(101)
tree.insert(102)
tree.insert(103)
tree.pretty_print
puts 'balanced?'
puts tree.balanced? # should be false

puts 'rebalancing...'
tree.rebalance
tree.pretty_print
puts 'balanced?'
puts tree.balanced? # should be true

puts 'level order'
p tree.level_order
puts 'preorder'
p tree.preorder
puts 'postorder'
p tree.postorder
puts 'inorder'
p tree.inorder
