//
//  ChargerViewModel.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import Combine
import shared

@MainActor
class ChargerViewModel: ObservableObject {
    @Published private(set) var charger: ChargerModel?
    @Published private(set) var allChargers: [ChargerModel] = []
    @Published private(set) var visibleChargers: [ChargerModel] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isLoadingMore = false
    @Published var showAllChargers = false
    
    private let service: ChargerServiceProtocol
    private var currentPage = 0
    private let pageSize = 5
    
    let sampleChargerId = "550e8400-e29b-41d4-a716-446655440000"
    
    init(service: ChargerServiceProtocol = ChargerService()) {
        self.service = service
        Task {
            await loadCharger()
            await getAllChargers()
        }
    }
    
    func loadCharger() async {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let serviceCharger = try await service.getChargerById(id: sampleChargerId) else { return }
            
            charger = ChargerModel(id: serviceCharger.id,
                                   name: serviceCharger.name,
                                   status: handleChargerStatus(charger: serviceCharger),
                                   location: serviceCharger.location)
        } catch {
            log.error(error.localizedDescription)
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
