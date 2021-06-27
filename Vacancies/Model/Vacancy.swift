//
//  Vacancy.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

struct Vacancy: Codable {

    var id: String
    var name: String
    
    var employer: Employer?
    struct Employer: Codable {
        var name: String?
    }
    
    var area: Area?
    struct Area: Codable {
        var name: String?
    }
    
    var snippet: Snippet?
    struct Snippet: Codable {
        var responsibility: String?
    }
    
    var salary: Salary?
    struct Salary: Codable {
        var from: Int?
        var to: Int?
        var currency: String?
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.employer = try? container.decode(Throwable<Employer>.self, forKey: .employer).result.get()
        self.area = try? container.decode(Throwable<Area>.self, forKey: .area).result.get()
        self.snippet = try? container.decode(Throwable<Snippet>.self, forKey: .snippet).result.get()
        self.salary = try? container.decode(Throwable<Salary>.self, forKey: .salary).result.get()
    }
}

