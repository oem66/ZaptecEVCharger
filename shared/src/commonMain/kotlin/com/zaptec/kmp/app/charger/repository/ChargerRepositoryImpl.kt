package com.zaptec.kmp.app.charger.repository

import com.zaptec.kmp.app.charger.domain.model.Charger
import com.zaptec.kmp.app.charger.domain.model.ChargerStatus
import com.zaptec.kmp.app.charger.domain.repository.ChargerRepository

class ChargerRepositoryImpl : ChargerRepository {
    private val chargers = listOf(
        Charger(
            id = "550e8400-e29b-41d4-a716-446655440000",
            name = "Home Charger",
            status = ChargerStatus.CHARGING,
            location = "Main charger in garage",
        ),
        Charger(
            id = "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
            name = "Work Charger",
            status = ChargerStatus.CHARGING,
            location = "Office parking level 2",
        ),
        Charger(
            id = "6ba7b811-9dad-11d1-80b4-00c04fd430c8",
            name = "Public Charger",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Shopping mall - north entrance",
        ),
        Charger(
            id = "6ba7b812-9dad-11d1-80b4-00c04fd430c8",
            name = "Fast Charger",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Highway rest stop #42",
        ),
        Charger(
            id = "6ba7b813-9dad-11d1-80b4-00c04fd430c8",
            name = "Airport Terminal A",
            status = ChargerStatus.CHARGING,
            location = "International Airport - Terminal A parking",
        ),
        Charger(
            id = "6ba7b814-9dad-11d1-80b4-00c04fd430c8",
            name = "Hotel Valet",
            status = ChargerStatus.CHARGING,
            location = "Grand Hotel downtown - valet parking",
        ),
        Charger(
            id = "6ba7b815-9dad-11d1-80b4-00c04fd430c8",
            name = "University Campus",
            status = ChargerStatus.CHARGING,
            location = "State University - student parking lot C",
        ),
        Charger(
            id = "6ba7b816-9dad-11d1-80b4-00c04fd430c8",
            name = "Grocery Store",
            status = ChargerStatus.CHARGING,
            location = "MegaMart - customer parking front row",
        ),
        Charger(
            id = "6ba7b817-9dad-11d1-80b4-00c04fd430c8",
            name = "City Hall",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Municipal building - visitor parking",
        ),
        Charger(
            id = "6ba7b818-9dad-11d1-80b4-00c04fd430c8",
            name = "Sports Arena",
            status = ChargerStatus.CHARGING,
            location = "Metro Sports Complex - east entrance",
        ),
        Charger(
            id = "6ba7b819-9dad-11d1-80b4-00c04fd430c8",
            name = "Library Branch",
            status = ChargerStatus.CHARGING,
            location = "Central Library - main parking structure",
        ),
        Charger(
            id = "6ba7b81a-9dad-11d1-80b4-00c04fd430c8",
            name = "Medical Center",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Regional Medical Center - outpatient parking",
        ),
        Charger(
            id = "6ba7b81b-9dad-11d1-80b4-00c04fd430c8",
            name = "Train Station",
            status = ChargerStatus.CHARGING,
            location = "Central Railway Station - commuter lot",
        ),
        Charger(
            id = "6ba7b81c-9dad-11d1-80b4-00c04fd430c8",
            name = "Beach Pavilion",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Oceanview Beach - pavilion parking",
        ),
        Charger(
            id = "6ba7b81d-9dad-11d1-80b4-00c04fd430c8",
            name = "Business District",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Financial District - Tower Plaza garage",
        ),
        Charger(
            id = "6ba7b81e-9dad-11d1-80b4-00c04fd430c8",
            name = "Community Center",
            status = ChargerStatus.CHARGING,
            location = "Riverside Community Center - main lot",
        ),
        Charger(
            id = "6ba7b81f-9dad-11d1-80b4-00c04fd430c8",
            name = "Park & Ride",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Metro Park & Ride - zone B",
        ),
        Charger(
            id = "6ba7b820-9dad-11d1-80b4-00c04fd430c8",
            name = "Tech Campus",
            status = ChargerStatus.CHARGING,
            location = "Innovation Tech Park - building 7",
        ),
        Charger(
            id = "6ba7b821-9dad-11d1-80b4-00c04fd430c8",
            name = "Retail Plaza",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Sunset Shopping Plaza - near food court",
        ),
        Charger(
            id = "6ba7b822-9dad-11d1-80b4-00c04fd430c8",
            name = "Gas Station",
            status = ChargerStatus.CHARGING,
            location = "Shell Station - Highway 101 exit 23",
        ),
        Charger(
            id = "6ba7b823-9dad-11d1-80b4-00c04fd430c8",
            name = "Movie Theater",
            status = ChargerStatus.CHARGING,
            location = "CinePlex 16 - premium parking",
        ),
        Charger(
            id = "6ba7b824-9dad-11d1-80b4-00c04fd430c8",
            name = "Convention Center",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Metro Convention Center - north hall",
        ),
        Charger(
            id = "6ba7b825-9dad-11d1-80b4-00c04fd430c8",
            name = "Apartment Complex",
            status = ChargerStatus.CHARGING,
            location = "Riverside Apartments - resident parking",
        ),
        Charger(
            id = "6ba7b826-9dad-11d1-80b4-00c04fd430c8",
            name = "Golf Course",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Pineview Golf Club - clubhouse parking",
        ),
        Charger(
            id = "6ba7b827-9dad-11d1-80b4-00c04fd430c8",
            name = "Factory Outlet",
            status = ChargerStatus.CHARGING,
            location = "Premium Outlets - section D",
        ),
        Charger(
            id = "6ba7b828-9dad-11d1-80b4-00c04fd430c8",
            name = "Zoo Entrance",
            status = ChargerStatus.CHARGING,
            location = "Metro Zoo - main entrance parking",
        ),
        Charger(
            id = "6ba7b829-9dad-11d1-80b4-00c04fd430c8",
            name = "Restaurant District",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Little Italy - shared parking garage",
        ),
        Charger(
            id = "6ba7b82a-9dad-11d1-80b4-00c04fd430c8",
            name = "Fitness Center",
            status = ChargerStatus.CHARGING,
            location = "24/7 Fitness - member parking lot",
        ),
        Charger(
            id = "6ba7b82b-9dad-11d1-80b4-00c04fd430c8",
            name = "Pharmacy Drive-Thru",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "CVS Pharmacy - corner of Main & 5th",
        ),
        Charger(
            id = "6ba7b82c-9dad-11d1-80b4-00c04fd430c8",
            name = "Church Parking",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "First Baptist Church - visitor lot",
        ),
        Charger(
            id = "6ba7b82d-9dad-11d1-80b4-00c04fd430c8",
            name = "Bank Branch",
            status = ChargerStatus.CHARGING,
            location = "First National Bank - customer parking",
        ),
        Charger(
            id = "6ba7b82e-9dad-11d1-80b4-00c04fd430c8",
            name = "Auto Dealership",
            status = ChargerStatus.CHARGING,
            location = "Tesla Showroom - service center",
        ),
        Charger(
            id = "6ba7b82f-9dad-11d1-80b4-00c04fd430c8",
            name = "Marina Dock",
            status = ChargerStatus.CHARGING,
            location = "Harbor Marina - slip owners parking",
        ),
        Charger(
            id = "6ba7b830-9dad-11d1-80b4-00c04fd430c8",
            name = "School District",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Lincoln High School - staff parking",
        ),
        Charger(
            id = "6ba7b831-9dad-11d1-80b4-00c04fd430c8",
            name = "Warehouse District",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Industrial Park - building 12",
        ),
        Charger(
            id = "6ba7b832-9dad-11d1-80b4-00c04fd430c8",
            name = "Coffee Shop",
            status = ChargerStatus.CHARGING,
            location = "Starbucks - Pine Street location",
        ),
        Charger(
            id = "6ba7b833-9dad-11d1-80b4-00c04fd430c8",
            name = "Gas Station Express",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Mobil Express - downtown location",
        ),
        Charger(
            id = "6ba7b834-9dad-11d1-80b4-00c04fd430c8",
            name = "Tourist Center",
            status = ChargerStatus.CHARGING,
            location = "Visitor Information Center - welcome plaza",
        ),
        Charger(
            id = "6ba7b835-9dad-11d1-80b4-00c04fd430c8",
            name = "Casino Parking",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Lucky Sevens Casino - valet level",
        ),
        Charger(
            id = "6ba7b836-9dad-11d1-80b4-00c04fd430c8",
            name = "Theme Park",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Adventure World - main entrance lot",
        ),
        Charger(
            id = "6ba7b837-9dad-11d1-80b4-00c04fd430c8",
            name = "Outlet Mall",
            status = ChargerStatus.CHARGING,
            location = "Designer Outlets - food court area",
        ),
        Charger(
            id = "6ba7b838-9dad-11d1-80b4-00c04fd430c8",
            name = "Highway Service",
            status = ChargerStatus.CHARGING,
            location = "Highway 95 - mile marker 156",
        ),
        Charger(
            id = "6ba7b839-9dad-11d1-80b4-00c04fd430c8",
            name = "Corporate HQ",
            status = ChargerStatus.CHARGING,
            location = "TechCorp Headquarters - employee garage",
        ),
        Charger(
            id = "6ba7b83a-9dad-11d1-80b4-00c04fd430c8",
            name = "Riverside Park",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Riverside Park - picnic area parking",
        ),
        Charger(
            id = "6ba7b83b-9dad-11d1-80b4-00c04fd430c8",
            name = "Shopping Center",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Northgate Shopping Center - anchor store",
        ),
        Charger(
            id = "6ba7b83c-9dad-11d1-80b4-00c04fd430c8",
            name = "Bus Terminal",
            status = ChargerStatus.CHARGING,
            location = "Greyhound Station - passenger pickup",
        ),
        Charger(
            id = "6ba7b83d-9dad-11d1-80b4-00c04fd430c8",
            name = "Stadium Parking",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Metro Stadium - gate C parking",
        ),
        Charger(
            id = "6ba7b83e-9dad-11d1-80b4-00c04fd430c8",
            name = "Grocery Chain",
            status = ChargerStatus.CHARGING,
            location = "Whole Foods - organic market plaza",
        ),
        Charger(
            id = "6ba7b83f-9dad-11d1-80b4-00c04fd430c8",
            name = "Rest Area",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Interstate 40 - eastbound rest area",
        ),
        Charger(
            id = "6ba7b840-9dad-11d1-80b4-00c04fd430c8",
            name = "Office Complex",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Corporate Center - tower 3 parking",
        ),
        Charger(
            id = "6ba7b841-9dad-11d1-80b4-00c04fd430c8",
            name = "Farmer's Market",
            status = ChargerStatus.CHARGING,
            location = "Weekend Farmer's Market - vendor area",
        ),
        Charger(
            id = "6ba7b842-9dad-11d1-80b4-00c04fd430c8",
            name = "Metro Station",
            status = ChargerStatus.CHARGING,
            location = "Blue Line Metro - park & ride lot",
        ),
        Charger(
            id = "6ba7b843-9dad-11d1-80b4-00c04fd430c8",
            name = "Fast Food Plaza",
            status = ChargerStatus.CHARGING,
            location = "Food Court Plaza - shared parking",
        ),
        Charger(
            id = "6ba7b844-9dad-11d1-80b4-00c04fd430c8",
            name = "Department Store",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Macy's Department Store - east entrance",
        ),
        Charger(
            id = "6ba7b845-9dad-11d1-80b4-00c04fd430c8",
            name = "Truck Stop",
            status = ChargerStatus.CHARGE_STOPPED,
            location = "Big Rig Truck Stop - Highway 10 exit",
        )
    )

    override fun getChargerById(id: String): Charger? {
        return chargers.find { it.id == id }
    }

    override fun getAllChargers(): List<Charger> {
        return chargers
    }
}
