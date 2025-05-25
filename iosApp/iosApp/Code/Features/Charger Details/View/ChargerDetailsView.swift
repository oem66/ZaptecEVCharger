//
//  ChargerDetailsView.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit
import shared

struct ChargerDetailsView: View {
    @Binding var navigationPath: NavigationPath
    let charger: ChargerModel
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 58.969975, longitude: 5.733107),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var selectedTab = 0
    @State private var showDirections = false
    @State private var isFavorite = false
    
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
            
            ScrollView {
                VStack(spacing: 0) {
                    ChargerMapSection()
                    
                    VStack(spacing: 24) {
                        ChargerHeaderCard()
                        
                        TabSelector()
                        
                        Group {
                            switch selectedTab {
                            case 0:
                                ChargerDetailsTab()
                            case 1:
                                ChargingOptionsTab()
                            case 2:
                                ReviewsTab()
                            default:
                                ChargerDetailsTab()
                            }
                        }
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                        
                        ActionButtonsSection()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, -40)
                    .padding(.bottom, 30)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(charger.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    log.info("Add to favorite button tapped")
                    withAnimation(.spring(response: 0.3)) {
                        isFavorite.toggle()
                    }
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 18))
                        .foregroundColor(isFavorite ? .red : .white)
                        .scaleEffect(isFavorite ? 1.1 : 1.0)
                }
            }
        }
        .toolbarBackground(Color.clear, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    @ViewBuilder
    private func ChargerMapSection() -> some View {
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $region, annotationItems: [charger]) { item in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: 58.969975, longitude: 5.733107)) {
                    ZStack {
                        Circle()
                            .fill(Color.evcGreen)
                            .frame(width: 50, height: 50)
                            .shadow(color: .evcGreen.opacity(0.5), radius: 10)
                        
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(height: 350)
            .ignoresSafeArea()
            .overlay(
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.clear,
                        Color(hex: "0A0E27").opacity(0.3),
                        Color(hex: "0A0E27").opacity(0.8)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
            HStack {
                Image(systemName: "location.fill")
                    .font(.system(size: 14))
                Text("2.3 km away")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.7))
                    .background(
                        Capsule()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .padding(.bottom, 60)
        }
    }
    
    @ViewBuilder
    private func ChargerHeaderCard() -> some View {
        VStack(spacing: 20) {
            HStack {
                StatusBadge(status: charger.status)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.yellow)
                    Text("4.8")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    Text("(247)")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.evcGreen)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(charger.location)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    
                    Text("Open 24/7 • Public Access")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.6))
                }
                
                Spacer()
            }
            
            HStack(spacing: 12) {
                QuickStatItem(
                    icon: "bolt.fill",
                    value: "150 kW",
                    label: "Max Power"
                )
                
                QuickStatItem(
                    icon: "ev.plug.dc.ccs2",
                    value: "CCS",
                    label: "Connector"
                )
                
                QuickStatItem(
                    icon: "creditcard.fill",
                    value: "$0.35",
                    label: "per kWh"
                )
            }
        }
        .padding(24)
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
    
    @ViewBuilder
    private func TabSelector() -> some View {
        HStack(spacing: 0) {
            ForEach(0..<3) { index in
                Button {
                    log.info("Select tab \(index) tapped")
                    withAnimation(.spring(response: 0.3)) {
                        selectedTab = index
                    }
                } label: {
                    VStack(spacing: 8) {
                        Text(tabTitle(for: index))
                            .font(.system(size: 16, weight: selectedTab == index ? .semibold : .medium))
                            .foregroundColor(selectedTab == index ? .white : .white.opacity(0.6))
                        
                        Rectangle()
                            .fill(Color.evcGreen)
                            .frame(height: 3)
                            .opacity(selectedTab == index ? 1 : 0)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 4)
    }
    
    private func tabTitle(for index: Int) -> String {
        switch index {
        case 0: return "Details"
        case 1: return "Charging"
        case 2: return "Reviews"
        default: return ""
        }
    }
    
    @ViewBuilder
    private func ChargerDetailsTab() -> some View {
        VStack(spacing: 20) {
            InfoSection(title: "Charger Information") {
                InfoRow(icon: "info.circle.fill", label: "Charger ID", value: charger.id)
                InfoRow(icon: "network", label: "Network", value: "ChargeHub Network")
                InfoRow(icon: "calendar", label: "Last Updated", value: "2 hours ago")
            }
            
            InfoSection(title: "Amenities") {
                AmenitiesGrid()
            }
        }
    }
    
    @ViewBuilder
    private func ChargingOptionsTab() -> some View {
        VStack(spacing: 20) {
            InfoSection(title: "Available Connectors") {
                ConnectorOption(type: "CCS", power: "150 kW", available: true)
                ConnectorOption(type: "CHAdeMO", power: "50 kW", available: true)
                ConnectorOption(type: "Type 2", power: "22 kW", available: false)
            }
            
            InfoSection(title: "Pricing") {
                PricingRow(time: "Peak Hours (6AM - 10PM)", price: "$0.35/kWh")
                PricingRow(time: "Off-Peak (10PM - 6AM)", price: "$0.25/kWh")
                PricingRow(time: "Idle Fee (after charging)", price: "$0.50/min")
            }
        }
    }
    
    @ViewBuilder
    private func ReviewsTab() -> some View {
        VStack(spacing: 16) {
            RatingSummary()
            
            InfoSection(title: "Recent Reviews") {
                ReviewItem(name: "Sarah M.", rating: 5, date: "2 days ago", comment: "Fast charging, easy to find!")
                ReviewItem(name: "John D.", rating: 4, date: "1 week ago", comment: "Good location but sometimes busy")
                ReviewItem(name: "Emma K.", rating: 5, date: "2 weeks ago", comment: "Reliable and well-maintained")
            }
        }
    }
    
    @ViewBuilder
    private func ActionButtonsSection() -> some View {
        HStack(spacing: 12) {
            Button {
                log.info("SShow directions button tapped!")
                showDirections = true
            } label: {
                HStack {
                    Image(systemName: "location.fill")
                    Text("Directions")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue)
                        .shadow(color: Color.blue.opacity(0.3), radius: 10, y: 5)
                )
            }
            
            Button {
                log.info("Start charging button tapped!")
            } label: {
                HStack {
                    Image(systemName: "bolt.fill")
                    Text("Start Charging")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.evcGreen)
                        .shadow(color: Color.evcGreen.opacity(0.3), radius: 10, y: 5)
                )
            }
        }
    }
}

