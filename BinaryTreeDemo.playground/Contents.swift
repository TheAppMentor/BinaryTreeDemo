//: Demo : Implementing a Binary Search Tree

// ========================= BTNode ========================= //

class BTNode:CustomStringConvertible {
    
    var key : Int = -1                // Player Jersery #
    var value : String = ""           // Player Name
    
    var leftChildNode : BTNode? = nil
    var rightChildNode : BTNode? = nil
    var parentNode : BTNode? = nil
    
    // Set the 'init' method as private. Prevents users from creating a node with default values.
    private init() {}
    
    convenience init(key: Int, value : String) {
        self.init()
        self.key = key
        self.value = value
    }
    
    // Helper Method
    var hasLeftNode : Bool{
        return leftChildNode != nil
    }
    
    var hasRightNode : Bool{
        return rightChildNode != nil
    }
    
    var description: String {
        return "\n===========================\n\t\t\(self.key) \n\t ⋰  ⋱  \n   \(leftChildNode?.key ?? -1) \t  \(rightChildNode?.key ?? -1)   \n\n \n\t\t\(self.value) \n\t  \n   \(leftChildNode?.value ?? "nil") \t  \(rightChildNode?.value ?? "nil") \n==========================="
    }
}


// ========================================================== //
//: Create instances of BTNode

let playerNode1 = BTNode(key : 44, value : "Asiata, Matt")

print(playerNode1.key)         // Output : 44
print(playerNode1.value)       // Output : "Asiata, Matt"


class BTree{
    var rootNode : BTNode?
    
    func insertNode(inputNode : BTNode, currentWorkNode : BTNode? = nil) {
        
        // Empty Tree -> Insert as Root.
        if rootNode == nil {
            setRootNode(inputNode)
            return
        }
        
        let tempWorkNode = currentWorkNode ?? rootNode!
        
        // If inputNode < CWC.key Shift Left
        if inputNode.key < tempWorkNode.key {
            if tempWorkNode.hasLeftNode {
                //Keep looking further to the left of current node.
                return insertNode(inputNode: inputNode, currentWorkNode: tempWorkNode.leftChildNode!)
            }
            
            // If we have a node with no left leaf. Insert here.
            setLeftNode(inputNode, parentNode: tempWorkNode)
            return
        }
        
        // If inputNode > CWC.key Shift Right
        if inputNode.key > tempWorkNode.key {
            if tempWorkNode.hasRightNode {
                // Keep looking further to the right of current node.
                return insertNode(inputNode: inputNode, currentWorkNode: tempWorkNode.rightChildNode!)
            }
            
            // If we have a node with no right leaf. Insert here.
            setRightNode(inputNode, parentNode: tempWorkNode)
            return
        }
        
        return
    }
    
    
    func setLeftNode(_ leftNode : BTNode, parentNode : BTNode) {
        parentNode.leftChildNode = leftNode
        leftNode.parentNode = parentNode
    }
    
    func setRightNode(_ rightNode : BTNode, parentNode : BTNode) {
        parentNode.rightChildNode = rightNode
        rightNode.parentNode = parentNode
    }
    
    func setRootNode(_ node : BTNode){
        rootNode = node
        rootNode?.parentNode = nil
        rootNode?.leftChildNode = nil
        rootNode?.rightChildNode = nil
        
    }
    
    //MARK: Searching
    func find(_ key : Int) -> BTNode? {
        if rootNode == nil {return nil}
        return lookUp(key)
    }
    
    
    private func lookUp(_ key : Int, startingNode : BTNode? = nil) -> BTNode? {
        
        let tempWorkNode = startingNode ?? rootNode!
        
        if tempWorkNode.key == key{return tempWorkNode}
        
        if tempWorkNode.key < key {
            if tempWorkNode.hasRightNode{
                return lookUp(key, startingNode: tempWorkNode.rightChildNode)
            }
            return nil
        }
        
        if tempWorkNode.key > key {
            if tempWorkNode.hasLeftNode{
                return lookUp(key, startingNode: tempWorkNode.leftChildNode)
            }
            return nil
        }
        
        return nil
    }


}


//: Build the tree.
let playerBTree = BTree()

//  44	Asiata, Matt
//  55	Barr, Anthony
//  64	Beavers, Willie
//  61	Berger, Joe
//  76	Boone, Alex
//  8   Bradford, Sam
//  40	Brothers, Kentrell
//  68	Clemmings, T.J.
//  57	Cole, Audie
//  14	Diggs, Stefon
//  2   Forbath, Kai
//  6   Heinicke, Taylor
//  69	Hill, Rashod

playerBTree.insertNode(inputNode: BTNode(key: 44, value: "Asiata, Matt"))
playerBTree.insertNode(inputNode: BTNode(key: 55, value: "Barr, Anthony"))
playerBTree.insertNode(inputNode: BTNode(key: 64, value: "Beavers, Willie"))
playerBTree.insertNode(inputNode: BTNode(key: 61, value: "Berger, Joe"))
playerBTree.insertNode(inputNode: BTNode(key: 8, value: "Bradford, Sam"))
playerBTree.insertNode(inputNode: BTNode(key: 40, value: "Brothers, Kentrell"))
playerBTree.insertNode(inputNode: BTNode(key: 68, value: "Clemmings, T.J."))
playerBTree.insertNode(inputNode: BTNode(key: 57, value: "Cole, Audie"))
playerBTree.insertNode(inputNode: BTNode(key: 14, value: "Diggs, Stefon"))
playerBTree.insertNode(inputNode: BTNode(key: 2, value: "Forbath, Kai"))
playerBTree.insertNode(inputNode: BTNode(key: 6, value: "Heinicke, Taylor"))
playerBTree.insertNode(inputNode: BTNode(key: 69, value: "Hill, Rashod"))

// Search for a key present in the tree.

let resultNode = playerBTree.find(14)
print(resultNode ?? "Node Not found")


let badNode = playerBTree.find(99)
print(badNode ?? "Node Not found")