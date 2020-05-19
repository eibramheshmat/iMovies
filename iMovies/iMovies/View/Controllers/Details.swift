//
//  Details.swift
//  iMovies
//
//  Created by Ibram on 5/18/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit
import CoreData

class Details: UIViewController {
    
    // inctances and varibales
    var selectSection: Int?
    var selectedMovie: Int?
    var data: Model?
    var dataOfCoreData : [Movies]?
    lazy var arrAPIData = [resultsData]()
    
    // outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectSection == 0{/// if i come from my movies section
            movieTitle.text = dataOfCoreData?[selectedMovie ?? 0].title
            movieDate.text = "Released : " + (dataOfCoreData?[selectedMovie ?? 0].relasedate ?? "")
            movieOverview.text = dataOfCoreData?[selectedMovie ?? 0].overview
            loadImage(section: selectSection ?? 0)
        }else if selectSection == 1 {/// else if i come from all movies section
            movieTitle.text = arrAPIData[selectedMovie ?? 0].title
            movieDate.text = "Released : " + (arrAPIData[selectedMovie ?? 0].release_date ?? "")
            movieOverview.text = arrAPIData[selectedMovie ?? 0].overview
            loadImage(section: selectSection ?? 1)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loadImage(section: Int) {
        if section == 0{/// if i come from my movies section
            if let image = dataOfCoreData?[selectedMovie ?? 0].image {
                if image.isEmpty {/// if no image set image default
                    movieImage.image = UIImage(named: "movieIcon")
                }else{
                    movieImage.image = UIImage(data: image)
                }
            }
        }else if section == 1{/// else if i come from all movies section
            let fullURL = Constants.basImageUrl + (arrAPIData[selectedMovie ?? 0].poster_path ?? "")
            let url = URL(string: fullURL)!
            let imageData = try? Data(contentsOf: url)
            if let imgData = imageData{
                movieImage.image = UIImage(data: imgData)
            }
        }
        
    }

    

}
