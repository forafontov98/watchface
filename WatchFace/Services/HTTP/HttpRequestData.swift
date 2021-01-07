//
//  HttpRequestData.swift
//  Movies
//
//  Created by MacBook on 01.12.2020.
//

import UIKit
import Alamofire

struct HttpRequestData {
    let endpoint: String
    let params: [String : Any]?
}
