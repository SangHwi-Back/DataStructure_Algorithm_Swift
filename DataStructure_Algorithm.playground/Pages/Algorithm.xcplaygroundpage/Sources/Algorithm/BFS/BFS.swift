import Foundation

extension Graph where Element: Hashable {
    func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            neighborEdges.forEach { edge in
                if !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
                }
            }
        }
        
        return visited
    }
    
    // Recirsive??
    func breadthFirstSearch(
        from queue: inout QueueStack<Vertex<Element>>,
        start source: Vertex<Element>,
        _ result: inout [Vertex<Element>]) -> [Vertex<Element>]
    {
        
        if queue.isEmpty, result.isEmpty {
            queue.enqueue(source)
        }
        
        guard let vertex = queue.dequeue() else {
            return result
        }
        
        for edge in edges(from: vertex) {
            if result.contains(edge.destination) == false {
                result.append(edge.destination)
                queue.enqueue(edge.destination)
                result += breadthFirstSearch(from: &queue, start: source, &result)
            }
        }
        
        return result
    }
    
    func bfs(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueStack<Vertex<Element>>()
        var enqueued = Set<Vertex<Element>>()
        var visited = [Vertex<Element>]()
        
        queue.enqueue(source)
        enqueued.insert(source)
        
        bfs(queue: &queue, enqueued: &enqueued, visited: &visited)
        
        return visited
    }
    
    private func bfs(queue: inout QueueStack<Vertex<Element>>,
                     enqueued: inout Set<Vertex<Element>>,
                     visited: inout [Vertex<Element>]) {
        guard let vertex = queue.dequeue() else {
            return
        }
        
        visited.append(vertex)
        let neighborEdges = edges(from: vertex)
        neighborEdges.forEach { edge in
            if enqueued.contains(edge.destination) == false {
                queue.enqueue(edge.destination)
                enqueued.insert(edge.destination)
            }
        }
        
        bfs(queue: &queue, enqueued: &enqueued, visited: &visited)
    }
    
//    func isDisConnected() -> Bool {
//        var result = 0
//        if let firstVertex = allVertices.first {
//            result = breadthFirstSearch(from: firstVertex).count
//        }
//        
//        return result != self.allVertices.count
//    }
//    
//    func isDisConnectedEnhanced() -> Bool {
//        
//        guard let firstVertex = allVertices.first else {
//            return false
//        }
//        
//        let visited = breadthFirstSearch(from: firstVertex)
//        
//        for vertex in allVertices {
//            if visited.contains(vertex) == false {
//                return true
//            }
//        }
//        
//        return false
//    }
}
