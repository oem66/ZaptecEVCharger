package com.zaptec.kmp.app.charger.domain.usecase

import com.zaptec.kmp.app.charger.domain.model.Charger
import com.zaptec.kmp.app.charger.domain.repository.ChargerRepository

class GetChargerByIdUseCase(private val repository: ChargerRepository) {
    fun invoke(id: String): Charger? {
        return repository.getChargerById(id)
    }
}
