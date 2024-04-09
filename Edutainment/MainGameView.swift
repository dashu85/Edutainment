//
//  MainGameView.swift
//  Edutainment
//
//  Created by Fauzan Dwi Prasetyo on 07/06/23.
//

import SwiftUI

struct MainGameView: View {
    var fromNumber: Int
    var toNumber: Int
    @State private var numberOfQuestion: Int
    
    @State private var firstNumbers: [Int]
    @State private var secondNumbers: [Int]
    
    @State private var inputValue = ""
    @State private var currentQuestion = 0
    @State private var isCorrect = false
    @State private var isFinish = false
    @State private var animateWrong = false
    @State private var animateCorrect = false
    
    @State private var score = 0
    
    @FocusState private var isFocused
    
    init(fromNumber: Int, toNumber: Int, numberOfQuestion: Int) {
        self.fromNumber = fromNumber
        self.toNumber = toNumber
        self.numberOfQuestion = numberOfQuestion
        
        var arrayOfNumber = [Int]()
        
        for _ in 0..<numberOfQuestion {
            let number = Int.random(in: fromNumber...toNumber)
            arrayOfNumber.append(number)
        }
        
        self.firstNumbers = arrayOfNumber
        self.secondNumbers = arrayOfNumber.shuffled()
        
        print(self.firstNumbers)
        print(self.secondNumbers)
        print(numberOfQuestion)
    }
    
    
    
    var body: some View {
        ZStack {
            Color.mint
            
            VStack {
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title)
                    .foregroundColor(.mint)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                
                ZStack {
                    if animateWrong {
                        Color.red
                            .frame(width: 200, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else if animateCorrect {
                        Color.green
                            .frame(width: 200, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {
                        Color.yellow
                            .frame(width: 200, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Text("\(firstNumbers[currentQuestion]) x \(secondNumbers[currentQuestion])")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                if isFinish {
                    Button {
                        restart()
                    } label: {
                        Text("Restart")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 200)
                            .padding(15)
                            .background(.yellow)
                            .clipShape(Capsule())
                    }
                } else {
                    TextField("Input Answer", text: $inputValue)
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(width: 200)
                        .padding(15)
                        .background(.yellow)
                        .clipShape(Capsule())
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                }
                
                Spacer()
                Spacer()
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("SUBMIT") {
                        isFocused = false
                        checkAnswer()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation {
                                animateWrong = false
                                animateCorrect = false
                            }
                        }
                    }
                    .padding(5)
                    .foregroundColor(.white)
                    .background(.mint)
                    .clipShape(Capsule())
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func generateNumbers(fromNumber: Int, toNumber: Int) {
        var arrayOfNumber = [Int]()

        for _ in 0..<numberOfQuestion {
            let number = Int.random(in: fromNumber...toNumber)
            arrayOfNumber.append(number)
        }
        
        firstNumbers = arrayOfNumber
        secondNumbers = arrayOfNumber.shuffled()
    }
    
    func checkAnswer() {
        let correctAnswer = firstNumbers[currentQuestion] * secondNumbers[currentQuestion]
        
        if Int(inputValue) == correctAnswer {
            isCorrect = true
            score += 1
            
            withAnimation {
                animateCorrect = true
            }
        } else {
            isCorrect = false
            score -= 1
            
            withAnimation {
                animateWrong = true
            }
        }
        
        inputValue = ""
        
        if currentQuestion != numberOfQuestion - 1 {
            currentQuestion += 1
        } else {
            isFinish = true
        }
    }
    
    func restart() {
        score = 0
        currentQuestion = 0
        generateNumbers(fromNumber: fromNumber, toNumber: toNumber)
        isFinish = false
    }
}

struct MainGameView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView(fromNumber: 5, toNumber: 8, numberOfQuestion: 5)
    }
}
