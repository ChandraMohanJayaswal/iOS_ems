//
//  PublicHoildaysAPIResponseDetails+Extension.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
extension PublicHolidaysAPIResponseDetails {
    static var mock: PublicHolidaysAPIResponseDetails {
        return PublicHolidaysAPIResponseDetails(
            id: 1,
            fiscalYear: PublicHoliday.mock,
            date: 0.0,
            description: "Mock Description"
        )
    }
}
