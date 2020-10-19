import Foundation

extension BinarySearchTree: CustomStringConvertible {
    var description: String {
        var result = ""
        var currentNode = root
        if currentNode == nil {
            return ""
        }
        traverse(node: currentNode!)
        return result
    }

    func traverse(node: Node<T>) {
        print("------------------")
        if let nodeLeft = node.left {
            print("left - ")
            print(nodeLeft.value)
            traverse(node: nodeLeft)
        }

        if let nodeRight = node.right {
            print("right - ")
            print(nodeRight.value)
            traverse(node: nodeRight)
        }
    }
}

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
            root = newNode
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


    func remove(value: T) -> Bool {
        guard root != nil else {
            return false
        }

        var currentNode = root
        var parentNode: Node<T>? = nil
        while currentNode != nil {
            guard let unwrappedValue = currentNode?.value else {
                break
            }

            parentNode = currentNode
            if value < unwrappedValue {
                currentNode = currentNode?.left
            } else if value > unwrappedValue {
                currentNode = currentNode?.right
            } else if value == unwrappedValue {

                if currentNode?.right == nil {
                    if (parentNode == nil) {
                        root = currentNode?.left
                    } else {
                        if let currentNodeValue = currentNode?.value,
                            let parentNodeValue = parentNode?.value,
                            currentNodeValue < parentNodeValue {
                            parentNode?.left = currentNode?.left
                        } else if let currentNodeValue = currentNode?.value,
                            let parentNodeValue = parentNode?.value,
                            currentNodeValue > parentNodeValue {
                            parentNode?.right = currentNode?.left
                        }
                    }

                } else if currentNode?.right?.left == nil {
                    if (parentNode == nil) {
                        root = currentNode?.left
                    } else {
                        currentNode?.right?.left = currentNode?.left
                        if let currentNodeValue = currentNode?.value,
                            let parentNodeValue = parentNode?.value,
                            currentNodeValue < parentNodeValue {
                            parentNode?.left = currentNode?.left
                        } else if let currentNodeValue = currentNode?.value,
                            let parentNodeValue = parentNode?.value,
                            currentNodeValue > parentNodeValue {
                            parentNode?.right = currentNode?.right
                        }
                    }
                } else {

                    var leftMost = currentNode?.right?.left
                    var leftMostParent = currentNode?.right
                    while leftMost?.left != nil {
                        leftMostParent = leftMost
                        leftMost = leftMost?.left
                    }

                    leftMostParent?.left = leftMost?.right
                    leftMost?.left = currentNode?.left
                    leftMost?.right = currentNode?.right

                    if parentNode == nil {
                        root = leftMost
                    } else {
                        if let currentNodeValue = currentNode?.value,
                            let parentNodeValue = parentNode?.value,
                            currentNodeValue < parentNodeValue {
                            parentNode?.left = leftMost
                        } else if let currentNodeValue = currentNode?.value,
                            let parentNodeValue = parentNode?.value,
                            currentNodeValue > parentNodeValue {
                            parentNode?.right = leftMost
                        }
                    }
                }
            }
        }
        return true
    }
}

let bst = BinarySearchTree<Int>()
bst.insert(value: 8)
bst.insert(value: 7)
bst.insert(value: 5)
bst.insert(value: 20)
bst.insert(value: 16)
bst.insert(value: 34)
bst.remove(value: 16)
print(bst)
