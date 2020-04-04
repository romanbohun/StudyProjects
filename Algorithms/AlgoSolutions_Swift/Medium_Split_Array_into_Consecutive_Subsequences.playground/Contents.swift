/// https://leetcode.com/problems/split-array-into-consecutive-subsequences/
// Example 1:
//Input: [1,2,3,3,4,5]
//Output: True
//Explanation:
//You can split them into two consecutive subsequences :
//1, 2, 3
//3, 4, 5

// Example 2:
//Input: [1,2,3,3,4,4,5,5]
//Output: True
//Explanation:
//You can split them into two consecutive subsequences :
//1, 2, 3, 4, 5
//3, 4, 5

// Example 3:
//Input: [1,2,3,4,4,5]
//Output: False

import Foundation

func isPossible(_ nums: [Int]) -> Bool {
    if nums.count < 3 {
        return false
    }

    var sequences: [Int:Int] = [:]
    var tails: [Int:[Int]] = [:]

    var expectedItem = nums[0]
    var seqNumber = 1
    var currentSeq = seqNumber
    var prevNumber = expectedItem
    for (index, item) in nums.enumerated() {
        print("\(index), \(item)")
        if item == expectedItem {
            if let existSeq = tails[expectedItem]?.first {
                currentSeq = existSeq
            } else {
                currentSeq = seqNumber
            }
            if sequences[currentSeq] != nil {
                sequences[currentSeq]! += 1
            } else {
                sequences[seqNumber] = 1
            }
            //                tails[expectedItem]?.removeFirst(currentSeq)
            tails[expectedItem]?.removeAll { value -> Bool in
                value == currentSeq
            }
            if let isEmpty = tails[expectedItem]?.isEmpty, isEmpty {
                tails[expectedItem] = nil
            }
            expectedItem += 1
            tails[expectedItem] = []
            tails[expectedItem]?.append(currentSeq)
        } else {
            if let seqTail = tails[item]?.first {
                sequences[seqTail]! += 1
                tails[item]?.removeAll { value -> Bool in
                    value == seqTail
                }
                if let isEmpty = tails[item]?.isEmpty, isEmpty {
                    tails[item] = nil
                }
            } else {
                seqNumber += 1
                sequences[seqNumber] = 1
            }
            if let isEmpty = tails[expectedItem]?.isEmpty, !isEmpty {
                tails[expectedItem]?.append(seqNumber)
            } else {
                tails[expectedItem] = []
                tails[expectedItem]?.append(seqNumber)
            }
        }

        prevNumber = item
    }

    return sequences.allSatisfy { key, value -> Bool in
        value >= 3
    }
}

isPossible([1,2,3,3,4,5])
