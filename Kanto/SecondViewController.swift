//
//  SecondViewController.swift
//  Kanto
//
//  Created by Mohale MOLIELENG on 2017/10/09.
//  Copyright © 2017 Mohale MOLIELENG. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var myTableView: UITableView!
  
    var places: [String] = ["WeThinkCode_","42 Echol","Mzanzi","WeThinkCode_","42 Echol","Mzanzi"]
    
    let myLocations = [
        Location(title: "WeThinkCode", subTitle:"84 Albertina Sisulu Rd, Johannesburg, 2000", latitude: -26.204938, longitude: 28.040223),
        Location(title: "FNB Bank City",subTitle:"64 Simmonds Street", latitude: -26.202792, longitude: 28.039397),
        Location(title: "Gandi Square",subTitle:"Marshalls Town", latitude: -26.206591, longitude: 28.043453),
        Location(title: "Echlo 42",subTitle:"",latitude: -26.196707, longitude: 28.047314)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell_row", for: indexPath)

        cell.textLabel?.text = myLocations[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("Selected \(indexPath.row)")
        
        let navCtrl = self.tabBarController?.viewControllers![0] as! FirstViewController
        
        //navCtrl.myPlaces.append("One More")// = places
        navCtrl.showCurrentPin(location:myLocations[indexPath.row])
        
        self.tabBarController?.selectedIndex = 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

