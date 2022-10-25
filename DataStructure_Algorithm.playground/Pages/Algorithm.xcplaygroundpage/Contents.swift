import Foundation

var graph = AdjacencyMatrix<String>()
//graph.createVertex(data: Elem(value: "A"))
let a = graph.createVertex(data: "A")
let b = graph.createVertex(data: "B"); graph.addDirectedEdge(from: a, to: b, weight: 1)
let c = graph.createVertex(data: "C"); graph.addDirectedEdge(from: b, to: c, weight: 1)
let d = graph.createVertex(data: "D"); graph.addDirectedEdge(from: b, to: d, weight: 1)
let e = graph.createVertex(data: "E"); graph.addDirectedEdge(from: c, to: e, weight: 1)
let f = graph.createVertex(data: "F"); graph.addDirectedEdge(from: c, to: f, weight: 1)
let g = graph.createVertex(data: "G"); graph.addDirectedEdge(from: f, to: g, weight: 1)

graph.addDirectedEdge(from: g, to: a, weight: 1) // Tie the knot

let vertices = graph.depthFirstSearch(from: a)
vertices.forEach { vertex in
    print(vertex)
}

var stack = Stack<Vertex<String>>()
var pushed = Set<Vertex<String>>()
var visited = [Vertex<String>]()

let vertices2 = graph.depthFirstSearch(&stack, &pushed, &visited)
vertices2.forEach { vertex in
    print(vertex)
}
