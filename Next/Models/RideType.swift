//
//  RideType.swift
//  NextApp
//
//  Created by JJMac on 3/07/24.
//


import Foundation

enum RideType: Int, CaseIterable, Identifiable{
    case fast
    case express
    case standard
    
    var id: Int {return rawValue}
    
    var description: String{
        switch self{
        case .fast: return "Fast"
        case .express: return "Express"
        case .standard: return "Standard"
        }
    }
    
    var imageName: String{
        switch self{
        case .fast: return "fast"
        case .express: return "express"
        case .standard: return "standard"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .fast:
            return 30
        case .express:
            return 50
        case .standard:
            return 90
        }
    }
    
    func computePrice(for distanceInMeters: Double) -> Double {
        let distanceInMiles =  distanceInMeters / 1600
        
        switch self {
        case .fast:
            return distanceInMiles * 1.2 * baseFare
        case .express:
            return distanceInMiles * 1.5 * baseFare
        case .standard:
            return distanceInMiles * 2.0 * baseFare
        }
    }
}
