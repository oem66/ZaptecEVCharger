//
//  ChargerCardView.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import shared

struct ChargerCardView: View {
    @Binding var navigationPath: NavigationPath
    let charger: ChargerModel
    let isFeatured: Bool
    
    @State private var batteryLevel: Double = 0.25
    @State private var isCharging: Bool = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    if isFeatured {
                        Text("FEATURED CHARGER")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.evcGreen)
                            .tracking(1.2)
                    }
                    
                    Text(charger.name)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 8) {
                        StatusBadge(status: charger.status)
                        
                        Text("•")
                            .foregroundColor(.white.opacity(0.3))
                        
                        HStack(spacing: 4) {
                            Image(systemName: "bolt.fill")
                                .font(.system(size: 12))
                            Text("150 kW")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .foregroundColor(.white.opacity(0.7))
                    }
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.evcGreen.opacity(0.3), Color.evcGreen.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "ev.charger.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.evcGreen)
                }
            }
            .padding(20)
            
            if isCharging {
                BatteryIndicator(batteryLevel: batteryLevel)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            
            HStack(spacing: 12) {
                Button {
                    log.info("Charge/Stop Charging button tapped!")
                    if isCharging {
                        stopCharging()
                    } else {
                        startChargingSimulation()
                    }
                } label: {
                    HStack {
                        Image(systemName: isCharging ? "stop.fill" : "bolt.fill")
                            .font(.system(size: 16))
                        Text(isCharging ? "Stop" : "Charge")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isCharging ? Color.red : Color.evcGreen)
                            .shadow(color: (isCharging ? Color.red : Color.evcGreen).opacity(0.3), radius: 10, y: 5)
                    )
                }
                
                Button {
                    log.info("Show Charger Details button tapped!")
                    navigationPath.append(NavigationDestination.ChargerDetails(charger))
                } label: {
                    HStack {
                        Text("Details")
                            .font(.system(size: 16, weight: .semibold))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                            )
                    )
                }
            }
            .padding(20)
            .padding(.top, -10)
        }
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.08),
                            Color.white.opacity(0.03)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .shadow(color: Color.black.opacity(0.3), radius: 20, y: 10)
    }
    
    private func startChargingSimulation() {
        isCharging = true
        batteryLevel = 0.25
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(.linear(duration: 0.5)) {
                batteryLevel += (0.75 / 60)
                
                if batteryLevel >= 1.0 {
                    batteryLevel = 1.0
                    stopCharging()
                }
            }
        }
    }
    
    private func stopCharging() {
        timer?.invalidate()
        timer = nil
        isCharging = false
        
        if batteryLevel >= 1.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    batteryLevel = 0.25
                }
            }
        }
    }
}

struct BatteryIndicator: View {
    let batteryLevel: Double
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "battery.25")
                    .font(.system(size: 20))
                    .foregroundColor(.white.opacity(0.5))
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.1))
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        batteryLevel < 0.8 ? Color.orange : Color.green,
                                        batteryLevel < 0.8 ? Color.orange.opacity(0.8) : Color.green.opacity(0.8)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * batteryLevel)
                    }
                }
                .frame(height: 12)
                
                Text("\(Int(batteryLevel * 100))%")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .frame(width: 50, alignment: .trailing)
            }
            
            if batteryLevel < 1.0 {
                Text("Charging ...")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.5))
            }
        }
    }
}

struct StatusBadge: View {
    let status: ChargerStatus
    
    var statusInfo: (text: String, color: Color) {
        switch status {
        case .charging:
            return ("Active", .green)
        case .chargeStopped:
            return ("Available", .blue)
        }
    }
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(statusInfo.color)
                .frame(width: 8, height: 8)
            
            Text(statusInfo.text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(statusInfo.color.opacity(0.2))
        )
    }
}
