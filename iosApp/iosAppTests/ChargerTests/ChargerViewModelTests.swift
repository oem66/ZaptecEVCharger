//
//  ChargerViewModelTests.swift
//  iosAppTests
//
//  Created by Omer Rahmanovic on 23. 5. 2025..
//  Copyright © 2025 orgName. All rights reserved.
//

import XCTest
import shared
@testable import iosApp

class MockChargerService: ChargerServiceProtocol {
    var chargerToReturn: Charger?
    var chargersToReturn: [Charger]?
    var shouldThrowError = false
    
    func getChargerById(id: String) async throws -> Charger? {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1)
        }
        return chargerToReturn
    }
    
    func getAllChargers() async throws -> [Charger]? {
        if shouldThrowError {
            throw NSError(domain: "Test", code: 1)
        }
        return chargersToReturn
    }
}

@MainActor
class ChargerViewModelTests: XCTestCase {
    var sut: ChargerViewModel!
    var mockService: MockChargerService!
    
    override func setUp() {
        super.setUp()
        mockService = MockChargerService()
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testLoadCharger_success() async throws {
        let mockCharger = Charger(
            id: "test-id",
            name: "Test Charger",
            status: shared.ChargerStatus.charging,
            location: "Test Location"
        )
        mockService.chargerToReturn = mockCharger
        
        sut = ChargerViewModel(service: mockService)
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        await sut.loadCharger()
        
        XCTAssertNotNil(sut.charger)
        XCTAssertEqual(sut.charger?.id, "test-id")
        XCTAssertEqual(sut.charger?.name, "Test Charger")
        XCTAssertEqual(sut.charger?.status, ChargerStatus.charging)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testLoadCharger_error() async throws {
        mockService.shouldThrowError = true
        sut = ChargerViewModel(service: mockService)
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        await sut.loadCharger()
        
        XCTAssertNil(sut.charger)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testGetAllChargers_success() async {
        let mockChargers = [
            Charger(
                id: "1",
                name: "Charger 1",
                status: shared.ChargerStatus.chargeStopped,
                location: "Location 1"
            ),
            Charger(
                id: "2",
                name: "Charger 2",
                status: shared.ChargerStatus.charging,
                location: "Location 2"
            )
        ]
        mockService.chargersToReturn = mockChargers
        sut = ChargerViewModel(service: mockService)
        
        await sut.getAllChargers()
        
        XCTAssertEqual(sut.allChargers.count, 2)
        XCTAssertEqual(sut.allChargers[0].id, "1")
        XCTAssertEqual(sut.allChargers[0].status, ChargerStatus.chargeStopped)
        XCTAssertEqual(sut.allChargers[1].id, "2")
        XCTAssertEqual(sut.allChargers[1].status, ChargerStatus.charging)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testGetAllChargers_error() async {
        mockService.shouldThrowError = true
        sut = ChargerViewModel(service: mockService)
        
        await sut.getAllChargers()
        
        XCTAssertTrue(sut.allChargers.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }
}

@MainActor
class ChargerViewModelTestsAlternative: XCTestCase {
    
    func createViewModel(service: ChargerServiceProtocol) -> ChargerViewModel {
        class TestableChargerViewModel: ChargerViewModel {
            override init(service: ChargerServiceProtocol = ChargerService()) {
                super.init(service: service)
            }
        }
        return TestableChargerViewModel(service: service)
    }
    
    func testLoadChargerWithoutAutoLoad() async {
        let mockService = MockChargerService()
        mockService.chargerToReturn = Charger(
            id: "test-id",
            name: "Test Charger",
            status: shared.ChargerStatus.charging,
            location: "Test Location"
        )
        let sut = createViewModel(service: mockService)
        
        await sut.loadCharger()
        
        XCTAssertNotNil(sut.charger)
        XCTAssertEqual(sut.charger?.id, "test-id")
    }
}
