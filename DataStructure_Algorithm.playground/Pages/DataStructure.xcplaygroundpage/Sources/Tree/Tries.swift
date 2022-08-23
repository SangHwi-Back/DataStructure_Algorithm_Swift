import Foundation

public class Trie<CollectionType: Collection & Hashable> where CollectionType.Element: Hashable { // generic이 아닌 CollectionType.Element (CollectionType 이 아닌) 는 Hashable 을 구현해야 하는 경우 == 가 아닌 : 를 사용한다.
    
    public typealias Node = TrieNode<CollectionType.Element>
    
    private let root = Node(key: nil, parent: nil)
    
    public private(set) var collections: Set<CollectionType> = []
    
    public var count: Int {
        collections.count
    }
    
    public var isEmpty: Bool {
        collections.isEmpty
    }
    
    public init() {}
    
    public func insert(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            if current.children[element] == nil {
                current.children[element] = Node(key: element, parent: current)
            }
            current = current.children[element]!
        }
        
        if current.isTerminating {
            return
        } else {
            current.isTerminating = true
            collections.insert(collection)
        }
    }
    
    public func contains(_ collection: CollectionType) -> Bool {
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else {
                return false // Trie가 주어진 collection 을 포함하지 않을 경우 false
            }
            
            current = child
        }
        
        return current.isTerminating
    }
    
    /// 주어진 Collection 을 삭제하는 것을 목표로 한다. 하지만, Collection 중 terminating 한 노드가 포함될 경우는 terminating 한 노드 이후의 노드만 제거한다.
    public func remove(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            current = child
        }
        
        guard current.isTerminating else {
            return
        }
        
        current.isTerminating = false
        collections.remove(collection)
        
        // Terminating 이후 노드만 제거하는 while loop.
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}

public extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType) -> [CollectionType] { // prefix는 root의 chlidren 부터 일치해야 한다.
        var current = root
        for element in prefix {
            guard let child = current.children[element] else {
                return []
            }
            current = child
        }
        
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
        var results = [CollectionType]()
        
        if node.isTerminating {
            results.append(prefix)
        }
        
        for child in node.children.values {
            var prefix = prefix
            prefix.append(child.key!)
            results.append(contentsOf: collections(startingWith: prefix,
                                                   after: child)) // 동적 프로그래밍
        }
        
        return results
    }
}

/**
 Collection 들을 저장하는 데 특화 되어 있습니다( 영어 단어 등 ). 접두사를 매칭 시키는 데에 특화되어 있습니다.
 */
class EnglishDictionary {
    private var words = [String]()
    
    func words(matching prefix: String) -> [String] {
        words.filter({ $0.hasPrefix(prefix) })
    }
}
