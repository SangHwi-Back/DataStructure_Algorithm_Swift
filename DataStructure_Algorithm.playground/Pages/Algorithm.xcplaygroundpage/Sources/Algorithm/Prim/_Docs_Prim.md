# Prim's Algorihm

Prim's Algorithm은 수도관 네트워크를 수립하는 것처럼 Graph의 모든 vertex에 도달하는 edge 정보를 얻어내는 알고리즘이다. 수도관 네트워크는 가장 적은 비용으로 모든 포인트를 지나도록 수립하는 것이 가장 경제적인데 이런 경우 유용한 것이다.

Prim's Algorithm는 spanning tree를 사용하는 알고리즘이다.

spanning tree는 undirected graph의 sub graph이다. 모든 그래프의 vertices를 포함하고 있고, 최소한의 edge만을 갖는다. 하지만 spanning tree는 cycle하지 않고 disconnected 하지 않는다. 삼각형을 이루는 undirected graph(A - B - C - A) 에서 세 개의 서로 다른 spanning tree(A - B/C, A - C - B, A - B - C)를 구성할 수 있다. 

앞에서 말한 spanning tree 중 Prim's algorithm은 minimum spanning tree을 사용한다. minimum spanning tree는 전체 edge로 확인 가능한 weight의 총합을 통해 최소의 총합을 갖는 tree를 말한다. 이 트리는 여러 상황에서 사용될 수 있는데, 예를 들어 수도관 네트워크를 수립하는 방법이다.

Prim's algorithm에서는 greedy algorithm도 사용된다. greedy는 단계마다 최적화 된 결정을 한다. 모든 결정은 독립적으로 진행된다. Prim's algorithm은 매 순간 minimum spanning tree를 선택한다. minimum spanning tree를 구별하는 방법은 edge를 선택함을 통해 구별한다. greedy를 사용하는 이유는 vertex를 선택하는 매 순간마다 최소의 weight를 가진 edge를 선택하기 떄문이다.

구현할 때는 Adjacency List Graph, Priority Queue가 필요하다. Priority Queue가 사용되는 이유는 Dijkstra와 같이 min-Priority Queue를 사용하기 위해서이다. 최소한의 weight를 가진 edge를 선택해야 하기 때문이다.

## 구현

```swift

```

## 성능

Prim's algorithm은 세 개의 자료구조를 사용한다.

1. Adjacency List Graph를 이용해서 mst를 만든다. vertex/edge를 추가하는 작업은 O(1)
2. 방문한 vertex를 저장하는 Set에 vertex를 저장하고 조회하는 작업은 O(1)
3. min-Priority Queue에 edges를 저장하고 vertex를 지정하는 작업(삽입)은 (Heap으로 구성되어 있기 때문에) O(log E)

그러므로 O(E log E) 의 시간복잡도를 갖는다. deque가 일어날 때마다 해당하는 edge를 모두 순회해야 하고 ( O(E) ), edge를 Priority Queue에 삽입해야 한다( O(logE) ).

## 키포인트

* spanning tree 는 undirected graph의 subgraph이고 모든 vertex들 중 가장 작은 비용의 edge를 가지는 트리다.
* Prim's algorithm은 greedy 알고리즘으로 minimum spanning tree를 생성한다. 알고리즘 단계마다 가장 작은 edge를 선택하기 때문이다.
* Prim's algorithm을 구현하기 위해서는 3 개의 자료구조(Priority Queue / Set / Adjacency List)를 이용해야 한다.
