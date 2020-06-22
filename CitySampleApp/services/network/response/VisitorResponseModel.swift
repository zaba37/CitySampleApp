//
//  VisitorResponseModel.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

struct VisitorResponseModel: Codable {
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}

extension VisitorResponseModel: Equatable {
    static func == (lhs: VisitorResponseModel, rhs: VisitorResponseModel) -> Bool {
        return lhs.id == rhs.id
    }
}
