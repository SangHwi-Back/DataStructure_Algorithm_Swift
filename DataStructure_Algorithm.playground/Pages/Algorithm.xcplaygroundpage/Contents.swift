import Foundation





let letters = ["a", "b", "c", "d", "e"]
print("Permutations of \(letters):")
//permuteWirth(letters, letters.count - 1)
var result = [[String]]()
permuteWirth(letters, letters.count - 1, result: &result)
print(result.count)

let numbers = [1,2,3,4]
print(combination(numbers, 2))
print(combinationCycle(numbers, 2))
