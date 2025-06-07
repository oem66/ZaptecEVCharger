//
//  NavigationDestination.swift
//  iosApp
//
//  Created by Omer Rahmanovic
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import shared

enum NavigationDestination: Hashable {
    case Charger, AllChargersView, ChargerDetails(ChargerModel)
}
