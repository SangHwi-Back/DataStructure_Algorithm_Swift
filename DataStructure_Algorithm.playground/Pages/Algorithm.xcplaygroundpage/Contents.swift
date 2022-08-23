import Foundation





let letters = ["a", "b", "c", "d", "e"]
print("Permutations of \(letters):")
//permuteWirth(letters, letters.count - 1)
//var result = [[String]]()
let result = permuteWirth2(letters, letters.count - 1)
print(result)

//let numbers = [1,2,3,4]
//print(combination(numbers, 2))
//print(combinationCycle(numbers, 2))
