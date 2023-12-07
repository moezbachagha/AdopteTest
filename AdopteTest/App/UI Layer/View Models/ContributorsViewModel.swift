//
//  ContributorsViewModel.swift
//  AdopteTest
//
//  Created by Moez bachagha on 7/12/2023.
//

import Foundation
import UIKit

class ContributorsViewModel {

    private(set) var Contributors: [Contributor] = []
    private(set) var error: DataError? = nil

    private let apiService: ContributorsAPILogic

    init(apiService: ContributorsAPILogic = ContributorsAPI()) {
        self.apiService = apiService
    }

    func getContributors(completion: @escaping( ([Contributor]?, DataError?) -> () ) ) {
        self.Contributors = []
        apiService.getContributors { [weak self] result in

            switch result {
            case .success(let contributors):
                   if let contributors = contributors {
                     //  print(contributors)
                       self?.Contributors = contributors ?? []
                       completion(self?.Contributors, nil)
                   } else {
                   }

            case .failure(let error):
                self?.error = error
                completion(nil, error)
            }
        }
    }



    func getImage(from url: URL, completion: @escaping( (UIImage?)?, DataError?) -> () )  {
        apiService.downloadImage (from : url,
                                  completion: { [weak self] result in
            if let image = result {
                completion(image, nil)
            }
            else {

                completion(nil, DataError.invalidData)
            }
        }
        )
    }

}
