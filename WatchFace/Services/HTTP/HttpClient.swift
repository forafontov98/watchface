//
//  HttpClient.swift
//  Movies
//
//  Created by MacBook on 01.12.2020.
//

import Alamofire
import UIKit

protocol IHttpClient {
    
    func getRequest(request: HttpRequestData,
                    callback: ((Result<Data, Error>) -> Void)?)
    
    func putRequest(request: HttpRequestData,
                    callback: ((Result<Data, Error>) -> Void)?)
    
    func patchRequest(request: HttpRequestData,
                      callback: ((Result<Data, Error>) -> Void)?)
    
    func postRequest(request: HttpRequestData,
                     callback: ((Result<Data, Error>) -> Void)?)
    
    func deleteRequest(request: HttpRequestData,
                       callback: ((Result<Data, Error>) -> Void)?)

}

class HttpClient: IHttpClient {
    
    static let baseURL = "http://www.my-best-dating.com/"

    func getRequest(request: HttpRequestData, callback: ((Result<Data, Error>) -> Void)?) {

        let req = Alamofire.request(HttpClient.baseURL + request.endpoint,
                                    method: .get,
                                    parameters: request.params,
                                    encoding: URLEncoding.queryString,
                                    headers: [:])
 
        req.responseString { (res) in
            
            if let err = res.error {
                callback?(.failure(err))
                return
            }
            
            guard let data = res.data else {
                let err = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                callback?(.failure(err))
                return
            }
            
            callback?(.success(data))
        }
    }
    
    func putRequest(request: HttpRequestData, callback: ((Result<Data, Error>) -> Void)?) {
        
        let req = Alamofire.request(HttpClient.baseURL + request.endpoint,
                                    method: .put,
                                    parameters: request.params,
                                    encoding: URLEncoding.queryString,
                                    headers: [:])
 
        req.responseString { (res) in
            
            if let err = res.error {
                callback?(.failure(err))
                return
            }
            
            guard let data = res.data else {
                let err = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                callback?(.failure(err))
                return
            }
            
            callback?(.success(data))
        }
    }
    
    func patchRequest(request: HttpRequestData, callback: ((Result<Data, Error>) -> Void)?) {
        
        let req = Alamofire.request(HttpClient.baseURL + request.endpoint,
                                    method: .patch,
                                    parameters: request.params,
                                    encoding: URLEncoding.queryString,
                                    headers: [:])
 
        req.responseString { (res) in
            
            if let err = res.error {
                callback?(.failure(err))
                return
            }
            
            guard let data = res.data else {
                let err = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                callback?(.failure(err))
                return
            }
            
            callback?(.success(data))
        }
        
    }
    
    func postRequest(request: HttpRequestData, callback: ((Result<Data, Error>) -> Void)?) {
        
        let req = Alamofire.request(HttpClient.baseURL + request.endpoint,
                                    method: .post,
                                    parameters: request.params,
                                    encoding: URLEncoding.queryString,
                                    headers: [:])
        
        req.responseString { (res) in
            
            if let err = res.error {
                callback?(.failure(err))
                return
            }
            
            guard let data = res.data else {
                let err = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                callback?(.failure(err))
                return
            }
            
            callback?(.success(data))
        }
        
    }
    
    func deleteRequest(request: HttpRequestData, callback: ((Result<Data, Error>) -> Void)?) {
        
        let req = Alamofire.request(HttpClient.baseURL + request.endpoint,
                                    method: .delete,
                                    parameters: request.params,
                                    encoding: URLEncoding.queryString,
                                    headers: [:])
         
        req.responseString { (res) in
            
            if let err = res.error {
                callback?(.failure(err))
                return
            }
            
            guard let data = res.data else {
                let err = AFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength)
                callback?(.failure(err))
                return
            }
            
            callback?(.success(data))
        }
        
    }
}
