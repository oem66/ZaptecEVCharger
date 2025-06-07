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
    @Published private(set) var isLoading = false
    
    private let service: ChargerServiceProtocol
    
    let sampleChargerId = "550e8400-e29b-41d4-a716-446655440000"
    
    init(service: ChargerServiceProtocol = ChargerService()) {
        self.service = service
        Task {
            await loadCharger()
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
    
    private func handleChargerStatus(charger: Charger) -> ChargerStatus {
        return charger.status == shared.ChargerStatus.chargeStopped ? .chargeStopped : .charging
    }
}
