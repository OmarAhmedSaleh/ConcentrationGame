

import Foundation

struct Concentration{
    private(set) var cards = [Card]()
    private(set) var score = 0
    private(set) var flipCount = 0
    private var theme: Int = 0
    private var themes = [
        "😀🥶🥰😇🤯😛","🥎🎱⚽️🏀🏈⚾","🐶🐙🐸🐼🐔🦄","🥕🍔🍏🥥🍉🍤","🚗✈️🛶🚀⚓️🚖","🇦🇷🇧🇪🇪🇬🇧🇭🇨🇴🇴🇲"
    ]
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            let faceUpCardIndices = cards.indices.filter{ cards[$0].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func getEmoji(at index: Int) -> String{
        let idx = themes[theme].index(themes[theme].startIndex, offsetBy: index)

        return String(themes[theme][idx])
    }
    mutating func chooseCard(at index: Int){
        if cards[index].isMatched{
            return
        }
        flipCount += 1
        if !cards[index].isFaceUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else{
                    if cards[index].seen{
                        score -= 1
                    }
                    cards[index].seen = true
                    if cards[matchIndex].seen{
                        score -= 1
                    }
                    cards[matchIndex].seen = true
                }
                indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isFaceUp = true
                cards[matchIndex].isFaceUp = true
            }else{
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].isFaceUp = true
            }
        }
    }
    private mutating func shuffleCards(){
        var sh_Cards = [Card]()
        for _ in 0..<cards.count{
            let idx = Int(arc4random_uniform(UInt32(cards.count)))
            sh_Cards.append(cards[idx])
            cards.remove(at: idx)
        }
        cards = sh_Cards
    }
    private mutating func randomTheme(){
        theme = Int(arc4random_uniform(UInt32(themes.count)))
    }
    private mutating func createNewCards(_ numberOfPairsOfCards: Int){
        cards.removeAll()
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card , card]
        }
    }
    mutating func newGame(_ numberOfPairsOfCards: Int){
        Card.resetIdentifier()
        flipCount = 0
        score = 0
        randomTheme()
        createNewCards(numberOfPairsOfCards)
        shuffleCards()
    }
    init(numberOfPairsOfCards: Int){
        newGame(numberOfPairsOfCards)
    }
}
