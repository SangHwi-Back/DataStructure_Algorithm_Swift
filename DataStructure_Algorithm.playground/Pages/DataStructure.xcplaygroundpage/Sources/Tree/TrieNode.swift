import Foundation

public class TrieNode<Key: Hashable> {
    
    public var key: Key? // nil when node is root.
    
    public weak var parent: TrieNode? // weak simplifies remove method.
    
    public var children: [Key: TrieNode] = [:] // all childrens must distinguishable.
    
    public var isTerminating = false
    
    public init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}
