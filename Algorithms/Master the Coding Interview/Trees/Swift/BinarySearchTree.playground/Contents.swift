import Foundation

class BinarySearchTree<T> where T: Comparable {
    
    internal class Node<T> {
        let value: T
        var left: Node<T>?
        var right: Node<T>?
        
        init(_ value: T) {
            self.value = value
        }
    }

    var root: Node<T>?
    
    func insert(value: T) {
        let newNode = Node(value)
        if root == nil {
            self.root = newNode
            return
        }
        
        var currentNode = root
        while currentNode != nil {
            guard let unwrappedValue = currentNode?.value else {
              break
            }
            
            if value < unwrappedValue {
                if currentNode?.left == nil {
                    currentNode?.left = newNode
                    break
                }
                currentNode = currentNode?.left
            } else {
                if currentNode?.right == nil {
                    currentNode?.right = newNode
                    break
                }
                currentNode = currentNode?.right
            }
        }
    }
    
    func lookup(value: T) -> Bool {
        guard root != nil else {
            return false
        }
        
        var currentNode = root
        while currentNode != nil {
            guard let unwrappedValue = currentNode?.value else {
              break
            }
            if value == unwrappedValue {
                return true
            } else if value < unwrappedValue {
                currentNode = currentNode?.left
            } else {
                currentNode = currentNode?.right
            }
        }
        return false
    }
    
    func remove(value: T) {
        guard root != nil else {
            return
        }
        
        var currentNode = root
        var parentNode: Node<T>? = nil
        while currentNode != nil {
            guard let unwrappedValue = currentNode?.value else {
              break
            }
            if value < unwrappedValue {
                parentNode = currentNode
                currentNode = currentNode?.left
            } else if value > unwrappedValue {
                parentNode = currentNode
                currentNode = currentNode?.right
            } else {
                // 1. No right child
                if currentNode?.right == nil {
                    if parentNode == nil {
                        root = currentNode?.left
                    }
                } else {
                    if currentNode?.value < parentNode?.value {
                        parentNode?.left = currentNode?.left
                    } else {
                        parentNode?.right = currentNode?.left
                    }
                    
                // 2. Right child that doesn't have left child
                } else if currentNode?.right?.left == nil {
                    currentNode?.right?.left = currentNode?.left
                    if parentNode == nil {
                        root = currentNode?.right
                    } else {
                        if currentNode?.value < parentNode?.value {
                            parentNode?.left = currentNode?.right
                        } else {
                            parentNode?.right = currentNode?.right
                        }
                    }
                    
                // 3. Right child that have left child
                } else {
                    
                }
            }
            
            if value == unwrappedValue {
                
            } else if value < unwrappedValue {
                currentNode = currentNode?.left
            } else {
                currentNode = currentNode?.right
            }
        }
    }
}

let bst = BinarySearchTree<Int>()
bst.insert(value: 8)
bst.insert(value: 7)
bst.insert(value: 5)
bst.insert(value: 20)
bst.insert(value: 16)
bst.insert(value: 34)
print(bst)
//let encoder = JSONEncoder()
//encoder.outputFormatting = .prettyPrinted
//let data = try! encoder.encode(bst)
//print(data)
