import Foundation

public class AdjacencyList<T: Hashable>: Graph {
    private var allVertices: [Vertex<T>: [Edge<T>]] = [:]
    
    public init() {}
    
    public func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(index: allVertices.count, data: data)
        allVertices[vertex] = []
        return vertex
    }
    
    public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        allVertices[source]?.append(edge)
    }
    
    public func edges(from source: Vertex<T>) -> [Edge<T>] {
        allVertices[source] ?? []
    }
    
    public func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        edges(from: source)
            .first { $0.destination == destination }?
            .weight
    }
}

extension AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        
        for (vertex, edges) in allVertices {
            
            var edgeString = ""
            
            for (index, edge) in edges.enumerated() {
                
                if index != edges.count - 1  {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            
            result.append("\(vertex) ---> [ \(edgeString) ]\n")
        }
        
        return result
    }
}
