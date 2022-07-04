# Time Complexity

  적은 양의 데이터로는 티가 나지 않지만, 큰 데이터를 다루면 티가 나게 되어 있다.
  시간 복잡도는 입력 크기와 비례해 알고리즘을 실행할 때 필요한 시간을 나타낸다.
  시간 복잡도는 Big-O-notation 으로 나타내는데, O(1)/O(n)/O(n2) 등으로 나타낸다.
  시간 복잡도는 정해진 횟수만큼 발생하는 루프를 계산하지는 않는다.
  예를 들어 특정 배열에 대한 두번의 루프+6번의 O(1) 실행은 O(2n+6) 이 아니라 O(n) 이다.

## Constant time

     입력 크기에 관계없이 똑같은 실행 시간을 갖는 복잡도를 말한다.
     
     [Big-O-notation] O(1)

     ```swift
     func checkFirst(names: [String]) {
        if let first = names.first {
           print(first)
        } else {
           print("no names")
        }
     }
     ```

     time
     ^
     |
     |
     |
     |----------------------------
     |
     |ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ> data

## Linear time

     입력 크기에 따라 실행 시간이 정비례하게 늘어나는 복잡도를 말한다.
     
     [Big-O-notation] O(n)
     
     ```swift
     func printNames(names: [String]) {
        for name in names {
           print(name)
        }
     }
     ```

     time
     ^                  _/
     |                _/
     |             _/
     |          _/
     |       _/
     |   _/
     |ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ> data
     
## Quadratic time

     n squared 라고도 불린다. 입력에 대해 점차적으로 실행시간이 늘어나는 복잡도를 말한다.
     
     [Big-O-notation] O(n2)
     
     ```swift
     func printNames(names: [String]) {
        for _ in names {
           for name in names {
              print(name)
           }
        }
     }
     ```

     time
     ^      /
     |     /
     |    /
     |   /
     |  /
     | /
     |ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ> data

## Logarithmic time

     지금까지는 linear, quadratic 복잡도를 통해 입력으로 실행 시간을 알 수 있었지만,
     모든 입력이 아닌 일부 입력만 사용하고 싶은 경우가 있을 수 있다. 예를 들어 정렬된 배열에서 일부만 가져오고 싶은 경우 말이다.
     
     [Big-O-notation] O(log n)
     
     ```swift
     let numbers = [1, 3, 56, 66, 68, 80, 99, 105, 450]

     // Not Sorted
     func naiveContains(_ value: Int, in array: [Int]) -> Bool {
        for element in array {
           if element == value {
              return true
           }
        }

        return false
     }

     // Sorted
     func naiveContains(_ value: Int, in array: [Int]) -> Bool {
        guard !array.isEmpty else { return false }
        let middleIndex = array.count / 2

        if value <= array[middleIndex] {
           for index in 0...middleIndex {
              if array[index] == value {
                 return true
              }
           }
        } else {
           for index in middleIndex..<array.count {
              if array[index] == value {
                 return true
              }
           }
        }

        return false
     }
     ```
     
     Not Sorted 배열은 모든 elements를 검증하지만, Sorted 배열은 반만 검증하면 된다.
     Binary Search 를 통해 이러한 차이점을 알아보았다.

     time
     ^
     |
     |                ____----------------
     |           ___--
     |      __---
     | __---
     |ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ> data

## Quasilinear time

     Linear 보다는 굉장히 안 좋지만, Quadratic 보다는 월등히 좋다.
     생각보다 많이 접할 수 있는데, Swift 의 sort 메소드 같은 것이 있다.
     
     [Big-O-notation] O(n log n) -> (Linear * Logarithmic)

     time
     ^
     |       |
     |      /
     |     -
     |    -
     | ㅡ-
     |ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ> data
