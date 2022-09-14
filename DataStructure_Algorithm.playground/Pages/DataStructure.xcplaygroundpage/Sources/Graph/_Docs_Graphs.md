# Graphs

graph 는 객체 간의 관계를 정의한다. graph 는 vertices 로 구성되고, edges 로 연결된다. 주로 그래프를 표현할 때 동그라미와 그것을 연결하는 선으로 표현하는데 동그라미는 vertices, 선은 edges 로 이해하면 된다.

## Weighted graphs

가중 그래프는 edge 를 지나는 데 드는 비용이 존재하는 그래프를 말한다. 이 비용을 통해 두 vertices 중 가장 합리적인 결과를 정할 수 있게 한다.

## Directed graphs

유향 그래프는 탐색에 제한이 추가되는데, 한번에 한 vertices 만 이동 가능하다는 것이다. edge 는 단방향 혹은 양방향일 수 있다.

## Undirected graphs

비유향 그래프는 유향 그래프와 유사하나, edge 가 언제나 양방향이다.

## 기본 구현

protocol 로 만들어질 수 있는데 다음의 API 가 필요하다.

* createVertex(data:) : vertex 를 만들고 그래프에 삽입한다.
* addDirectedEdge(from:to:weight:) : 단뱡향의 edge 를 두 vertice 사이에 삽입한다.
* addUndirectedEdge(between:and:weight:) : 양방향의 edge 를 두 vertice 사이에 삽입한다.
* add(from:to:) : edge 의 타입을 이용해 단방향 혹은 양방향의 edge 를 두 vertice 사이에 삽입한다.
* edges(from:) : 특정 vertex 에서 출발하는 edge 를 반환한다.
* weight(from:to:) : 특정 vertex 에서 가중된 edge 를 반환한다.

이들은 **인접배열**, **인접행렬** 을 통해 구현이 가능하다.

### 인접배열로서의 구현

그래프의 인접배열이 모든 vertex 와 vertex 로부터 출발하는 edge 정보를 담고 있다.

### 인접행렬로서의 구현

인접행렬은 2차원 배열로 구현한다.

directed graph 에서 `matrix[row][column]` 에서 row 는 edge 의 출발점, column 은 도착점 이 된다. 값은 weight 혹은 vertex 의 데이터가 된다.

## 효율성에 대하여

### 시간복잡도

|Operations|Adjacency List|Adjacency Matrix|
|---|:-:|:-:|
|Storage Space|O(V+E)|O(V2)|
|Add Vertex|O(1)|O(V2)|
|Add Edge|O(1)|O(1)|
|Finding Edges and Weight|O(V)|O(1)|

V 는 vertices, E 는 edges 를 뜻한다.

* 인접배열은 공간복잡도 측면에서 인접행렬보다 우수하다.<br/>인접배열이 vertex 와 edge 를 단순히 추가하는 것에 비해, 인접행렬은 vertex 를 추가한 뒤 행렬을 다시 호출하고 연산해야 하기 때문이다.<br/>
인접배열에서 edge 에 대해서는 O(1) 시간복잡도를 갖는데, 단순히 행렬에 O(1) 작업만 하기 때문이다.
* 특정 edge 와 weight(data) 를 찾을 때는 인접행렬이 우수하다.<br/>
인접배열이 특정 요소를 찾기 위해 모든 edge 를 살펴보는 동안, 인접행렬은 어떤 edge 를 찾건 간에 동일한 시간복잡도를 갖는다.

### 어떤 그래프를 선택해야 할까?

edge 가 많이 없는 그래프라면 인접배열로 구현된 그래프가 좋다. 인접행렬은 이 경우 많은 메모리를 의미없이 소비하게 된다(sparse graph).

반대로 edge 가 많이 있을 것으로 예상되는 그래프라면 인접행렬로 구현된 그래프가 좋다(dense graph).

## 키 포인트

* vertices 는 객체, edges 는 객체 간 관계를 정의한다.
* Weighted graphs 는 edge 에 가중치 혹은 값이 포함된 그래프이다.
* Directed graphs 는 edge 가 단방향인 그래프이다.
* Undirected graphs 는 edge 가 양방향인 그래프이다.
* Adjacency list 는 모든 vertex 에 대해 나가는 edge 를 저장한다. edge 가 많지 않은 데이터를 처리하는 데에 적합하다(sparse graph).
* Adjacency matrix 는 2차원 배열로 그래프를 표현한다. edge 가 많은 데이터를 처리하는 데에 적합하다(dense graph).