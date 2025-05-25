//
//  ChargerModel.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

struct ChargerModel: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let status: ChargerStatus
    let location: String
}
