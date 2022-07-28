import Foundation

/**
 Case Study #1 : array vs BST
 
 (Lookup)
 array의 contains(_:) 메소드는 O(n) 시간 복잡도를 갖는다. 목표한 요소를 찾기 전까지는 모든 요소를 거쳐야 하기 때문이다.
 BST는 Root 노드부터 비교해볼 때 목표한 요소보다 적다면 왼쪽 노드, 크다면 오른쪽 노드로 가면서 탐색하면 되기 때문에 O(log n) 시간 복잡도를 갖는다.
 
 (Insertion)
 array의 경우 위와 같다. 특정 위치에 요소를 삽입하면 그 뒤의 요소는 모두 shift가 일어난다.
 BST는 위의 탐색을 거치면서 적당한 위치에 추가해주기만 하면 된다. (작다면 왼쪽 하위노드, 크거나 같다면 오른쪽 하위노드)
 
 (Removal)
 array, BST 모두 위와 같다.
 */
