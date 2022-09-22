import Foundation

public struct Edge<T> {
    public let source: Vertex<T>
    public let destination: Vertex<T>
    public let weight: Double?
}

public struct Vertex<T> {
    public let index: Int
    public let data: T
}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
extension Vertex: CustomStringConvertible {
    public var description: String {
        "\(index): \(data)"
    }
}

public enum EdgeType {
    case directed
    case undirected
}

public protocol Graph {
    
    associatedtype Element
    var allVertices: [Vertex<Element>] { get }
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    func add(_ edge: EdgeType, from source: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
}

extension Graph {
    // This apis can be reusable.
    // The Power of Protocol!
    public func addUndirectedEdge(between source: Vertex<Element>,
                                  and destination: Vertex<Element>,
                                  weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func add(_ edge: EdgeType, from source: Vertex<Element>,
                                        to destination: Vertex<Element>,
                                        weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

extension Graph where Element: Hashable {
    public func numberOfPaths(from source: Vertex<Element>, to destination: Vertex<Element>) -> Int {
        var numberOfPaths = 0
        var visited = Set<Vertex<Element>>()
        
        paths(from: source,
              to: destination,
              visited: &visited,
              pathCount: &numberOfPaths)
        return numberOfPaths
    }
    
    func paths(from source: Vertex<Element>,
               to destination: Vertex<Element>,
               visited: inout Set<Vertex<Element>>,
               pathCount: inout Int) {
        visited.insert(source)
        
        if source == destination {
            pathCount += 1
        } else {
            let neighbors = edges(from: source)
            
            for edge in neighbors {
                if !visited.contains(edge.destination) {
                    
                    paths(from: edge.destination,
                          to: destination,
                          visited: &visited,
                          pathCount: &pathCount)
                }
            }
        }
        
        visited.remove(source)
    }
}
