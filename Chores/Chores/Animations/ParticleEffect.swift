//
//  PaticleAnnimation.swift
//  Chores
//
//  Created by Joao Lucas Camilo on 05/09/23.
//

import Foundation

import SwiftUI

extension View {
    @ViewBuilder
    func particleEffect(image: String, status: Bool, activeTint: Color, inactiveTint: Color) -> some View {
        self
            .modifier(ParticleModifier(image: image, status: status, activeTint: activeTint, inactiveTint: inactiveTint))
    }
}

private struct ParticleModifier: ViewModifier {
    var image: String
    var status: Bool
    var activeTint: Color
    var inactiveTint: Color
    
    @State private var particles: [Particle] = []
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                ZStack {
                    ForEach(particles) { particle in
                        Image(image)
                            .renderingMode(.template)
                            .foregroundColor(status ? activeTint:inactiveTint)
                            .scaleEffect(particle.scale)
                            .offset(x: particle.randomX, y: particle.randomY)
                            .opacity(particle.opacity)
                            .opacity(status ? 1 : 0)
                            .animation(.none, value: status)
//                            .padding(.bottom, 100)
                    }
                }
                .onAppear {
                    if particles.isEmpty {
                        for _ in 0...40 {
                            let particle = Particle()
                            particles.append(particle)
                        }
                    }
                }
                .onChange(of: status) { newValue in
                    print(status)
                    if !newValue {
                        for index in particles.indices {
                            particles[index].reset()
                        }
                    } else {
                        for index in particles.indices {
                            let total = CGFloat(particles.count)
                            let progress = CGFloat(index) / total
                            
                            let maxX: CGFloat = (progress > 0.5) ? 300 : -300
                            let maxY: CGFloat = 100
                            
                            let randomX: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress) * maxX)
                            let randomY: CGFloat = ((progress > 0.5 ? progress - 0.5 : progress) * maxY)
                            
//                            print([randomX, randomY])
                            
                            let extraRandomX: CGFloat = (progress < 0.5 ? .random(in: 0...10) : .random(in: -10...0) )
                            let extraRandomY: CGFloat = .random(in: 0...100)
                            let randomScale: CGFloat = .random(in: 0.35...1)
                            
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                particles[index].randomX = randomX + extraRandomX
                                particles[index].randomY = -randomY - extraRandomY
                                particles[index].scale = randomScale
                            }
                            
                            withAnimation(.easeInOut(duration: 0.3)){
                                particles[index].scale = randomScale
                            }
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)
                                .delay(0.15 + (Double(index) * 0.005))) {

                                particles[index].scale = 0.001
                            }
                        }
                    }
                }
            }
    }
}

struct Particle: Identifiable {
    var id: UUID = .init()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1
    var opacity: CGFloat = 1
    
    mutating func reset() {
        randomX = 0
        randomY = 0
        scale = 1
        opacity = 1
    }
}

//struct TaskDetailsView_Previews: PreviewProvider {
//    
//    static let mockedTask = Task(value: ["title": "Take ou the trash",
//                                         "desc": "Empty all trash cans and take it out before 14h. Don't forget that box for recycling.",
//                                         "isImportant": true,
//                                         "category": TaskCategory.ligthCleaning,
//                                         "startDate": Date.now,
//                                         "endRepeatDate": Date.now] as [String : Any])
//    
//    static var previews: some View {
//        NavigationStack {
//            TaskDetailsView(task: TaskDetailsView_Previews.mockedTask)
//        }
//    }
//    
//}
