//
//  ContentView.swift
//  Edutainment
//
//  Created by Marcus Benoit on 05.04.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var chosenMultiplicator = 2
    @State private var chosenNumberOfQuestions = 5
    @State private var questions = [String]()
    @State private var answers = [Int]()
    var work = true
    
    @State private var numberOptions = [5, 10, 15, 20]
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.992, green: 0.882, blue: 0), location: 0.3),
                    .init(color: Color(red: 0, green: 0, blue: 0), location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 1100)
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Section {
                        Stepper("Let's play number   **\(chosenMultiplicator)**", value: $chosenMultiplicator, in: 1...12)
                            .padding()
                    } header: {
                        Text("Which number do you want to play?")
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Section {
                        Picker("Test", selection: $chosenNumberOfQuestions) {
                            ForEach(numberOptions, id: \.self) { option in
                                Text("\(option)")
                            }
                        }
                    }header: {
                            Text("How many questions?")
                            .padding()
                            .foregroundStyle(.black)
                        }
                        .pickerStyle(.segmented)
                        .background(Color(red: 0.992, green: 0.882, blue: 0))
                        .foregroundColor(.white)
                        
                        Spacer()
                        
                        NavigationLink {
                            // main game
                            GameScreen(multiplicator: chosenMultiplicator, numberOfQuestions: chosenNumberOfQuestions)
                        } label: {
                            Text("START")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(20)
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .navigationTitle("Edutainment")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
