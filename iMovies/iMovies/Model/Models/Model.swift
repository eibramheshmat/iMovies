//
//  Model.swift
//  ZikoFirstAPI
//
//  Created by Ibram on 2/28/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation
struct Model:Codable {
    var page:Int?
    var total_results:Int?
    var total_pages:Int?
    var results:[resultsData] = [resultsData]()
}
struct resultsData:Codable {
    var id:Int?
    var poster_path:String?
    var title:String?
    var overview:String?
    var release_date:String?
}
