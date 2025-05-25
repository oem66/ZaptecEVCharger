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
    @ObservedObject var viewModel: ChargerViewModel
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
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
}
