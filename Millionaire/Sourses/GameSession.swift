//
//  GameSession.swift
//  Millionaire
//
//  Created by Anton Hodyna on 22/03/2022.
//

import Foundation

class GameSession {
    var score: Int = 0
    var name: String = ""
    var question: Question?
    var helpsCount = 3
    var isFiftyFifty = true
    var isHallHelp = true
    var isFriendCall = true
}
