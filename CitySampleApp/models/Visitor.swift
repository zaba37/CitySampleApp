//
//  Visitor.swift
//  CitySampleApp
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

class Visitor {
    var id: String
    var name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    init(model: VisitorResponseModel) {
        self.id = model.id
        self.name = model.name
    }
}
