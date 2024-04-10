//
//  GameScreen.swift
//  Edutainment
//
//  Created by Marcus Benoit on 09.04.24.
//

import SwiftUI

struct GameScreen: View {
    
    // for link to go back to ContentView
    @Environment(\.presentationMode) var presentationMode
    
    var multiplicator: Int
    var numberOfQuestions: Int
    
    @State private var questions: [String]
    @State private var answers: [Int]
    
    // initializing questions and answers arrays before rendering the view to start the game
    init(multiplicator: Int, numberOfQuestions: Int) {
        self.multiplicator = multiplicator
        self.numberOfQuestions = numberOfQuestions
            
        // Initialize questions array
        var initialQuestions = [String]()
        var initialAnswer = [Int]()
        
        for _ in 1...numberOfQuestions {
            let randomNumber = Int.random(in: 2...12)
            
            let newQuestion = "What is \(randomNumber) * \(multiplicator) ?"
            initialQuestions.append(newQuestion)
                
            let newAnswer = randomNumber * multiplicator
            initialAnswer.append(newAnswer)
        }
        
        self._questions = State(initialValue: initialQuestions)
        self._answers = State(initialValue: initialAnswer)
    }
    
    @State private var scoreCorrect = 0
    @State private var scoreFalse = 0
    @State private var currentQuestion = 0
    @State private var isGameOver = false
    @State private var showContentView = false
    
    @State private var answerGivenByUser: Int?
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                RadialGradient(stops: [
                    .init(color: Color(red: 0.992, green: 0.882, blue: 0), location: 0.3),
                    .init(color: Color(red: 0, green: 0, blue: 0), location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 1000)
                    .ignoresSafeArea()
                    .onAppear(perform: {
                        print()
                    })
                
                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            Text("Correct: \(scoreCorrect)")
                            Spacer()
                            Text("False: \(scoreFalse)")
                            Spacer()
                        }
                        .font(.title)
                        .foregroundStyle(.black)
                        
                        // checking that the currentQuestion doesn't get higher than the numberOfQuestions
                        if currentQuestion < numberOfQuestions {
                            Text("Question \(currentQuestion + 1) of \(numberOfQuestions)")
                        } else {
                            Text("Question \(currentQuestion) of \(numberOfQuestions)")
                        }
                        
                        Spacer()
                        
                        if currentQuestion < numberOfQuestions { // Check added to prevent accessing out-of-bounds index
                            Text("\(questions[currentQuestion])")
                                .padding()
                                .font(.largeTitle)
                            
                        } else {
                            Text("Game Over, Final score: \(scoreCorrect)") // Show a message when all questions are answered
                            Button("Play Again!") {
                                            // Dismiss DetailView and go back to ContentView
                                            presentationMode.wrappedValue.dismiss()
                                        }
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            TextField("Enter an integer", text: Binding<String>(
                                get: { self.answerGivenByUser.map { String($0) } ?? "" },
                                set: { self.answerGivenByUser = Int($0) }
                            ))
                            .padding()
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                            .keyboardType(.decimalPad)
                            .submitLabel(.done)
                            .onSubmit {
                                self.answerGivenByUser = nil
                            }
                            Button("Done") {
                                checkAnswer(answerGivenByUser ?? 0)
                                self.answerGivenByUser = nil
                            }
                            .padding()
                        }
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Let's play")
    }
    
    func printStatus() {
        print(questions)
        print(answers)
        print(currentQuestion)
    }
    
    func checkAnswer(_ answer: Int?) {
        guard let answerGivenByUser = answer else {
            // Handle the case where answerGivenByUser is nil (invalid input)
            print("Invalid input")
            return
        }
        
        if answerGivenByUser == answers[currentQuestion] {
            scoreCorrect += 1
        } else {
            scoreFalse += 1
        }
        print("answerGivenByUser: \(answerGivenByUser)")
        currentQuestion += 1
        
        if currentQuestion == numberOfQuestions {
            isGameOver = true
        }
    }
    
    func resetGame() {
        scoreFalse = 0
        scoreCorrect = 0
        currentQuestion = 0
    }
    
    func doSomething() {
        // do something
    }
    
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(multiplicator: 2, numberOfQuestions: 5)
    }
}
