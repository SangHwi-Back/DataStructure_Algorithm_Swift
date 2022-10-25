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
    
    public func depthFirstSearch(
        _ stack: inout Stack<Vertex<Element>>,
        _ pushed: inout Set<Vertex<Element>>,
        _ visited: inout [Vertex<Element>]
    ) -> [Vertex<Element>] {
        guard let vertex = stack.peek() else {
            if let start = self.allVertices.first {
                stack.push(start)
                pushed.insert(start)
                visited.append(start)
                visited = self.depthFirstSearch(&stack, &pushed, &visited)
            }
            
            return visited
        }
        
        let neighbors = edges(from: vertex) // All neighbors
        
        guard neighbors.isEmpty == false else {
            stack.pop()
            return self.depthFirstSearch(&stack, &pushed, &visited)
            
        }
        
        for edge in neighbors { // check All neighbors
            if pushed.contains(edge.destination) == false { // if neighbor is already visited...
                stack.push(edge.destination)
                pushed.insert(edge.destination)
                visited.append(edge.destination)
                visited = self.depthFirstSearch(&stack, &pushed, &visited)
            }
        }
        
        stack.pop()
        visited = self.depthFirstSearch(&stack, &pushed, &visited)
        
        return visited
    }
}
