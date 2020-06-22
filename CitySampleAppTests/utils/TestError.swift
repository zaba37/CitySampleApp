//
//  TestError.swift
//  CitySampleAppTests
//
//  Created by Krystian Zabicki on 22/06/2020.
//  Copyright © 2020 kzdev. All rights reserved.
//

import Foundation

import Foundation

enum TestError: Error {
    case dummyError1
    case dummyError2

}

extension TestError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dummyError1:
            return NSLocalizedString(
                "DummyError1",
                comment: ""
            )
        case .dummyError2:
            return NSLocalizedString(
                "DummyError2",
                comment: ""
            )
        }
    }
}
