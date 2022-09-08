# RadixSort

특이하게도 non-comparative 알고리즘이다. 여러 상황에 대한 수많은 구현방법이 존재한다.

우선, 10개의 정수들 중 LSD를 찾는 것부터 시작하자. 여기서 LSD 는 숫자 중 가장 오른쪽에 있는 수를 말한다. 예를 들어 base-10 2516 에서 첫번째 LSD 는 6이다.

LSD에는 Base 라는 숫자가 있는데 LSD의 자릿수를 판단하는 기준이다. 10이라면 1, 10, 100, 1000 자리의 숫자를 기준으로 LSD 를 판단하는 것이다.

이해와 구현이 약간 어렵지만 가장 빠른 정렬 알고리즘 중 하나다. 시간 복잡도는 O(k * n)이다. k는 가장 큰 자릿수를 가진 숫자의 자릿수, n은 배열의 크기이다.

### 예시

[88,410,1772,20]

해당 배열의 첫번째 LSD 만을 확인하여 Queue와 같은 구조에 높은 순서로 집어 넣는다. LSD base-10 이다.

> \| 0 | => [410,20]   
> \----   
> \| 2 | => [1772]   
> \----   
> \| 8 | => [88]

이 Queue 구조를 비우면 다음과 같이 배열이 바뀐다.

[410,20,1772,88]

이제는 두번째 LSD 만을 확인하여 Queue와 같은 구조에 높은 순서로 넣는다.

> \| 1 | => [410]   
> \----   
> \| 2 | => [20]   
> \----   
> \| 7 | => [1772]   
> \----   
> \| 8 | => [88]

[410,20,1772,88]

이번에는 아무런 변화가 없다. 이번에는 세번째 LSD를 확인해본다.

> \| 0 | => [20,88]   
> \----   
> \| 4 | => [410]   
> \----   
> \| 7 | => [1772]   

[20,88,410,1772]

세번째 이하의 수에는 세번째 LSD를 0으로 인식한다. 이젠 마지막으로 네번째 LSD 로 확인해본다.

> \| 0 | => [20,88,410]   
> \----   
> \| 1 | => [1772]   
> \----   

[20,88,410,1772]

여기서 각 Queue의 노드마다 할당된 배열의 요소 순서도 눈여겨 볼 포인트이다. 이것은 마치 정렬해서 넣은 것 처럼 보이기도 하지만, 이번 배열을 보면 이미 순서가 맞아들어 있다. 즉, LSD 를 판단하기 전 정렬해야 할 배열만 잘 참고하면 된다.
