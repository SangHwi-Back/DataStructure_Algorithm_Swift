import Foundation

public class TreeNode<T>: CommonNode<T> {
    public var children: [TreeNode] = []
    
    public func add(_ child: TreeNode) {
        children.append(child)
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
