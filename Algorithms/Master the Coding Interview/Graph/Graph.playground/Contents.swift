import Foundation

protocol GraphProtocol {
    associatedtype Element
    func addVertex(_ node: Element)
    func addEdge(_ node1: Element, _ node2: Element)
}

class Graph: GraphProtocol {
    typealias Element = String

    private var numberOfNodes: Int = 0
    private var adjacentList: [String: [String]] = [:]

    func addVertex(_ node: Element) {
        guard adjacentList[node] == nil else { return }
        adjacentList[node] = []
        numberOfNodes += 1
    }

    func addEdge(_ node1: Element, _ node2: Element) {
        addEdgeToList(node1, node2)
        addEdgeToList(node2, node1)
    }

    private func addEdgeToList(_ node1: Element, _ node2: Element) {
        guard adjacentList[node1] != nil else { fatalError("Node \(node1) doesn't exist ") }
        guard let array = adjacentList[node1],!array.contains(node2) else { return }
        adjacentList[node1]?.append(node2)
    }

    func printGraph() {
        let keys = adjacentList.keys.sorted()
        for item in keys {
            print("\(item) --> \(adjacentList[item]!)")
        }
    }
}


var myGraph = Graph()
myGraph.addVertex("0")
myGraph.addVertex("1")
myGraph.addVertex("2")
myGraph.addVertex("3")
myGraph.addVertex("4")
myGraph.addVertex("5")
myGraph.addVertex("6")
myGraph.addEdge("3", "1")
myGraph.addEdge("3", "4")
myGraph.addEdge("4", "2")
myGraph.addEdge("4", "5")
myGraph.addEdge("1", "2")
myGraph.addEdge("1", "0")
myGraph.addEdge("0", "2")
myGraph.addEdge("6", "5")

myGraph.printGraph()
