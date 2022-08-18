import Foundation

let array = [1,16,15,17,19,22,24,31,105,150]

let search31 = array.firstIndex(of: 31)
let binarySearch31 = array.binarySearch(for: 31)

print("firstIndex(of:): \(String(describing: search31))")
print("binarySearch(for:): \(String(describing: binarySearch31))")

let array2 = [1,2,3,3,3,4,5,5]
if let indices = findIndices(of: 3, in: array2) {
    print(indices)
}
