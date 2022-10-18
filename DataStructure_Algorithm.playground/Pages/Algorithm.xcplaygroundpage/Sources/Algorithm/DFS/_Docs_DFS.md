# Depth-First-Search

DFS 는 다음의 상황에서 유용하다.

1. 토폴로지 정렬
2. Cycle 감지/추적
3. 경로 탐색(미로 퍼즐같은 것.

DFS 구현을 위해서는 주어진 소스가 vertex 여야 한다. 그리고, 도착지점으로 갈 때까지 도달할 수 있는 경로를 최대한 많이 탐색해야 한다.

그렇기 때문에 backtrack(한 칸 뒤로 이동)을 이용하여 가능한 한 모든 브랜치를 최대한 검색한다.

DFS도 BFS 처럼 Stack 이 필요하다. Stack's LIFO 특성은 Backtracking 을 가능케 해준다. push 가 되었다는 것은 새로운 단계에 접어들었다는 얘기고, pop이 리턴하는 것은 이전 레벨이 마지막에 다다랐다는 것이다.

1. 출발점에서 vertex 를 stack 에 넣는다. 그리고 첫번째 이웃 vertex 도 stack 에 넣는다.
    첫번째 이웃 vertex 의 이웃들도 살펴보고 stack 에 추가한다. 출발점 vertex 는 제외해야 한다.
    최대한 많은 vertex 를 stack 에 넣는다.
2. 도착점 혹은 맨 마지막에 도달했다면 stack 에서 하나씩 pop 한다.
    pop 하다가 방문하지 않은 vertex 가 후보로 발견된다면 push 한다. 
    새로 push 된 vertex 들은 1번과 마찬가지로 이웃 vertex 를 찾아서 stack 에 push 하거나 pop 한다.

## 구현

```swift
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
```

## 성능

2가지 측면을 볼 필요가 있다.

DFS 의 시간복잡도는 O(V) 이다. 모든 Vertex 를 최소 한번씩 방문하기 때문이다.

Graph 를 DFS 로 순회할 때, 모든 이웃 vertices 를 순회하여 방문 가능한 vertex 를 찾아야 한다. 시간복잡도는 O(E) 인데 모든 vertex 에 방문한다는 것은 최악의 상황일 때 모든 edge 에 방문한다는 것이기 때문이다.

결과적으로, O(V+E) 이다.

공간복잡도는 O(V) 이다. vertices 를 stack, pushed, visited 자료구조에 저장해야 하기 때문이다.

## 키포인트

* DFS는 그래프 순회 혹은 탐색 알고리즘이다.
* 도착지점까지의 경로를 최대한 많이 이동한다.
* Stack 자료구조를 이용해서 Graph가 얼마나 깊던 간에 경로를 계속 추적할 수 있다. Stack은 도착지점에서부터 pop 된다. 
