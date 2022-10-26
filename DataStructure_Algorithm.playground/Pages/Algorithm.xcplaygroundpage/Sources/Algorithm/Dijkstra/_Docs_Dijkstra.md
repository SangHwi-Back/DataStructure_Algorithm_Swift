# Dijkstra's Algorihm

GPS network 처럼 두 지점 간 최소 경로를 찾는 상황에서 유용하다.

Dijkstra 알고리즘은 탐욕법이다. 탐욕법은 단계별로 문제를 해결하고 각 단계마다 독립적으로 최적의 선택을 한다. 비용이 많이 드는 솔루션때문에 단점이 있지만, 결과적인 비용은 상대적으로 낮다. Dijkstra 알고리즘은 Directed/UnDirected Graph의 Vertice 간 최소 경로를 찾는다.

실제 사용되는 예시는 다음과 같다.

1. 감염경로 검색
2. 통화 네트워크
3. 지도

## 구현

```swift
enum Visit<T: Hashable> {
    case start
    case edge(Edge<T>)
}

func route(to destination: Vertex<T>, with paths: [Vertex<T>: Visit<T>]) -> [Edges<T>] {
    var vertex = destination
    var path = [Edge<T>]()
    
    while let visit = paths[vertex], case Visit.edge(let edge) = visit {
        path = [edge] + path
        vertex = edge.source
    }
    
    return path
}

func distance(to destination: Vertex<T>, with paths: [Vertex<T>: Visit<T>]) -> Double {
    let path = route(to: destination, with: paths)
    let distance = path.compactMap({ $0.weight })
    return distance reduce(0.0, +)
}

func shortestPicks(from start: Vertex<T> with paths: [Vertext<T>: Visit<T>]) -> Double {
    var paths: [Vertex<T>: Visit<T>] = [start: .start] // 도착 지점의 Vertex 에 
    
    var priorityQueue = PriorityQueue<Vertex<T>>(sort: {
        self.distance(to: $0, with: paths) < self.distance(to: $1, with: paths)
    })
    priorityQueue.enqueue(start)
    
    while let vertex = priorityQueue.dequeue() {
        for edge in graph.edges(from: vertex) {
            guard let weight = edge.weight else { continue }
            
            if paths[edge.destination] == nil || // 도달한 적이 없거나
                distance(to: vertex, with: paths) + weight <
                distance(to: edge.destination, with: paths) { // 비용이 더 낮으면
            
                paths[edge.destination] = .edge(edge)
                priorityQueue.enqueue(edge.destination)
            }
        }
    }
    
    return paths
}
```

## 성능

Dijkstra 알고리즘은 그래프의 인접 리스트를 사용했고, 최소 우선지향 큐를 사용하여 vertex와 vertex의 최소 경로를 저장하였다. 이 모든 과정은 O(log V) 시간복잡도를 갖는다. 만약 힙으로 최소값을 추출하거나 값을 추가하면 요소마다 O(log V) 만큼의 시간이 더 걸린다.

BFS 챕터에서 배웠듯, 모든 vertex와 edge를 순회하면 O(V+E) 시간복잡도를 갖는다. Dijkstra 알고리즘은 BFS와 비슷한데, 모든 인접한 edge를 방문해야 하기 때문이다. 다음으로 넘어가기 전에 최소 우선지향 큐를 이용하여 가장 짧은 거리를 갖는 하나의 vertex를 찾아보자. 시간복잡도는 O(1+E) 혹은 O(E)가 될 것이다. 그러므로 그래프 순회 작업과 최소 우선지향 큐 작업을 합치면 O(E log V) 시간복잡도가 나오는 것이다.

## 키포인트

* Dijkstra 알고리즘은 시작 vertex에서 시작하는 모든 경로의 노드들을 찾아낸다.
* 각각 다른 목적지를 갖는 최소경로를 찾는데 좋다.
* Visit 상태값은 edge 방향을 바꿔서 시작 vertex로 진행케 것도 가능하게 한다.
* 우선순위 큐 자료구조는 최소경로의 vertex를 반환한다.
* 각 단계마다 최소 경로를 고르기 때문에 탐욕법이라고 부른다.
