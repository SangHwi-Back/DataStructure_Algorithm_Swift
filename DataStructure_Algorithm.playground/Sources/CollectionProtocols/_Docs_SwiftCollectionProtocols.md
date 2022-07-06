# Swift Collection protocols

Swift 가 제공하는 여러 프로토콜들은 그 역할을 명확히 정의하기 때문에 아주 유용하다.

주요 프로토콜은 아래와 같다.

```
1. Sequence = 순차적 접근에 대한 기능을 제공한다. 한번 접근한 요소에는 또 접근할 수 없다.
2. Collection = Sequence 를 확장하였다. 한번 접근한 요소도 다시 접근할 수 있게 하였다.
3. BidirectionalCollection = Collection 을 양방향으로 확장하였다. 순차 접근의 방향을 양방향으로 할 수 있다. LinkedList에는 해당되지 않는 얘기다.
4. RandomAccessCollection = BidirectionalCollection 을 확장하여 무작위 요소에 접근하는 것을 보장한다.
```

LinkedList 는 Sequence(node를 chaining 하기 때문), Collection(chaining이 한정적이므로)을 보장한다.

위의 두 프로토콜을 이용해 LinkedList는 Swift Collection이 될 수 있다.

## Becoming a Swift Collection

Collection 프로토콜을 자세히 들여다보자. 한정적인 Sequence 안에서는 무한정으로 요소에 접근할 수 있다. Swift Collection은 subscript 문법을 이용해 이를 구현할 수 있다.
