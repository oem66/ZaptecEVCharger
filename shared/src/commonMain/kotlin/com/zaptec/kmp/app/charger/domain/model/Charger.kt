package com.zaptec.kmp.app.charger.domain.model

data class Charger(
    val id: String,
    val name: String,
    val status: ChargerStatus,
    val location: String
)
