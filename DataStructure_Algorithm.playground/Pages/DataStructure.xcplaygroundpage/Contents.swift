import Foundation

//let graph = AdjacencyMatrix<String>()
//
//let singapore = graph.createVertex(data: "Singapore")
//let tokyo = graph.createVertex(data: "Tokyo")
//let hongKong = graph.createVertex(data: "Hong Kong")
//let detroit = graph.createVertex(data: "Detroit")
//let sanFrancisco = graph.createVertex(data: "San Francisco")
//let washingtonDC = graph.createVertex(data: "Washington DC")
//let austinTexas = graph.createVertex(data: "Austin Texas")
//let seattle = graph.createVertex(data: "Seattle")
//
//graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
//graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
//graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
//graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
//graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
//graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
//graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
//graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
//graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
//graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
//graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
//graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
//
//print(graph)
//
//print("San Francisco Outgoing Flights:")
//print("--------------------------------")
//for edge in graph.edges(from: sanFrancisco) {
//  print("from: \(edge.source) to: \(edge.destination)")
//}
//
//print(graph.numberOfPaths(from: sanFrancisco, to: seattle))

let friendsGraph = AdjacencyList<String>()

let vincent = friendsGraph.createVertex(data: "Vincent")
let chesley = friendsGraph.createVertex(data: "Chesley")
let ruiz = friendsGraph.createVertex(data: "Ruiz")
let patrick = friendsGraph.createVertex(data: "Patrick")
let ray = friendsGraph.createVertex(data: "Ray")
let sun = friendsGraph.createVertex(data: "Sun")
let cole = friendsGraph.createVertex(data: "Cole")
let kerry = friendsGraph.createVertex(data: "Kerry")

friendsGraph.add(.undirected, from: vincent, to: chesley, weight: 1)
friendsGraph.add(.undirected, from: vincent, to: ruiz, weight: 1)
friendsGraph.add(.undirected, from: vincent, to: patrick, weight: 1)
friendsGraph.add(.undirected, from: ruiz, to: sun, weight: 1)
friendsGraph.add(.undirected, from: ruiz, to: ray, weight: 1)
friendsGraph.add(.undirected, from: patrick, to: cole, weight: 1)
friendsGraph.add(.undirected, from: patrick, to: kerry, weight: 1)
friendsGraph.add(.undirected, from: cole, to: ruiz, weight: 1)

print(friendsGraph)
