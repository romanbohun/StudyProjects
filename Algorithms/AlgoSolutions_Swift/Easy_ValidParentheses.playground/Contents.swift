func isValid(_ s: String) -> Bool {
    if s == "" {
        return true
    }

    var _tmp = [Character]()

    for item in s {
        switch item {
        case "(":
            _tmp.append(")")
        case "{":
            _tmp.append("}")
        case "[":
            _tmp.append("]")
        default:
            if _tmp.last == item {
                _tmp.removeLast()
            } else {
                return false
            }
        }
    }

    return _tmp.isEmpty
}

isValid("([])")
