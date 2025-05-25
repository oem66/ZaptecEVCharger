//
//  ChargerService.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import shared

protocol ChargerServiceProtocol {
    func getChargerById(id: String) async throws -> Charger?
    func getAllChargers() async throws -> [Charger]?
}

final class ChargerService: ChargerServiceProtocol {
    private let getChargerByIdUseCase = ChargerServiceFactory().createGetChargerByIdUseCase()
    private let getAllChargersUseCase = ChargerServiceFactory().createGetAllChargersUseCase()
    
    func getChargerById(id: String) async throws -> Charger? {
        let fetchedCharger = self.getChargerByIdUseCase.invoke(id: id)
        return fetchedCharger
    }
    
    func getAllChargers() async throws -> [Charger]? {
        let chargers = self.getAllChargersUseCase.invoke()
        return chargers
    }
}