struct QuickStatItem: View {
    let icon: String
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.evcGreen)
            
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            Text(label)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.05))
        )
    }
}

struct InfoSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
            
            VStack(spacing: 12) {
                content
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
            )
        }
    }
}

struct InfoRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.evcGreen)
                .frame(width: 24)
            
            Text(label)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.6))
            
            Spacer()
            
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct AmenitiesGrid: View {
    let amenities = [
        ("wifi", "WiFi"),
        ("cup.and.saucer.fill", "Coffee"),
        ("toilet.fill", "Restroom"),
        ("parkingsign", "Parking"),
        ("lock.open.fill", "24/7 Access"),
        ("camera.fill", "Security")
    ]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            ForEach(amenities, id: \.0) { amenity in
                VStack(spacing: 8) {
                    Image(systemName: amenity.0)
                        .font(.system(size: 24))
                        .foregroundColor(.evcGreen)
                    
                    Text(amenity.1)
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.03))
                )
            }
        }
    }
}

struct ConnectorOption: View {
    let type: String
    let power: String
    let available: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(available ? Color.evcGreen.opacity(0.2) : Color.red.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: "plug.fill")
                    .font(.system(size: 18))
                    .foregroundColor(available ? .evcGreen : .red)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(type)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Text(power)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            Text(available ? "Available" : "In Use")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(available ? .evcGreen : .red)
        }
        .padding(.vertical, 4)
    }
}

struct PricingRow: View {
    let time: String
    let price: String
    
    var body: some View {
        HStack {
            Text(time)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.7))
            
            Spacer()
            
            Text(price)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.evcGreen)
        }
        .padding(.vertical, 4)
    }
}

struct RatingSummary: View {
    var body: some View {
        HStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("4.8")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.yellow)
                    }
                }
                
                Text("247 reviews")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                RatingBar(stars: 5, percentage: 0.8)
                RatingBar(stars: 4, percentage: 0.15)
                RatingBar(stars: 3, percentage: 0.03)
                RatingBar(stars: 2, percentage: 0.01)
                RatingBar(stars: 1, percentage: 0.01)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.05))
        )
    }
}

struct RatingBar: View {
    let stars: Int
    let percentage: Double
    
    var body: some View {
        HStack(spacing: 8) {
            Text("\(stars)")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.6))
                .frame(width: 10)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.white.opacity(0.1))
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.yellow)
                        .frame(width: geometry.size.width * percentage)
                }
            }
            .frame(height: 4)
            
            Text("\(Int(percentage * 100))%")
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.6))
                .frame(width: 35, alignment: .trailing)
        }
    }
}

struct ReviewItem: View {
    let name: String
    let rating: Int
    let date: String
    let comment: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 2) {
                    ForEach(0..<rating) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.yellow)
                    }
                }
            }
            
            Text(comment)
                .font(.system(size: 14))
                .foregroundColor(.white.opacity(0.8))
            
            Text(date)
                .font(.system(size: 12))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(.vertical, 8)
    }
}
