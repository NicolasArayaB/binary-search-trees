require_relative "node"

# Build a Tree class which accepts an array when initialized. The Tree class should have a root
#  attribute which uses the return value of #build_tree.

class Tree
  attr_accessor :root
  @sorted = 1

  def initialize
    @root = nil
  end

  # Method which takes an array of data and turns it into a balanced binary tree full of Node objects appropriately placed.
  def build_tree(ary)
    ary_sort(ary) if not sorted?

    if ary.size == 1
      new_node = new_node(ary)
      set_root(new_node)
      new_node
    elsif ary.size > 1
      new_node = new_node(ary)
      set_root(new_node)
      left = ary[0...ary.size / 2]
      right = ary[ary.size / 2 + 1..-1]
      new_node.left_node(build_tree(left))
      new_node.right_node(build_tree(right))
    end
    new_node
  end

  def new_node(ary)
    new_node = Node.new
    new_node.value(ary[ary.size / 2]) 
    new_node
  end

  def set_root(node)
    @root = node if @root.nil?
  end

  def sorted?
    @sorted == 0 ? true : false
  end

  def ary_sort(ary)
    ary.sort!.uniq!
    @sorted = 0
  end

  # #insert and #delete method which accepts a value to insert/delete

  def insert(num, node = @root)
    if num < node.r_value
      insert(num, node.left) if node.left
      if node.left.nil?
        new_node = Node.new
        new_node.value(num)
        node.left_node(new_node)
      end
    elsif num > node.r_value
      insert(num, node.right) if node.right
      if node.right.nil?
        new_node = Node.new
        new_node.value(num)
        node.right_node(new_node)
      end
    end
  end

  def min_value_node(node)
    temp = node
    temp = min_value_node(temp.left) unless temp.left.nil?
    temp
  end


  def delete_node(value, node = @root)
    return node if node.nil?

    # if value is less than node.value
    if value < node.r_value
      node.left = delete_node(value, node.left) if node.left

    # if value is greater than node.value
    elsif value > node.r_value
      node.right = delete_node(value, node.right) if node.right
    
    # if value is equal to node.value, delete it.
    elsif value == node.r_value
      
      # if node has no children
      if node.left.nil? && node.right.nil?
        node = nil

      # if node has only one child
      elsif node.left.nil?
        temp = node.right
        node = nil
        temp
      elsif node.right.nil?
        temp = node.left
        node = nil
        temp
      else

        # if node has two children, find the smallest value in the right subtree
        temp = min_value_node(node.right)
        node.value(temp.r_value)
        node.right = delete_node(temp.r_value, node.right)
      end
    end
    
    node
  end

# Method which accepts a value and returns the node with the given value.

  def find_node(value, node = @root)
    if node.r_value == value
      node
    elsif node.r_value > value
      find_node(value, node.left)
    elsif node.r_value < value
      find_node(value, node.right)
    end
  end

# Method that returns an array of values. This method should traverse the tree in breadth-first level order.

  def level_order
    return if self.root.nil?
    
    queue = Queue.new
    queue << self.root
    
    until queue.empty?
      node = queue.pop
      p node.r_value unless node.r_value.nil?
      queue << node.left if node.left
      queue << node.right if node.right
    end
  end

# #inorder, #preorder, and #postorder methods that returns an array of values. 
# Each method should traverse the tree in their respective depth-first order.

  def inorder(node = @root)
    return if node.nil?
    inorder(node.left) unless node.left.nil?
    p node.r_value
    inorder(node.right) unless node.right.nil?
  end

  def preorder(node = @root)
    return if node.nil?
    p node.r_value
    preorder(node.left)
    preorder(node.right) 
  end

  def postorder(node = @root)
    return if node.nil?
    postorder(node.left)
    postorder(node.right)
    p node.r_value
  end

# #height method which accepts a node and returns its height. 
# Height is defined as the number of edges in longest path from a given node to a leaf node.

  def height(node= @root)
    return 0 if node.nil?
    1 + [height(node.left), height(node.right)].max
  end

# #depth method which accepts a node and returns its depth. 
# Depth is defined as the number of edges in path from a given node to the tree’s root node.

  def depth(node)

  end

# Write a #balanced? method which checks if the tree is balanced. 
# A balanced tree is one where the difference between heights of left subtree and right subtree 
# of every node is not more than 1.

  def balanced?

  end

# #rebalance method which rebalances an unbalanced tree.

  def rebalance

  end
end

# A simple driver script.

# 1. Create a binary search tree from an array of random numbers (`Array.new(15) { rand(1..100) }`)
bst = Tree.new
#bst.build_tree(Array.new(15) { rand(1..100) })
bst.build_tree([2, 3, 5, 6, 7, 8])
# 2. Confirm that the tree is balanced by calling `#balanced?`
# 3. Print out all elements in level, pre, post, and in order
#bst.level_order
#bst.preorder
#bst.inorder
# bst.postorder
# 4. try to unbalance the tree by adding several numbers > 100
bst.insert(100)
bst.insert(200)
bst.insert(300)
bst.insert(400)
# 5. Confirm that the tree is unbalanced by calling `#balanced?`
# 6. Balance the tree by calling `#rebalance`
# 7. Confirm that the tree is balanced by calling `#balanced?`
# 8. Print out all elements in level, pre, post, and in order

#p bst.delete_node(6)
#p bst.find_node(7)
p bst.height