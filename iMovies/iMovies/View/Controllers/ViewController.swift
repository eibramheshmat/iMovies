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
    
    // instances and variables
    lazy var appDelegate = (UIApplication.shared.delegate as! AppDelegate) /// for coredata
    lazy var taskPresenter = TaskPresenter() /// for presenter intiate
    lazy var dataFromApi = Model() /// for saving data from API
    lazy var dataFromCoreData = [Movies]() /// for saving data from coredata
    lazy var arrAPIData = [resultsData]() /// for saving data from API in array to using in pagination
    var page = 1 /// helper flag in pagination
    var tableCounter = 20 /// helper flag in pagination
    
    //outlets
    @IBOutlet weak var MoviesTableView: UITableView!
    @IBOutlet weak var tableViewFooter: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskPresenter.attachView(taskView: self) /// to attach presenter delegate with this view
        taskPresenter.getData(page: page) /// start calling presenter method (get data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataFromCoreData() /// get data from coredata
        DispatchQueue.main.async {
            self.MoviesTableView.reloadData() /// for reload data after backing from add new movie screen
        }
    }
    
    func getDataFromCoreData() {
        // fetching data from coredata
        let managmentContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movies")
        do{
            var result = try managmentContext.fetch(fetchRequest)
            result.reverse()/// to show last added in first row 
            self.dataFromCoreData = result as! [Movies]
        }catch{
            print("faild fetching")
        }
    }
}

//MARK:- Presenter Delegate
extension ViewController: TaskViewDelegate{
    
    // success request
    func successGetData(Data: Model) {
        // fetching data from API which back from success request
        self.dataFromApi = Data
        let dataCounter = Data.results.count - 1 /// for make loop to saving data in array
        for index in 0...dataCounter{
            arrAPIData.append(Data.results[index])
        }
        DispatchQueue.main.async {
            self.MoviesTableView.reloadData() /// reload table after get more data
            self.spinner.stopAnimating() /// stop spinner in bottom of table view
        }
    }
    
    // failed request
    func faildGetData() {
        // error message with faild request
        print("Error while get data")
    }
    
    
}

//MARK:- TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    // number of section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataFromCoreData.count
        }else if section == 1 {
            return arrAPIData.count
        }else{
            return 0
        }
    }
    
    // header title of each section
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
    
    // height for any row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // cell for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.MoviesTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        if indexPath.section == 0{/// if in first section
            if dataFromCoreData.count > 0{
                let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                cell.movieName.text = dataFromCoreData[indexPath.row].title
                return cell
            }else{
                let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                return cell
            }
        }else if indexPath.section == 1{/// if in second section
            if dataFromApi.results.count > 0{
                let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
                cell.movieName.text = arrAPIData[indexPath.row].title
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
    
    // didselect any row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "getDetails", sender: indexPath)
    }
    
    // prepare for seque after row tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getDetails"{
            /// find distination
            let viewController : Details = segue.destination as! Details
            let section = (sender as! NSIndexPath).section
            let row = (sender as! NSIndexPath).row //we know that sender is an NSIndexPath here.
            /// passing data for Details screen
            viewController.selectSection = section /// to know in where section tapped
            viewController.selectedMovie = row /// to know which row tapped
            viewController.data = dataFromApi /// passing data
            viewController.dataOfCoreData = dataFromCoreData /// passing data
            viewController.arrAPIData = arrAPIData /// passing data
        }
    }
    
    // for pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tableCounter {/// to detect when reach end of table
            page += 1
            if let pageNow = dataFromApi.page {
                if pageNow < page{/// compare if my page is large of page in API so i can get more
                    tableCounter += 20 /// add more item in table for pagination flag
                    spinner.startAnimating() /// start spinner at bottom of table
                    taskPresenter.getData(page: page) /// call API
                }
            }
        }
    }
}
