import Foundation

//Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.
//
//Example:
//Given a binary tree
//          1
//         / \
//        2   3
//       / \
//      4   5
//Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].
//
//Note: The length of path between two nodes is represented by the number of edges between them.

//  Definition for a binary tree node.
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

// 32 ms - beats 74.45 %
class DiameterOfBinaryTree {

    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        let heightKeeper = HeightKeeper()
        return getDiameter(root, heightKeeper)
    }

    func getDiameter(_ root: TreeNode?, _ heightKeeper: HeightKeeper) -> Int {
        guard root != nil else {
            heightKeeper.height = 0;
            return 0;
        }

        let leftHeightKeeper = HeightKeeper()
        let rightHeightKeeper = HeightKeeper()

        let leftDiameter = getDiameter(root?.left, leftHeightKeeper)
        let rightDiameter = getDiameter(root?.right, rightHeightKeeper)

        heightKeeper.height = max(leftHeightKeeper.height, rightHeightKeeper.height) + 1

        return max(leftHeightKeeper.height + rightHeightKeeper.height, max(leftDiameter, rightDiameter))
    }

    class HeightKeeper {

        var height: Int = 0

    }

}


/// Solutions that are quickest taken from the site
// 24 ms
class Solution1 {

    private var result: Int = 0

    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        let _ = findMax(root)
        return result
    }

    private func findMax(_ root: TreeNode?) -> Int {
        guard let root = root else {
            return 0
        }

        let leftMax = findMax(root.left)
        let rightMax = findMax(root.right)

        result = max(result, leftMax + rightMax)

        return max(leftMax, rightMax) + 1
    }
}

//28 ms
class Solution2 {
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var result = 0

        //the largest depth from a node
        @discardableResult
        func dfs(_ node: TreeNode?) -> Int {
            guard let node = node else {
                return 0
            }
            let left = dfs(node.left)
            let right = dfs(node.right)

            result = max(result, left + right)
            return 1 + max(left, right)
        }

        dfs(root)
        return result
    }
}

