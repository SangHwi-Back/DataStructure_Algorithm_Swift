# Space Complexity

Time Complexity 이외에도 확장성을 고려할 수 있는 요소가 있다. 공간 복잡도는 알고리즘이 동작하기 위해 필요한 자원의 양을 뜻한다. 여기서 말하는 자료는 메모리이다.

```swift
func printSorted(_ array: [Int]) {
  let sorted = array.sorted()
  for element in sorted {
    print(element)
  }
}
```

array.sorted() 는 array 와 같은 배열을 생상할 것이기 떄문에 `printSorted` 의 시간 복잡도는 O(n)이다. 메모리 측면에서 유리하게 함수를 바꿔보자.

```swift
func printSorted(_ array: [Int]) {
  guard !array.isEmpty else { return }
  
  var currentCount = 0
  var minValue = Int.min
  
  for value in array {
    if value == minValue {
      print(value)
      currentCount += 1
    }
  }
  //6
  while currentCount < array.count {
    
    var currentValue = array.max()!
    // 4
    for value in array {
      if value < currentValue && value > minValue {
        currentValue = value
      }
    }
    // 5
    for value in array {
      if value == currentValue {
        print(value)
        currentCount += 1
      }
    }
    minValue = currentValue
  }
}
```

이 코드의 목적은 여러번 반복문을 실행함과 동시에 가장 작은 값을 출력하는 것이다.

while 문의 목적은 minValue 보다 큰 값을 찾기 위한 것이다. 
4번에서는 최대값을 저장해놓고 최소값과 가장 가까운 값을 찾아내는 것이고,
5번에서는 가장 가까운 값을 출력한 뒤, 최소값으로 임명한다. 최소값들은 이미 위에서 출력했으므로, 최소값 다음 값을 출력한 것이다. 중복되는 최소값 다음 값이 있을 경우를 대비해 for 문으로 실행한다.
6번에서는 출력할 때마다 +1 되는 `currentCount`가 배열의 길이보다 작을 때만 반복적으로 실행하게 한다.

위의 함수는 최소한의 변수만을 사용하고 있다. 공간 복잡도는 O(1)이다. 이전의 함수와 비교하면, 모든 함수를 메모리에 다시 할당한 것에 비해 메모리 공간을 아꼈다.

---

Big-O-notation 말고도, Big-Omega-notation 은 최적의 실행시간을 표현하고, Big-Theta-notation 은 최적/최악의 실행 유형을 표현한다.

---

## Key points
- 시간 복잡도는 알고리즘 입력에 따라 증가하는 시간을 나타내는 것이다.
- Constant/Logarithmic/Linear/Quasilinear/Quadratic 시간 복잡도에 대해 이해하고 이를 정렬할 수 있어야 한다.
- 공간 복잡도는 알고리즘 실행을 위해 필요한 자원을 뜻한다.
- Big-O-notation 은 일반적으로 시간, 공간 복잡도를 나타내는 기준이다.
- 시간, 공간 복잡도는 확장성을 표현하는 기준이 된다. 반면에 실제 알고리즘의 속도를 나타내지는 않는다.
- 적은 데이터만 존재할 경우 시간 복잡도 측정은 적당하지 않을 수 있다. 예를 들어 Quasilinear 는 Quadratic 알고리즘보다 O(n)일 경우 느릴 수 있다.