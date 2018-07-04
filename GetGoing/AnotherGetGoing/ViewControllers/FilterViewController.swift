//
//  FilterViewController.swift
//  AnotherGetGoing
//
//  Created by Lourdes Roashan on 27/06/18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var openNowSwitch: UISwitch!
    @IBOutlet weak var textFieldFilter: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func radiusChange(_ sender: UISlider) {
            print("Slider Value is \(sender.value)")
    }
    
    @IBAction func openNowSelectionChange(_ sender: UISwitch) {
        
        print("Switch is \(sender.isOn)")
        
        
        
    }
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
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
