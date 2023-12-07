//
//  ContributorsAPI.swift
//  AdopteTest
//
//  Created by Moez bachagha on 7/12/2023.
//

import Foundation
import Alamofire

typealias ContributorListAPIResponse = (Swift.Result<[Contributor]?, DataError>) -> Void

var Contributors : [Contributor]  = []

// API interface to retrieve city

protocol ContributorsAPILogic {
    func getContributors(completion: @escaping (ContributorListAPIResponse))

    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

class ContributorsAPI: ContributorsAPILogic {

    func getContributors(completion: @escaping (ContributorListAPIResponse)) {

        guard let url = URL(string: Common.Contribtors.All) else {
            print("Invalid URL")
            completion(.failure(.invalidData))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }

            do {
                // Decode the JSON data into the Contributor struct
                let contributors = try JSONDecoder().decode([Contributor].self, from: data)
                completion(.success(contributors))

            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(.failure(.invalidData))
            }

        }.resume()
    }


    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            completion(image)
        }.resume()
    }

}
