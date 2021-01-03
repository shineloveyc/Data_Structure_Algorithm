class Node(object):
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
        class Node(object):
            def __init__(self, value):
                self.value = value
                self.left = None
                self.right = None

class BST(object):
    def __init__(self, root):
        self.root = Node(root)

    def insert(self, new_val):
        if self.root.value != new_val:
            self.compare(self.root, new_val)

    def search(self, find_val):
        return self.binary_search(self.root, find_val)

    def binary_search(self, start, find_val):
        if start:
            if start.value==find_val:
                return True
            elif start.value < find_val:
                return self.binary_search(start.left, find_val)
            else:
                return self.binary_search(start.right, find_val)
        return False

    def compare(self, start, new_val):
        if start:
            if start.value<new_val:
                if start.left:
                    self.compare(start.left, new_val)
                else:
                    #add a new node to the left
                    start.left = Node(new_val)
                    #print(start.left.value)
            elif start.value > new_val:
                if start.right:
                    self.compare(start.right, new_val)
                else:
                    #add a new node to the right
                    start.right = Node(new_val)
                    #print(start.right.value)
            else:
                print('compare fail 1')
        else:
            print('compare fail 2')

# Set up tree
tree = BST(4)

# Insert elements
tree.insert(2)
tree.insert(1)
tree.insert(3)
tree.insert(5)

# Check search
# Should be True
print tree.search(4)
# Should be False
print tree.search(6)
