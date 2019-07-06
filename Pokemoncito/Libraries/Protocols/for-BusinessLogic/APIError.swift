//
//  APIError.swift
//  Pokemoncito
//
//  Created by Alejandro on 7/1/19.
//  Copyright © 2019 Kalakmul. All rights reserved.
//

import Foundation

// MARK - Error

enum APIError: Error, ReportableError {
    var detailed: String {
        switch self {
        case .malformedURL:
            return "The provided URL is malformed"
        }
    }
    
    case malformedURL
}

// MARK - An enum for handling API responses

public enum Result<DataType> {
    case success(DataType)
    case fail(Error)
}

protocol ReportableError {
    var detailed : String { get }
}
