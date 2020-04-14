import Foundation

//Given an array of strings, group anagrams together.
//
///Example:
//
///Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
///Output:
///[
///  ["ate","eat","tea"],
///  ["nat","tan"],
///  ["bat"]
///]
///Note:
///
///All inputs will be in lowercase.
///The order of your output does not matter.
class GroupAnagrams {

    // A bit slower solution - beats 220ms
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var anagrams = [String:[String]]()
        for item in strs {
            let val = String(item.sorted())
            if anagrams[val] == nil {
                anagrams[val] = [String]()
            }
            anagrams[val]?.append(item)
        }
        return Array(anagrams.values)
    }

    // The fastest one - beats 192 ms
    func groupAnagrams2(_ strs: [String]) -> [[String]] {
        guard strs.count > 0 else {
            return []
        }

        var anagrams = [String:[String]]()
        for item in strs {
            let val = String(item.sorted())
            anagrams[val, default:[]].append(item)
        }
        return Array(anagrams.values)
    }

}

let groupAnagram = GroupAnagrams()
groupAnagram.groupAnagrams2(["eat", "tea", "tan", "ate", "nat", "bat"])
