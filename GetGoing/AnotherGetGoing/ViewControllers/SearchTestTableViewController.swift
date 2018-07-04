//
//  SearchTestTableViewController.swift
//  AnotherGetGoing
//
//  Created by Lourdes Roashan on 29/06/18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import UIKit

class SearchTestTableViewController: UIViewController {

    @IBOutlet weak var sortSegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var places: [PlaceOfInterest]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sortSegmentChange(_ sender: UISegmentedControl) {
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
