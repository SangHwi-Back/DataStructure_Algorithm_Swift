# 기본 개요

LinkedList 는 값들이 선형적으로 배치된 것을 말한다. 방향은 일방향이다. 이론적으로는 배열과 비슷하다.

- Constant 시간 복잡도를 갖고 List의 맨 앞에 대해 삽입과 삭제를 한다.

```
12 --> 1 --> 3 --> ...
```

LinkedList 는 노드 간의 연결로 이루어진다.
노드는 값을 저장하고, 다음 노드를 참조하고 있어야 한다. 다음 노드 참조값은 nil이 될 수 있는데 이는 자신이 마지막 노드라는 뜻이다.


## 성능 분석

- push : head에 node를 삽입함. O(1)
- append : tail에 node를 삽입함. O(1)
- insert(after:) : 특정 node 뒤에 node를 삽입함. O(1)
- node(at) : 특정 index에 위치한 node를 반환함. O(i). i는 index.

- pop : head를 삭제함. O(1)
- removeLast : tail을 삭제함. O(n)
- remove(after:) : 특정 index의 다음 node를 삭제하고 반환함. O(1)

## Key points

- LinkedList는 선형적이고 일방향이다. 한 노드에서 다른 노드로 검색을 이어나가면 다시 돌아올 수 없다.
- LinkedList는 O(1) 시간 복잡도를 push(head 추가), append(tail 추가)에 대해 가진다. 배열은 같은 작업에 대해 O(n) 시간 복잡도를 갖는다.
- Collection 프로토콜을 구현하여 유용한 메소드를 많이 사용할 수 있다.
- Copy-on-write(COW) 는 값은 유지하면서 좋은 효율을 보장해준다. 
