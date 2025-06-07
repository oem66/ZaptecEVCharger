//
//  AllChargersViewModel.swift
//  iosApp
//
//  Created by Omer Rahmanovic on 7. 6. 2025..
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Combine
import shared

@MainActor
final class AllChargersViewModel: ObservableObject {
    @Published private(set) var allChargers: [ChargerModel] = []
    @Published private(set) var visibleChargers: [ChargerModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    
    private let service: ChargerServiceProtocol
    private var currentPage = 0
    private let pageSize = 5
    
    init(service: ChargerServiceProtocol = ChargerService()) {
        self.service = service
        Task {
            await getAllChargers()
        }
    }
    
    func getAllChargers() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let serviceChargers = try await service.getAllChargers() ?? []
            
            allChargers = serviceChargers.map {
                ChargerModel(id: $0.id,
                             name: $0.name,
                             status: handleChargerStatus(charger: $0),
                             location: $0.location)
            }
            
            loadMoreChargersIfNeeded()
        } catch {
            log.error(error.localizedDescription)
        }
    }
    
    func loadMoreChargersIfNeeded() {
        guard !isLoadingMore else { return }
        
        let nextIndex = (currentPage + 1) * pageSize
        guard nextIndex <= allChargers.count else { return }
        
        isLoadingMore = true
        
        let newItems = allChargers.prefix(nextIndex)
        visibleChargers = Array(newItems)
        currentPage += 1
        
        isLoadingMore = false
    }
    
    private func handleChargerStatus(charger: Charger) -> ChargerStatus {
        return charger.status == shared.ChargerStatus.chargeStopped ? .chargeStopped : .charging
    }
}
