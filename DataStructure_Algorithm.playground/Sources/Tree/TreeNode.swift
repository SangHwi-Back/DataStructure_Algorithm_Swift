import Foundation

public class TreeNode<T>: CommonNode<T> {
    
    var parent: TreeNode<T>?
    
    public var children: [TreeNode] = []
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
    
    public init(value: T, parent: TreeNode<T>? = nil) {
        self.parent = parent
        super.init(value: value)
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var result = ""
        var children: [TreeNode]!
        
        self.forEachLevelOrder(visit: { node in
            if children == nil { // root 혹은 다음 레벨을 시작해야 하는 경우
                children = node.children
                result += "\(node.value) \n"
                return
            }
            
            if children.contains(node) { // 현재 level 에서 탐색하는 경우
                result += "\(node.value) "
            } else if let first = children.first { // 새로운 레벨을 시작하는 경우
                result += "\n"
                children = children.reduce(into: [first], { partialResult, childrenNode in
                    partialResult?.append(contentsOf: childrenNode.children)
                })
                result += "\(node.value) "
            }
        })
        
        return result
    }
}

extension TreeNode {
    /// 깊이 우선 순회
    public func forEachDepthFirst(visit: (TreeNode)->Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
    
    /// 단계별 순회
    public func forEachLevelOrder(visit: (TreeNode)->Void) {
        visit(self)
        var queue = QueueArray<TreeNode>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}

extension TreeNode where T: Equatable {
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachLevelOrder { node in
            if node.value == value {
                result = node
            }
        }
        
        return result
    }
}
