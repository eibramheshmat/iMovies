//
//  TaskService.swift
//  MVP_API_Request
//
//  Created by Ibram on 2/29/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation
class TaskService{
    func getData(page: Int, callback: @escaping(Model?)->()){
        Network.shared.makeHttpRequest(model: Model(), method: .get, APIName: "", parameters: ["api_key":"\(Constants.app_key)","page":"\(page)"]) { (result) in
            switch result {
            case .success(let response):
//                print(response)
                callback(response)
            case .failure(let error):
                print(error)
                callback(nil)
            }
        }
    }
}
