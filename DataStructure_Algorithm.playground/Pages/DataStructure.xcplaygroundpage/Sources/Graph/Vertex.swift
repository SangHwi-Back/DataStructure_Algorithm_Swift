import Foundation

/// vertex : 고유의 인덱스와 데이터를 가짐.
public struct Vertex<T> {
    public let index: Int
    public let data: T
}

// Hashable inherited from Equatable.
// Conformance Hashable makes Vertex key feature.
extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
extension Vertex: CustomStringConvertible {
    public var description: String {
        "\(index): \(data)"
    }
}
