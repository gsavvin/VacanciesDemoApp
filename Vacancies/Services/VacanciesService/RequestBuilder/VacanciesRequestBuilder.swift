//
//  VacanciesRequestBuilder.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

class VacanciesRequestBuilder: VacanciesRequestBuilderInterface {
    
    let baseUrl: String
    
    required init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func vacanciesRequest(query: VacanciesQuery) -> URLRequest? {
        let method = "/vacancies"
        var urlString = self.baseUrl + method
        var parameters = [String]()
        query.parameters?.forEach({ (parameter) in
            let parameterString = "\(parameter.key.rawValue)=\(parameter.value)"
            let encoded = parameterString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? parameterString
            parameters.append(encoded)
        })
        
        if let pagination = query.pagination {
            pagination.parameters?.forEach({ (parameter) in
                parameters.append("\(parameter.key.rawValue)=\(parameter.value)")
            })
        }
        
        if parameters.isEmpty == false {
            urlString.append("?" + parameters.joined(separator: "&"))
        }

        var request: URLRequest?
        if let url = URL(string: urlString) {
            request = URLRequest(url: url)
            request?.httpMethod = "GET"
        }
        return request
    }
}
