//
//  VacanciesQuery.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import Foundation

struct VacanciesQuery: Equatable {

    var parameters: [VacanciesQuery.Parameter: Any]?
    
    enum Parameter: String {
        
        case text = "text"
        case areaId = "area"
    }
    
    var pagination: Pagination?
    
    static func == (lhs: VacanciesQuery, rhs: VacanciesQuery) -> Bool {
        var isEqual = true
        if let lhsParams = lhs.parameters, let rhsParams = rhs.parameters {
            for parameter in lhsParams {
                if rhsParams[VacanciesQuery.Parameter(rawValue: parameter.key.rawValue)!] == nil {
                    isEqual = false
                    break
                }
            }
        }
        return isEqual
    }
}

