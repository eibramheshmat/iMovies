//
//  ViewController.swift
//  iMovies
//
//  Created by Ibram on 5/18/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let taskPresenter = TaskPresenter()
    var dataFromApi = Model()
    var dataFromCoreData = [Movies]()
    var page = 1
    var tableCounter = 20

    @IBOutlet weak var MoviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        taskPresenter.attachView(taskView: self)
        taskPresenter.getData(page: page)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromCoreData()
        DispatchQueue.main.async {
            self.MoviesTableView.reloadData()
        }
    }
    
    func getDataFromCoreData() {
        let managmentContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        do{
            let result = try managmentContext.fetch(fetchRequest)
            self.dataFromCoreData = result as! [Movies]
        }catch{
            print("faild fetching")
        }
    }


}

extension ViewController: TaskViewDelegate{
    func successGetData(Data: Model) {
        self.dataFromApi = Data
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
            return dataFromCoreData.count
        }else if section == 1 {
            return dataFromApi.results.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if dataFromCoreData.count > 0{
              return "My Movies"
            }else{
                return ""
            }
        }else if section == 1 {
            return "All Movies"
        }else{
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if dataFromCoreData.count > 0{
                let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                cell.movieName.text = dataFromCoreData[indexPath.row].title
                return cell
            }else{
                let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                return cell
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "getDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDetails"{
            let viewController : Details = segue.destination as! Details
            let section = (sender as! NSIndexPath).section
            let row = (sender as! NSIndexPath).row //we know that sender is an NSIndexPath here.
            viewController.selectSection = section
            viewController.selectedMovie = row
            viewController.data = dataFromApi
            viewController.dataOfCoreData = dataFromCoreData
        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row + 1 == tableCounter {
//            page += 1
//            print(page)
//            print(dataFromApi.page)
//            if let pageNow = dataFromApi.page {
//                if pageNow < page{
//                    tableCounter += 20
//                    taskPresenter.getData(page: page)
//                }
//            }
//        }
//    }
}
