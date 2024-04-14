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
                        Stepper("Let's play number", value: $chosenMultiplicator, in: 2...12)
                            .padding()
                    } header: {
                        Text("Which number do you want to play?")
                    }
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    Text("\(chosenMultiplicator)")
                        .padding()
                        .foregroundColor(.black)
                        .bold()
                        .font(.system(size: CGFloat(10 * chosenMultiplicator)))
                    
                    Spacer()
                    
                    Section {
                        Picker("Test", selection: $chosenNumberOfQuestions) {
                            ForEach(numberOptions, id: \.self) { option in
                                Text("\(option)")
                            }
                        }
                        .padding()
                        .pickerStyle(.segmented)
                        .background(Color(red: 0.992, green: 0.882, blue: 0))
                        .cornerRadius(8)
                    }header: {
                            Text("How many questions do you want to play?")
                            .foregroundStyle(.white)
                        }
                       
                        
                        Spacer()
                        
                        NavigationLink {
                            // main game
                            GameScreen(multiplicator: chosenMultiplicator, numberOfQuestions: chosenNumberOfQuestions)
                        } label: {
                            Text("START")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding(20)
                                .background(Color(red: 0.992, green: 0.882, blue: 0))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .navigationTitle("Edutainment")
                    .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
