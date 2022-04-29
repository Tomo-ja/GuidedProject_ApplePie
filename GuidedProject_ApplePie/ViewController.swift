//
//  ViewController.swift
//  GuidedProject_ApplePie
//
//  Created by Tomonao Hashiguchi on 2022-04-28.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["sushi", "pizza", "hamburger", "pasta"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    var currentGame: Game!

    @IBOutlet var treeImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGussed(letter: letter)
        updateGameState()
    }
    

    
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMoveRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUi()
        }else{
            enableLetterButtons(false)
        }
        
    }
    
    func updateUi(){
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpaing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpaing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMoveRemaining)")
    }
    func updateGameState(){
        if currentGame.incorrectMoveRemaining == 0 {
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }else{
            updateUi()
        }
    }
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
}

