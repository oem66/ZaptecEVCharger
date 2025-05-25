package com.zaptec.kmp.app.charger.domain.usecase

import com.zaptec.kmp.app.charger.domain.model.Charger
import com.zaptec.kmp.app.charger.domain.repository.ChargerRepository

class GetAllChargersUseCase(private val repository: ChargerRepository) {
    operator fun invoke(): List<Charger> {
        return repository.getAllChargers()
    }
}