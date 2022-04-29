//
//  Game.swift
//  GuidedProject_ApplePie
//
//  Created by Tomonao Hashiguchi on 2022-04-28.
//

import Foundation

struct Game {
    var word: String
    var incorrectMoveRemaining: Int
    var guessedLetters: [Character]
    var formattedWord: String{
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGussed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMoveRemaining -= 1
        }
    }
}
