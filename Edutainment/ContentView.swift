//
//  ContentView.swift
//  Edutainment
//
//  Created by Marcus Benoit on 05.04.24.
//

import SwiftUI

struct StartScreen: View {
    
    @State private var multiplicator: Int
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.992, green: 0.882, blue: 0), location: 0.3),
                    .init(color: Color(red: 0, green: 0, blue: 0), location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 1100)
                .ignoresSafeArea()
                
                VStack {
                    Form {
                        Section {
                            Stepper("Let's play \(multiplicator)", value: $multiplicator, in: 1...12)
                        } header: {
                            Text("Which number do you want to play?")
                        }
                        
                        
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
