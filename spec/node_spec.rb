# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/node'

describe 'attributes' do
  it 'holds data and default empty child nodes' do
    node = Node.new(1)
    expect(node).to have_attributes(data: 1, left_child: nil, right_child: nil)
  end

  it 'initializes with passed in child nodes' do
    left = Node.new(1)
    right = Node.new(3)
    node = Node.new(2, left, right)
    expect(node).to have_attributes(data: 2, left_child: left, right_child: right)
  end
end

describe 'comparable' do
  it 'compares nodes of different values' do
    lesser = Node.new(1)
    greater = Node.new(5)
    expect(lesser < greater).to be(true)
    expect(lesser > greater).to be(false)
    expect(lesser == greater).to be(false)
    expect(lesser <= greater).to be(true)
    expect(lesser >= greater).to be(false)
  end

  it 'compares nodes with equal values' do
    a = Node.new(1)
    b = Node.new(1)
    expect(a == b).to be(true)
    expect(a < b).to be(false)
    expect(a > b).to be(false)
    expect(a <= b).to be(true)
    expect(a >= b).to be(true)
  end
end
