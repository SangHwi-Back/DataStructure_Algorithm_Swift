import Foundation


//: ![sampleGraph](sampleGraph.png)

let graph = AdjacencyList<Int>()

let v1 = graph.createVertex(data: 1)
let v2 = graph.createVertex(data: 2)
let v3 = graph.createVertex(data: 3)
let v4 = graph.createVertex(data: 4)
let v5 = graph.createVertex(data: 5)
let v6 = graph.createVertex(data: 6)

graph.add(.undirected, from: v1, to: v2, weight: 6)
graph.add(.undirected, from: v1, to: v3, weight: 1)
graph.add(.undirected, from: v1, to: v4, weight: 5)

graph.add(.undirected, from: v2, to: v3, weight: 5)
graph.add(.undirected, from: v2, to: v5, weight: 3)

graph.add(.undirected, from: v3, to: v5, weight: 6)
graph.add(.undirected, from: v3, to: v4, weight: 5)
graph.add(.undirected, from: v3, to: v6, weight: 4)

graph.add(.undirected, from: v4, to: v6, weight: 2)

graph.add(.undirected, from: v5, to: v6, weight: 6)

let (cost, mst) = Prim().produceMinimumSpanningTree(for: graph)

print("cost: \(cost)")
print("mst:")
print(mst)
