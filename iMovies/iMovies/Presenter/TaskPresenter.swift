//
//  TaskPresenter.swift
//  MVP_API_Request
//
//  Created by Ibram on 2/29/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation
class TaskPresenter{
    var taskService = TaskService()
    var taskView: TaskViewDelegate!
    var Data = Model()
    
    func attachView(taskView: TaskViewDelegate){
        self.taskView = taskView
    }
    
    func getData(){
        taskService.getData(callback:{
            data in
            if let data = data{
                self.taskView.successGetData(Data: data)
            }
            else{
                self.taskView.faildGetData()
            }
        })
    }
}
