//
//  VacanciesListViewModelsBuilder.swift
//  Vacancies
//
//  Created by Геннадий Саввин on 23.06.2021.
//

import Foundation

class VacanciesListViewModelsBuilder: NSObject {
    
    private var cachedViewModels: [ViewModelConfigurableCellViewModel]?
    
    func clearCachedViewModels() {
        self.cachedViewModels = nil
    }
    
    func viewModels(vacanciesResult: VacanciesResult) -> [ViewModelConfigurableCellViewModel] {
        var viewModels = [ViewModelConfigurableCellViewModel]()
        
        if let vacancies = vacanciesResult.vacancies {
            for vacancy in vacancies {
                viewModels.append(self.viewModel(vacancy: vacancy))
            }
            
            if viewModels.isEmpty == false {
                if let cachedViewModels = self.cachedViewModels {
                    viewModels.insert(contentsOf: cachedViewModels, at: 0)
                }
                
                self.cachedViewModels = viewModels
            }

            if vacanciesResult.isLastPage == false {
                viewModels.append(self.throbberViewModel())
            }
        } else {
            // show error
        }

        return viewModels
    }
    
    private func viewModel(vacancy: Vacancy) -> VacancyViewModel {
        let viewModel = VacancyViewModel(id: vacancy.id,
                                         name: vacancy.name,
                                         employer: vacancy.employer?.name,
                                         area: vacancy.area?.name,
                                         salary: self.salaryString(salary: vacancy.salary),
                                         description: vacancy.snippet?.responsibility)
        viewModel.identifier = vacancy.id
        return viewModel
    }
    
    private func throbberViewModel() -> ThrobberViewModel {
        let viewModel = ThrobberViewModel()
        viewModel.identifier = ThrobberViewModel.identifier
        return viewModel
    }
    
    private func salaryString(salary: Vacancy.Salary?) -> String? {
        var string = "З/п не указана"
        
        if let salary = salary {
            if let from = salary.from {
                var currencyString = ""
                if let currency = salary.currency {
                    currencyString = self.getSymbol(forCurrencyCode: currency) ?? ""
                }
                
                if let to = salary.to {
                    string = String(format: "%i - %i %@", from, to, currencyString)
                } else {
                    string = String(format: "от %i %@", from, currencyString)
                }
            }
        }
        
        return string
    }
    
    private func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
}
