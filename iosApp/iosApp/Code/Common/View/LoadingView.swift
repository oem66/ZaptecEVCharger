//
//  LoadingView.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                ForEach(0..<3) { index in
                    Circle()
                        .stroke(Color.evcGreen.opacity(0.3), lineWidth: 3)
                        .frame(width: 60 + (CGFloat(index) * 20), height: 60 + (CGFloat(index) * 20))
                        .scaleEffect(isAnimating ? 1.2 : 0.8)
                        .opacity(isAnimating ? 0 : 1)
                        .animation(
                            .easeInOut(duration: 1.5)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                            value: isAnimating
                        )
                }
                
                Image(systemName: "bolt.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.evcGreen)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    .animation(
                        .linear(duration: 2)
                        .repeatForever(autoreverses: false),
                        value: isAnimating
                    )
            }
            
            Text("Finding chargers...")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            isAnimating = true
        }
    }
}
