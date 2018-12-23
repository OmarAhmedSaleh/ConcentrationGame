
import Foundation

struct Card: Hashable{
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int = 0
    
    var seen = false
    static func ==(lhs: Card ,rhs: Card) -> Bool{
        return lhs.identifier == rhs.identifier
    }
    static var identifierFactory = -1
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    static func resetIdentifier(){
        identifierFactory = -1
    }
    func getIdentifier() -> Int{
        return identifier
    }
    init(){
        identifier = Card.getUniqueIdentifier()
    }
    
}
