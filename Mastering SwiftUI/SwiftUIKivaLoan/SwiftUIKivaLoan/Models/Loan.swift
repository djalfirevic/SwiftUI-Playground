//
//  Loan.swift
//  SwiftUIKivaLoan
//
//  Created by Djuro Alfirevic on 5/2/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import Foundation

struct Loan: Identifiable {
    var id = UUID()
    var name: String
    var country: String
    var use: String
    var amount: Int

    init(name: String, country: String, use: String, amount: Int) {
        self.name = name
        self.country = country
        self.use = use
        self.amount = amount
    }
}

extension Loan: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case country = "location"
        case use
        case amount = "loan_amount"
    }

    enum LocationKeys: String, CodingKey {
        case country
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        
        let location = try values.nestedContainer(keyedBy: LocationKeys.self, forKey: .country)
        country = try location.decode(String.self, forKey: .country)

        use = try values.decode(String.self, forKey: .use)
        amount = try values.decode(Int.self, forKey: .amount)

    }
}

class LoanStore: Decodable, ObservableObject {
    @Published var loans = [Loan]()
    private var cachedLoans = [Loan]()
    private static var kivaLoanURL = "https://api.kivaws.org/v1/loans/newest.json"

    enum CodingKeys: CodingKey {
        case loans
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        loans = try values.decode([Loan].self, forKey: .loans)
    }

    init() {

    }
    
    func fetchLatestLoans() {
        guard let loanUrl = URL(string: Self.kivaLoanURL) else { return }

        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }

            // Parse JSON data
            if let data = data {
                DispatchQueue.main.async {
                    self.loans = self.parseJsonData(data: data)
                    self.cachedLoans = self.loans
                }
            }
        })
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Loan] {
        do {
            let loanStore = try JSONDecoder().decode(LoanStore.self, from: data)
            self.loans = loanStore.loans
        } catch {
            print(error)
        }

        return loans
    }
    
    func filterLoans(maxAmount: Int) {
        self.loans = self.cachedLoans.filter { $0.amount < maxAmount }
    }
}
