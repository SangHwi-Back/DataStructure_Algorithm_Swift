## Key points

- FIFO 방식으로 첫번째 넣은 요소가 가장 먼저 제거된다.
- Enqueue 는 요소를 Queue의 가장 뒤로 추가한다.
- Dequeue 는 Queue 가장 앞의 요소를 방출한다.
- Array을 이용한 Queue의 요소들은 메모리에 서로 붙어있는 상태로 위치한다.
- LinkedList를 이용한 Queue의 요소들은 메모리에 흩뿌려져 있다.
    - 잠재적으로 Cache 가 되지 않는 경우가 있다.
- RingBuffer를 이용한 Queue는 정해진 크기를 가진 Queue에 적합하다.
- 다른 자료구조들에 비해, Double-Stack Queue는 dequeue 시간 복잡도 효율이 좋다.
    - 위의 Queue의 dequeue 시간복잡도는 O(n) 이지만 O(1) 만큼의 효과를 보장한다.
    - LinkedList를 이용한 Queue에 비해 로컬 저장의 관점에서 뛰어나다.
