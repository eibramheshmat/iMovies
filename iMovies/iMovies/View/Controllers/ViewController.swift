//
//  ViewController.swift
//  iMovies
//
//  Created by Ibram on 5/18/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var MoviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            return 5
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
        self.MoviesTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        let cell = MoviesTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        return cell
    }
}
