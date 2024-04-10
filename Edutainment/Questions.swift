//
//  Questions.swift
//  Edutainment
//
//  Created by Marcus Benoit on 08.04.24.
//

import Foundation
import SwiftUI

struct Question {
    var multiplicator: Int
    var multiplyBy: Int
    
    var text: String {
        get {
            return "What is \(multiplicator) times \(multiplyBy)?"
        }
    }
    
    var answer: Int {
        multiplicator * multiplyBy
    }
    
    init(multiplicator: Int, multiplyBy: Int) {
        self.multiplicator = multiplicator
        self.multiplyBy = multiplyBy
    }
}

