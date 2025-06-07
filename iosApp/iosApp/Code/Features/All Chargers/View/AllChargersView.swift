//
//  AllChargersView.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import SwiftUI

struct AllChargersView: View {
    @StateObject private var viewModel = AllChargersViewModel()
    @Binding var navigationPath: NavigationPath
    
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
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.visibleChargers.indices, id: \.self) { index in
                            ChargerCardView(navigationPath: $navigationPath,
                                            charger: viewModel.visibleChargers[index],
                                            isFeatured: false)
                            .padding()
                            .onAppear {
                                if index == viewModel.visibleChargers.count - 1 {
                                    viewModel.loadMoreChargersIfNeeded()
                                }
                            }
                        }
                        
                        if viewModel.isLoadingMore {
                            ProgressView().padding()
                        }
                    }
                }
            }
        }
        .navigationTitle("All chargers ⚡️")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(hex: "0A0E27"), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
