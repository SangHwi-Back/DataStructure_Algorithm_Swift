
# Breadth-First Search

Graph 를 이용한 알고리즘 중 하나이다. BFS 는 다음의 상황에서 유용할 수 있다.

1. Minimum-spanning tree 를 사용해야 하는 경우
2. Vertices 간 경로 탐색을 할 때
3. Vertices 간 최소 경로를 탐색할 때

BFS 는 Graph 의 무작위 Vertex 를 선택하는 것으로 시작한다. 알고리즘을 통해 Vertex 의 모든 이웃 Vertex 들을 검사한다. 이름 그대로 폭부터 접근하기 시작한다.

아래의 구현을 통해 자세히 원리를 알아보자.

```swift
func breadthFirstSearch(_ graph: Graph, source: Node) -> [String] {
  var queue = Queue<Node>() // 1
  queue.enqueue(source) // 2

  var nodesExplored = [source.label]
  source.visited = true

  while let current = queue.dequeue() {
    for edge in current.neighbors { // 3
      let neighborNode = edge.neighbor
      if !neighborNode.visited {
        queue.enqueue(neighborNode) // 4
        neighborNode.visited = true
        nodesExplored.append(neighborNode.label)
      }
    }
  }

  return nodesExplored
}
```

1. Queue 를 사용한다. FIFO 방식을 사용하기 때문에 다음 순회가 이전 순회의 Vertex 다음임을 보장할 수 있다.
2. 우선 파라미터로 전달된 시작점(Start Vertex) 부터 queue에 삽입한다.
3. 현재 포함되어 있는 Queue 의 deque 를 실행한 뒤 neighbors 들을 검사해본다.
4. visited 가 false 인 vertex 가 발견되면 visited 를 true 로 바꿔준다. Queue 에도 visited 되었기 때문에 넣어준다.

## 성능

BFS 로 그래프를 순회하면 각 vertex 는 한번씩 enque 된다. O(n) 이지만 O(v) 라고 표현한다.<br/>
순회 중 모든 edge 도 방문하게 된다. O(n) 이지만 O(e) 로 표현한다.

두 개의 합인 O(v+e) 가 전체 시간 복잡도이다.

공간복잡도는 O(v) 이다. 공간복잡도에 관여하는 것이 queue, enque 이기 때문이다.

## 키 포인트

* BFS 는 그래프를 모두 순회하는 알고리즘이다.
* BFS 는 다음 Vertex 들을 탐색하기 전에 현재 Vertex 의 이웃을 전부 탐색한다.
* 많은 이웃 Vertex 들이 있을 경우나 모든 경우의 수를 탐색할 경우 유용하다.
* Queue 는 다음 레벨의 Vertex 를 순회하기 전에, Vertex edge들의 작업우선순위를 결정하기 위해 존재한다.