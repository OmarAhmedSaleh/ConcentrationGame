

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards:Int {
        return cardButtons.count / 2
    }
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    @IBOutlet private weak var scoreLabel: UILabel!
    private func updateViewFromModel(){
        scoreLabel.text = "Score: \(game.score)"
        flipCountLabel.text = "Flips: \(game.flipCount)"
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(game.getEmoji(at: card.getIdentifier()), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: .normal)
                if card.isMatched{
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                }else{
                    button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) 
                }
            }
            
        }
    }
    @IBAction private func newGame(_ sender: Any) {
        game.newGame(cardButtons.count / 2)
        updateViewFromModel()
    }
    
}

