//
//  OnboardingView.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct OnboardingView: View {
    @Binding var navigationPath: NavigationPath
    @Binding var showOnboarding: Bool
    @State private var currentPage = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: "0A0E27"),
                    Color(hex: "1A1F3A")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                TabView(selection: $currentPage) {
                    OnboardingPage1()
                        .tag(0)
                    OnboardingPage2()
                        .tag(1)
                    OnboardingPage3()
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(currentPage == index ? Color.evcGreen : Color.white.opacity(0.3))
                            .frame(width: 8, height: 8)
                            .scaleEffect(currentPage == index ? 1.2 : 1.0)
                            .animation(.spring(response: 0.3), value: currentPage)
                    }
                }
                .padding(.top, 20)
                
                Button {
                    log.info(">>> OnboardingView: \(currentPage)")
                    if currentPage < 2 {
                        withAnimation(.spring()) {
                            currentPage += 1
                        }
                    } else {
                        showOnboarding.toggle()
                    }
                } label: {
                    HStack {
                        Text(currentPage < 2 ? "Continue" : "Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.evcGreen)
                            .shadow(color: Color.evcGreen.opacity(0.5), radius: 20, x: 0, y: 10)
                    )
                }
                .padding(.horizontal, 30)
                .padding(.top, 30)
                .padding(.bottom, 50)
            }
        }
    }
}

struct OnboardingPage1: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.evcGreen.opacity(0.3))
                    .frame(width: 300, height: 300)
                    .blur(radius: 60)
                    .scaleEffect(isAnimating ? 1.1 : 0.9)
                    .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
                
                Image("evCharger")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 280, height: 280)
                    .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            .onAppear {
                isAnimating = true
            }
            
            VStack(spacing: 20) {
                HStack(spacing: 12) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.evcGreen)
                        .rotationEffect(.degrees(-15))
                    
                    Text("ChargeHub")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                Text("Your EV Charging Companion")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

struct OnboardingPage2: View {
    @State private var featuresAppeared = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "map.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.evcGreen)
                    .shadow(color: .evcGreen.opacity(0.5), radius: 20)
                
                Text("Find Stations Instantly")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 24) {
                FeatureRow(
                    icon: "ev.charger.fill",
                    title: "Real-time Availability",
                    description: "See which chargers are available now",
                    appeared: featuresAppeared,
                    delay: 0.1
                )
                
                FeatureRow(
                    icon: "bolt.car.fill",
                    title: "Smart Filtering",
                    description: "Filter by speed, connector type & network",
                    appeared: featuresAppeared,
                    delay: 0.2
                )
                
                FeatureRow(
                    icon: "location.fill",
                    title: "Route Planning",
                    description: "Plan trips with charging stops included",
                    appeared: featuresAppeared,
                    delay: 0.3
                )
            }
            .padding(.horizontal, 10)
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .onAppear {
            withAnimation(.spring()) {
                featuresAppeared = true
            }
        }
    }
}

struct OnboardingPage3: View {
    @State private var cardsAppeared = false
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "creditcard.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.evcGreen)
                    .shadow(color: .evcGreen.opacity(0.5), radius: 20)
                
                Text("Seamless Payments")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 20) {
                ZStack {
                    PaymentCard(color: .blue, offset: cardsAppeared ? -30 : 0, rotation: cardsAppeared ? -5 : 0)
                    PaymentCard(color: .purple, offset: cardsAppeared ? 0 : 0, rotation: cardsAppeared ? 0 : 0)
                    PaymentCard(color: .evcGreen, offset: cardsAppeared ? 30 : 0, rotation: cardsAppeared ? 5 : 0)
                }
                .frame(height: 140)
                
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        PaymentFeature(icon: "lock.fill", text: "Secure")
                        PaymentFeature(icon: "clock.fill", text: "Fast")
                        PaymentFeature(icon: "doc.text.fill", text: "History")
                    }
                    
                    Text("Pay with Apple Pay, cards, or in-app wallet")
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                cardsAppeared = true
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let title: String
    let description: String
    let appeared: Bool
    let delay: Double
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.evcGreen.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.evcGreen)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
        }
        .opacity(appeared ? 1 : 0)
        .offset(x: appeared ? 0 : 50)
        .animation(.spring().delay(delay), value: appeared)
    }
}

struct PaymentCard: View {
    let color: Color
    let offset: CGFloat
    let rotation: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(
                    colors: [color, color.opacity(0.7)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: 200, height: 120)
            .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
            .offset(x: offset)
            .rotationEffect(.degrees(rotation))
    }
}

struct PaymentFeature: View {
    let icon: String
    let text: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.evcGreen)
            
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}
