//
//  Contributor.swift
//  AdopteTest
//
//  Created by Moez bachagha on 7/12/2023.
//

import Foundation
struct Contributor: Decodable {

    let login: String?
    let id: Int?
    let node_id: String?
    let avatar_url: String?
    let contributions: Int?



    enum CodingKeys: String, CodingKey {
        case login
        case id
        case node_id
        case avatar_url
        case contributions


    }
}
