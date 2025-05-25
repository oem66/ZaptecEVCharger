package com.zaptec.kmp.app.charger.di

import com.zaptec.kmp.app.charger.repository.ChargerRepositoryImpl
import com.zaptec.kmp.app.charger.domain.repository.ChargerRepository
import com.zaptec.kmp.app.charger.domain.usecase.GetChargerByIdUseCase
import com.zaptec.kmp.app.charger.domain.usecase.GetAllChargersUseCase

object ChargerServiceFactory {
    private fun provideChargerRepository(): ChargerRepository {
        return ChargerRepositoryImpl()
    }

    fun provideGetChargerByIdUseCase(repository: ChargerRepository = provideChargerRepository()): GetChargerByIdUseCase {
        return GetChargerByIdUseCase(repository)
    }

    fun createGetChargerByIdUseCase(): GetChargerByIdUseCase {
        return GetChargerByIdUseCase(provideChargerRepository())
    }

    fun provideGetAllChargersUseCase(repository: ChargerRepository = provideChargerRepository()): GetAllChargersUseCase {
        return GetAllChargersUseCase(repository)
    }

    fun createGetAllChargersUseCase(): GetAllChargersUseCase {
        return GetAllChargersUseCase(provideChargerRepository())
    }
}
