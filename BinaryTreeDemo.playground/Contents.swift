//: Demo : Implementing a Binary Search Tree

// ========================= BTNode ========================= //

class BTNode {
    
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

}

