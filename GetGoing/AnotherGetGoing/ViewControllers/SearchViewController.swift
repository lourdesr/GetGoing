//
//  SearchViewController.swift
//  AnotherGetGoing
//
//  Created by Alla Bondarenko on 2018-06-13.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchParameterTextField: UITextField!
    
    @IBOutlet weak var filterBtn: UIButton!
    var searchParam: String?
    
    //MARK: - View Controller LifeCycle Views
    
    var radius: String!
    var rankBy: String!
    var isOpen: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initValues()
        searchParameterTextField.delegate = self
    }
    
    func initValues(){
        radius = "9999"
        rankBy = "Prominence"
        isOpen = false
    }
    
    // MARK: - Button Actions
    @IBAction func searchButtonAction(_ sender: UIButton) {
        print("chooo chooo button")
        searchParameterTextField.resignFirstResponder()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if let inputValue = searchParam {
                GooglePlacesAPI.textSearch(query: inputValue, rank: rankBy, radius: radius, isopen: isOpen, completionHandler: {(status, json) in
                    if let jsonObj = json {
                        let places = APIParser.parseAPIResponse(json: jsonObj)
                        //update UI on the main thread!
                        DispatchQueue.main.async {
                            if places.count > 0 {
                                self.presentSearchResults(places)
                            } else {
                                self.generalAlert(title: "Oops", message: "No results found")
                            }
                        }
                        print("\(places.count)")
                    } else {
                        self.generalAlert(title: "Oops", message: "An error parsing json")
                    }
                })
                
            } else {
                generalAlert(title: "Oops", message: "An error has occurred")
            }
        case 1:
            if let currentLocation = LocationService.sharedInstance.currentLocation {
                GooglePlacesAPI.nearbySearch(for: currentLocation.coordinate, keyword: searchParam, completionHandler: {(status, json) in
                    if let jsonObj = json {
                        let places = APIParser.parseAPIResponse(json: jsonObj)
                        //update UI on the main thread!
                        DispatchQueue.main.async {
                            if places.count > 0 {
                                self.presentSearchResults(places)
                            } else {
                                self.generalAlert(title: "Oops", message: "No results found")
                            }
                        }
                        print("\(places.count)")
                    } else {
                        self.generalAlert(title: "Oops", message: "An error parsing json")
                    }
                })
            } else {
                generalAlert(title: "Oops", message: "Could not identify your location")
            }
        default:
            break;
        }
        
    }
    
    @IBAction func searchSelectionChanged(_ sender: UISegmentedControl) {
        print("segment control changed \(segmentedControl.selectedSegmentIndex)")
        if segmentedControl.selectedSegmentIndex == 1 {
            LocationService.sharedInstance.delegate = self
            LocationService.sharedInstance.startUpdatingLocation()
        }
    }
    
    func presentSearchResults(_ results: [PlaceOfInterest]){
        
        let searchResultsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsViewController") as! SearchResultsViewController
        searchResultsViewController.places = results
        
        navigationController?.pushViewController(searchResultsViewController, animated: true)
        
    }
    
    
    func generalAlert(title: String, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true) {
            self.searchParameterTextField.placeholder = "Input something"
        }
    }
    
    
    
    @IBAction func presentFilters(_ sender: UIButton){
        
        let filtersViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        filtersViewController.delegate = self
        
        present(filtersViewController, animated: true, completion: nil)
        
        
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


//MARK: - Text Field Delegate
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchParameterTextField {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == searchParameterTextField {
            searchParam = textField.text
            print(textField.text ?? "no input")
        }
        return true
    }
    
}

//MARK: - Location Service Delegate

extension SearchViewController: LocationServiceDelegate,FilterViewControllerDelegate {
    func resetFilterState(filterState: Bool) {
        filterBtn.setImage(UIImage(named: "filtersDefault"),for: [])
    }
    
    func tracingLocation(_ currentLocation: CLLocation) {
        print("\(currentLocation.coordinate.latitude) \(currentLocation.coordinate.longitude)")
    }
    
    func tracingLocationDidFailWithError(_ error: Error) {
        
    }
    
    func getFilterParams(rankBy: String,distance: String, openNow: Bool) {
        
        self.radius = distance
        self.rankBy = rankBy
        self.isOpen = openNow
        
    }
    
    func applyFilterState(filterState: Bool){
        filterBtn.setImage(UIImage(named: "filters"),for: [])
    }
}

