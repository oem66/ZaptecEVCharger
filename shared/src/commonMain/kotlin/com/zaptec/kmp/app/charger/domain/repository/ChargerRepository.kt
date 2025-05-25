package com.zaptec.kmp.app.charger.domain.repository

import com.zaptec.kmp.app.charger.domain.model.Charger

interface ChargerRepository {
    fun getChargerById(id: String): Charger?
    fun getAllChargers(): List<Charger>
}
