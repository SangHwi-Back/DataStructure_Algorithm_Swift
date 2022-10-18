import Foundation

extension Graph where Element: Hashable {
    public func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var stack: Stack<Vertex<Element>> = []
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        stack.push(source)
        pushed.insert(source)
        visited.append(source)
        
    outer: while let vertex = stack.peek() { // Loop until stack is empty.
        let neighbors = edges(from: vertex) // All neighbors
        
        guard neighbors.isEmpty == false else {
            stack.pop()
            continue
        }
        
        for edge in neighbors { // check All neighbors
            if pushed.contains(edge.destination) == false { // if neighbor is already visited...
                stack.push(edge.destination)
                pushed.insert(edge.destination)
                visited.append(edge.destination)
                continue outer
            }
        }
        
        stack.pop() // Dead End
    }
        
        return visited
    }
}
