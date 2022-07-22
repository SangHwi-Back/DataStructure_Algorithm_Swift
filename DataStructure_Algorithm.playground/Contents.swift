import Foundation

let tree = TreeNode(value: "Beverages")

let hot = TreeNode(value: "hot")
let cold = TreeNode(value: "cold")

let tea = TreeNode(value: "tea")
let coffee = TreeNode(value: "coffee")
let chocolate = TreeNode(value: "cocoa")

let blackTea = TreeNode(value: "black")
let greenTea = TreeNode(value: "green")
let chaiTea = TreeNode(value: "chai")

let soda = TreeNode(value: "soda")
let milk = TreeNode(value: "milk")

let gingerAle = TreeNode(value: "ginger ale")
let bitterLemon = TreeNode(value: "bitter lemon")

tree.add(hot)
tree.add(cold)

hot.add(tea)
hot.add(coffee)
hot.add(chocolate)

cold.add(soda)
cold.add(milk)

tea.add(blackTea)
tea.add(greenTea)
tea.add(chaiTea)

soda.add(gingerAle)
soda.add(bitterLemon)

if let searchResult = tree.search("ginger ale") {
    print("Found node: \(searchResult.value)")
}

if let searchResult2 = tree.search("WKD Blue") {
    print("Found node: \(searchResult2.value)")
} else {
    print("Couldn't find WKD Blue")
}

