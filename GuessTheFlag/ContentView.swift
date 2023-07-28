//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sujan Kumar on 26/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
                                    "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctFlag = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    var body: some View {
        NavigationView {
            ZStack {
                RadialGradient(
                    colors: [.yellow, .red],
                    center: .top,
                    startRadius: 100,
                    endRadius: 1000
                )
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Text("GTF")
                        .font(.largeTitle)

                    VStack(spacing: 15) {
                        VStack {
                            Text("Guess the flag of")
                                .font(.subheadline.weight(.heavy))
                                .foregroundStyle(.secondary)
                            Text(countries[correctFlag])
                                .font(.largeTitle.weight(.semibold))
                        }
                        
                        ForEach(0..<3) { number in
                            Button {
                                print("Flag of \(countries[number]) was tapped!")
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .shadow(radius: 5)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Text("Your score: \(currentScore)")
                        .font(.body.bold())
                }
                .padding()
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: nextQuestion)
            } message: {
                Text("Your score is \(currentScore)")
            }
        }
    }
    
    private func flagTapped(_ flagNumber: Int) {
        if flagNumber == correctFlag {
            scoreTitle = "Correct"
            currentScore += 1
        } else {
            scoreTitle = "Wrong! Previous score: \(currentScore)"
            currentScore = 0
        }
        showingScore = true
    }
    
    private func nextQuestion() {
        countries.shuffle()
        correctFlag = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
