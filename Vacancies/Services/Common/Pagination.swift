//
//  Pagination.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 26.06.2021.
//

import Foundation

struct Pagination {

    let perPage: UInt
    private(set) var page: UInt
    
    var parameters: [Pagination.Parameter: Any]? {
        get {
            return [
                .perPage: self.perPage,
                .page: self.page,
            ]
        }
    }
    
    enum Parameter: String {
        
        case perPage = "per_page"
        case page = "page"
    }
    
    mutating func incrementPage() {
        self.page += 1
    }
    
    static var defaultPagination: Pagination {
        get { return Pagination(perPage: 20, page: 0) }
    }
}
