//
//  SearchResultsViewController.swift
//  AnotherGetGoing
//
//  Created by Alla Bondarenko on 2018-06-18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var places: [PlaceOfInterest]!
    var sortedPlaces: [PlaceOfInterest]!
    
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableViewCellNib = UINib(nibName: "POITableViewCell", bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: "reusableIdentifier")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func sortData(index: Int) {

        switch index {
        case 0:
            places = places.sorted(by: {
                $0.name < $1.name
            })
        case 1:
            places = places.sorted(by: {
                Int($0.rating!) > Int($1.rating!)
            })
        default:
            break;
        }
        tableView.reloadData()
    }
    
    
    
    //MARK: - Sort Segment Control Action
    
    @IBAction func sortSegmentAction(_ sender: UISegmentedControl) {

        print("Changed \(sortSegment.selectedSegmentIndex)")
        
        sortData(index: sortSegment.selectedSegmentIndex)
        
    }
    
    
    
    //MARK: - TableView Delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableIdentifier") as! POITableViewCell
        
        cell.titleLabel.text = places[indexPath.row].name
        cell.addressLabel.text = places[indexPath.row].formattedAddress

        var rating = ""
//        for i in 1...Int(places[indexPath.row].rating!){
//            rating = rating + "*"
//        }
//
//        cell.ratingLabel.text = "Rating: "+rating
        
        if let imageUrl  = places[indexPath.row].iconUrl, let url = URL(string: imageUrl),
            let dataContents = try? Data(contentsOf: url), let imageSrc = UIImage(data: dataContents){
            cell.iconImageView.image = imageSrc
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        detailsViewController.place = places[indexPath.row]
        
        navigationController?.pushViewController(detailsViewController, animated: true)
        
        
        
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
