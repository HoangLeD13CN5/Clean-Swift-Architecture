//
//  API.swift
//  DemoCleanAchi
//
//  Created by LEMINHO on 4/2/18.
//  Copyright © 2018 LEMINHO. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class API<T>{
    func request() -> Observable<T> {
        return Observable<T>.create { observer in
            self.request(observer: observer)
            return Disposables.create {
            }
        }
    }
    
    private func request(observer: AnyObserver<T>) {
        let request = Alamofire.request(self.requestUrl(), method: self.method(), parameters: self.params(), encoding: self.encoding(), headers: self.headers())
            .responseJSON { response in
                
                print("API RESPONSE:\n" + response.debugDescription)
                
                switch response.result {
                case .success(let val):
                    if(response.response!.statusCode < 400) {
                        //                        if !(val is NSNull) { no contents でもstreamを流したい
                        observer.onNext(try! self.convertJson(val))
                        //                        }
                        observer.onCompleted()
                        //                    } else if self.handleCommonError (code: response.response?.statusCode, observer: observer) {
                    } else {
                        observer.onError(ApiErrorResult(val))
                    }
                case .failure(let error):
                    //API POST success reponse body no content
                    if (error as NSError).code == 4 {
                        observer.onCompleted()
                    } else {
                        observer.onError(error)
                    }
                }
        }
        
        print("API REQUEST:\n" + request.debugDescription)
    }
    
    func convertJson(_ val: Any) throws -> T {
        throw NSError()
    }
    
    func requestUrl() -> String {
        return baseUrl() + path()
    }
    
    func baseUrl() -> String {
        return AppUtils.BASE_URL
    }
    
    func path() -> String {
        fatalError("abstract method")
    }
    
    func method() -> Alamofire.HTTPMethod {
        return .get
    }
    
    func params() -> Parameters {
        return [:]
    }
    
    func encoding() -> Alamofire.ParameterEncoding {
        return URLEncoding.default
    }
    
    func headers() -> Alamofire.HTTPHeaders {
        return  ["Content-Type": "application/json"]
    }
}
