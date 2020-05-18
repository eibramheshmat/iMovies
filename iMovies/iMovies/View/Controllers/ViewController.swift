//
//  ViewController.swift
//  iMovies
//
//  Created by Ibram on 5/18/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let taskPresenter = TaskPresenter()
    var dataFromApi = Model()
    var page = 1

    @IBOutlet weak var MoviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        taskPresenter.attachView(taskView: self)
        taskPresenter.getData(page: page)
        // Do any additional setup after loading the view.
    }


}

extension ViewController: TaskViewDelegate{
    func successGetData(Data: Model) {
        self.dataFromApi = Data
        if dataFromApi.page ?? 0 > page{
            page += 1
        }
        DispatchQueue.main.async {
            self.MoviesTableView.reloadData()
        }
    }
    
    func faildGetData() {
        print("Error while get data")
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {
            return dataFromApi.results.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "My Movies"
        }else if section == 1 {
            return "All Movies"
        }else{
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            return cell
        }else if indexPath.section == 1{
            if dataFromApi.results.count > 0{
                let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                cell.movieName.text = dataFromApi.results[indexPath.row].title
                return cell
            }else{
                let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                return cell
            }
        }else{
            let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
            return cell
        }
    }
}
