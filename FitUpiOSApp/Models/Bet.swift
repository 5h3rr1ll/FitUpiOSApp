//
//  Bet.swift
//  FitUpiOSApp
//
//  Created by Anthony Sherrill on 02.05.22.
//

import Foundation

struct Bet: Identifiable {
    let id: String
    let activity: String
    let wakeUpTime: Date
    let dauration: Date
    let amount: Int
}
