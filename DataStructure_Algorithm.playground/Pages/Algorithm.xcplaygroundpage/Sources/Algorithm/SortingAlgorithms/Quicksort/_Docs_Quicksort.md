# Quicksort

comparison-based 알고리즘의 하나다. MergeSort 처럼 분할정복 방식을 사용한다. Quicksort 의 가장 중요한 점은 pivot 을 정하는 것이다. pivot 은 배열을 세 개의 부분으로 나누게 된다.

[elements<pivot | pivot | pivo<elements] 

### 원리에 대한 시각적인 설명

1. 중간 인덱스 (([배열의 갯수] / 2), 짝수 개의 배열이라면 반올림한다) 의 값인 pivot 을 설정한다.

[12, 0, 3, 9, 2, 18, 8, 27, 1, 5, 8, -1, 21]
                     *

그리고 pivot 보다 작은 값을 뽑아내고, pivot 과 같은 값을 뽑아내고, pivot 보다 큰 값을 뽑아내어 3 부분으로 나눈다. 이를 partitioning 이라고 한다.
[0,3,2,1,5,-1] [8,8] [12,9,18,27,21]

2. 1의 과정을 반복해보자.

[0,-1] [1] [3,2,5] [8,8] [12,9] [18] [27,21]
[] [-1] [0] [1] [] [2] [3,5] [8,8] [9] [12] [18] [21] [27]
[] [-1] [0] [1] [] [2] [3] [5] [8,8] [9] [12] [18] [21] [27]

### partitioning 전략

파티셔닝 전략은 pivot 을 어디로 잡느냐에 따라 나뉜다. 파티셔닝 전략을 효율적으로 수행하면 sorting 이 더욱 수월하다.

1. Lomuto's partitioning
    마지막 요소를 pivot 으로 정하는 방법이다.
    기본 구현에서는 세 개의 배열을 만들어 냈지만, 이 방법은 더 효율적이다.

1. Hoare's partitioning
    첫번째 요소를 pivot 으로 정하는 방법이다.
    기본 구현에서는 세 개의 배열을 만들어 냈지만, 이 방법은 더 효율적이다.
    
### 비효율적인 partitioning 전략

적절한 partitioning 전략에 따라 quicksort 의 성능이 바뀐다.

1. 중간 요소를 pivot
2. Lomuto. 마지막 요소를 pivot
3. Hoare, 첫번째 요소를 pivot

다음 중 어떤 전략이 문제가 될까?

다음의 예시가 있다.

[8,7,6,5,4,3,2,1]

Lomuto 알고리즘을 쓴다면 equal 부분(pivot)은 [1], less 부분은 [], greater 부분은 [7,6,5,4,3,2] 이 된다.

가장 이상적인 pivoting 은 less, greater 가 같은 양으로 나뉘는 것이다. 이미 정렬된 배열의 처음/마지막 요소를 pivoting 하는 것은 최악의 성능이 나오게 된다( O(n2) ).

median of three pivoting 전략은 중간에서 첫번째, 중간에서 마지막 요소를 pivot 으로 사용하는 것이다. 첫번째, 중간, 마지막 요소를 sorting 하고 중간 인덱스를 반환한다. 이를 통해 Lomuto's 전략을 효율적으로 수행할 수 있다.

---

Lomuto's & Hoare's 알고리즘의 문제점은 중복되는 상황을 잘 처리하지 못한다는 것이다. Lomuto's 알고리즘은 less (pivot 보다 작은 요소들만 모인 왼쪽 배열) 이 중복 처리되고 합쳐지는 것도 되지 않는다. Hoare's 알고리즘은 모든 요소를 검사하기 때문에 상황이 더욱 심각하다.

수많은 중복 요소를 처리하는 데엔 Dutch national flag partitioning 이 효과적이다. 이름에서 볼 수 있다시피 세 개의 줄에 서로 다른 색(빨간색, 하얀색, 파란색) 처럼 서로 다른 세 개의 partition 갖는다.

Dutch national flag partitioning 은 Partitioning Strategy(Lomuto's, Hoare's) 에 대해 독립적으로 작동한다.

### 키 포인트

* naive partitioning 은 매 함수 실행마다 새로운 array 를 만든다. 비효율적인 면이 있다.
* Lomuto's partitioning 은 마지막 요소를 pivoting 한다.
* Hoare's partitioning 은 첫번째 요소를 pivoting 한다.
* 이상적인 pivoting 은 partitioning 을 고르게 하는 것이다.
* 잘못된 pivoting 은 높은 시간복잡도 (O(n2)) 를 야기한다.
* Median of three 는 pivot 을 중간에서 첫번째, 중간에서 마지막 요소로 잡는다.
* Dutch national flag partitioning 은 중복 요소를 효율적으로 정렬한다.
