//
//  TaskViewDelegate.swift
//  MVP_API_Request
//
//  Created by Ibram on 2/29/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation
protocol TaskViewDelegate {
    func successGetData(Data:Model)///success request and sending data
    func faildGetData()///failed request
}
