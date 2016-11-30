//
//  UnitConverter.swift
//  UnitConverter
//
//  Created by prabhjot singh on 11/11/16.
//  Copyright © 2016 Prabhjot Singh. All rights reserved.
//

import Foundation

protocol PSUnitCovertible {
    var factor: Double { get }
}

extension PSUnitCovertible {
    func convertTo(value: Double, toUnits: Self) -> Double {
        return value * self.factor / toUnits.factor
    }
    
    func convertFrom(value: Double, fromUnits: Self) -> Double {
        return fromUnits.convertTo(value: value, toUnits: self)
    }
    
    func name() -> String {
        return "\(self)"
    }
    
}

enum MatricPrefix: Int {
    case nano = -9
    case micro = -6
    case milli = -3
    case centi = -2
    case none = 0
    case kilo = 3
    case mega = 6
    case giga = 9
    case terra = 12
}

enum Length: PSUnitCovertible {
    // Values are Related to meter
    case inches
    case feet
    case yards
    case meters(MatricPrefix)
    case miles
    
    var factor: Double {
        switch self {
        case let .meters(prefix):
            return pow(10, Double(prefix.rawValue))
        case .feet:
            return 0.3048
        case .inches:
            return 0.0254
        case .yards:
            return 0.9144
        case .miles:
            return 1609.344
        }
    }
}

enum Weight: PSUnitCovertible {
    case grams(MatricPrefix)
    case ounces
    case pounds
    case stones
    case usTons
    case imperialTons
    
    var factor: Double {
        switch self {
        case let .grams(prefix):
            return pow(10, Double(prefix.rawValue - 3))
        case .ounces:
            return 0.028349523125
        case .pounds:
            return 0.453592
        case .stones:
            return 6.35029318
        case .usTons:
            return 907.18474
        case .imperialTons:
            return 1016.05
        }
    }
}

enum Time: PSUnitCovertible {
    case seconds(MatricPrefix)
    case minute
    case hour
    case day
    case week
    case month
    case year
    
    var factor: Double {
        switch self {
        case let .seconds(prefix):
            return pow(10, Double(prefix.rawValue))
        case .minute:
            return 60
        case .hour:
            return pow(Time.minute.factor, 2)
        case .day:
            return 24 * Time.hour.factor
        case .week:
            return 7 * Time.day.factor
        case .month:
            return 4.34524 * Time.week.factor
        case .year:
            return 12 * Time.month.factor
        }
    }
}

enum DigitalStorage: PSUnitCovertible {
    
    case bit
    case byte
    case kilobyte
    case megabyte
    case gigaByte
    case terabyte
    
    var factor: Double {
        switch self {
        case .bit:
            return 0.125
        case .byte:
            return 1
        case .kilobyte:
            return 1.024 * Double(MatricPrefix.kilo.rawValue)
        case .megabyte:
            return 1.049 * Double(MatricPrefix.mega.rawValue)
        case .gigaByte:
            return 1.074 * Double(MatricPrefix.giga.rawValue)
        case .terabyte:
            return 1.1 * Double(MatricPrefix.terra.rawValue)
        }
    }
}

enum Temperature: PSUnitCovertible {
    case kelvin
    case fahrenheit
    case celsius
    
    var factor: Double {
        switch self {
        case .celsius:
            return 274.15
        case .kelvin:
            return 1
        case .fahrenheit:
            return 255.928
        }
    }
}

enum Frequency: PSUnitCovertible {
    case hertz(MatricPrefix)
    
    var factor: Double {
        switch self {
        case let .hertz(prefix):
            return pow(10, Double(prefix.rawValue))
        }
    }
}

struct Unit<T: PSUnitCovertible> {
    var value: Double
    var unit: T
    
    func convert(to newUnit: T) -> Unit<T> {
        let newValue = unit.convertTo(value: value, toUnits: newUnit)
        return Unit<T>(value: newValue, unit: newUnit)
    }
}

func ==<T>(lhs: Unit<T>, rhs: Unit<T>) -> Bool {
    return lhs.value == rhs.value && lhs.unit.factor == rhs.unit.factor
}

func +<T>(lhs: Unit<T>, rhs: Unit<T>) -> Unit<T> {
    let newValue = lhs.value + rhs.unit.convertTo(value: rhs.value, toUnits: lhs.unit)
    return Unit<T>(value: newValue, unit: lhs.unit)
}

func -<T>(lhs: Unit<T>, rhs: Unit<T>) -> Unit<T> {
    let newValue = lhs.value - rhs.unit.convertTo(value: rhs.value, toUnits: lhs.unit)
    return Unit<T>(value: newValue, unit: lhs.unit)
}

func *<T>(lhs: Unit<T>, rhs: Unit<T>) -> Unit<T> {
    let newValue = lhs.value * rhs.unit.convertTo(value: rhs.value, toUnits: lhs.unit)
    return Unit<T>(value: newValue, unit: lhs.unit)
}

func /<T>(lhs: Unit<T>, rhs: Unit<T>) -> Unit<T> {
    let newValue = lhs.value / rhs.unit.convertTo(value: rhs.value, toUnits: lhs.unit)
    return Unit<T>(value: newValue, unit: lhs.unit)
}
