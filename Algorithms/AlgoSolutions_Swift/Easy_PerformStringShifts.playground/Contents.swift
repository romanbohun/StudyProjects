import Foundation

//You are given a string s containing lowercase English letters, and a matrix shift, where shift[i] = [direction, amount]:
//
// - direction can be 0 (for left shift) or 1 (for right shift).
// - amount is the amount by which string s is to be shifted.
// - A left shift by 1 means remove the first character of s and append it to the end.
// - Similarly, a right shift by 1 means remove the last character of s and add it to the beginning.
//
//Return the final string after all operations.
//
///Example 1:
///
///Input: s = "abc", shift = [[0,1],[1,2]]
///Output: "cab"
///Explanation:
///[0,1] means shift to left by 1. "abc" -> "bca"
///[1,2] means shift to right by 2. "bca" -> "cab"
///
///Example 2:
///
///Input: s = "abcdefg", shift = [[1,1],[1,1],[0,2],[1,3]]
///Output: "efgabcd"
///Explanation:
///[1,1] means shift to right by 1. "abcdefg" -> "gabcdef"
///[1,1] means shift to right by 1. "gabcdef" -> "fgabcde"
///[0,2] means shift to left by 2. "fgabcde" -> "abcdefg"
///[1,3] means shift to right by 3. "abcdefg" -> "efgabcd"
///
///Constraints:
///
///1 <= s.length <= 100
///s only contains lower case English letters.
///1 <= shift.length <= 100
///shift[i].length == 2
///0 <= shift[i][0] <= 1
///0 <= shift[i][1] <= 100
///
/// Hint 1
/// Intuitively performing all shift operations is acceptable due to the constraints.
///
/// Hint 2
/// You may notice that left shift cancels the right shift, so count the total left shift times (may be negative if the final result is right shift), and perform it once.
///

class PerformStringShifts {

    // 4 ms
    func stringShift(_ s: String, _ shift: [[Int]]) -> String {
        guard s.count > 1 else { return s }
        var shiftGroup = calcShift(shift)
        shiftGroup[1] = shiftGroup[1] % s.count
        var result = ""

        var offsetRight = 0
        var offsetLeft = 0

        if shiftGroup[0] == 1 {
            offsetRight = s.count - shiftGroup[1]
            offsetLeft = -shiftGroup[1]
        } else {
            offsetRight = shiftGroup[1]
            offsetLeft = -(s.count - shiftGroup[1])
        }

        let subseq1 = s.prefix(upTo: s.index(s.startIndex, offsetBy: offsetRight))
        let subseq2 = s.suffix(from: s.index(s.endIndex, offsetBy: offsetLeft))
        result = String(subseq2 + subseq1)

        return result
    }

    private func calcShift(_ shift: [[Int]]) -> [Int] {
        var result = shift[0]

        for (index, subarray) in shift.enumerated() {
            if index == 0 {
                continue
            }

            let direction = subarray[0]
            let steps = subarray[1]

            if direction == result[0] {
                result[1] += steps
            } else {
                let sum = result[1] - steps
                result[1] = abs(sum)
                result[0] = sum < 0 ? (result[0] == 1 ? 0 : 1) : result[0]
            }
        }
        return result
    }

}

let stringShift = PerformStringShifts()
stringShift.stringShift("abc", [[0,1],[1,2]])
stringShift.stringShift("abcdefg", [[1,1],[1,1],[0,2],[1,3]])
stringShift.stringShift("yisxjwry", [[1,8],[1,4],[1,3],[1,6],[0,6],[1,4],[0,2],[0,1]])
