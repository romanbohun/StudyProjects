func longestCommonPrefix(_ strs: [String]) -> String {
    guard strs.count > 0 else { return "" }

    let shortestString = strs.min{ $0.count < $1.count }!
    var longestPrefix = shortestString

    for word in strs {
        while !word.hasPrefix(longestPrefix), longestPrefix.count > 0 {
            longestPrefix.removeLast()
        }
    }

    return longestPrefix
}

longestCommonPrefix(["flower","flow","flight"])
//longestCommonPrefix(["a"])
