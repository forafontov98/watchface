//
//  Result.swift
//  Movies
//
//  Created by MacBook on 01.12.2020.
//

import Foundation

@frozen public enum Result<Success, Failure> where Failure : Error {
    case success(Success)
    case failure(Failure)
}
