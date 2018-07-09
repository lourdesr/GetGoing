//
//  FilterViewController.swift
//  AnotherGetGoing
//
//  Created by Lourdes Roashan on 27/06/18.
//  Copyright © 2018 Alla Bondarenko. All rights reserved.
//

import UIKit

protocol FilterViewControllerDelegate {
    func getFilterParams(rankBy: String,distance: String, openNow: Bool)
    
    func applyFilterState(filterState: Bool)
    
    func resetFilterState(filterState: Bool)
}

class FilterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var rankBy: String!
    @IBOutlet weak var openNowSwitch: UISwitch!
    var radius: Int!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let pickerVal = ["Prominence", "Distance"]
    
    var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initValues()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initValues(){
        radius = 9999
        rankBy = "Prominence"
        openNowSwitch.isOn = false;
    }
    
    @IBAction func radiusChange(_ sender: UISlider) {
        print("Slider Value is \(sender.value)")
        radius = Int(sender.value)
    }
    
    @IBAction func openNowSelectionChange(_ sender: UISwitch) {
        
        print("Switch is \(sender.isOn)")
        openNowSwitch.isOn = sender.isOn
        
    }
    
    @IBAction func applyButtonAction(_ sender: UIBarButtonItem) {
        
        delegate?.getFilterParams(rankBy: rankBy, distance: String(radius), openNow: openNowSwitch.isOn)
        delegate?.applyFilterState(filterState: true)
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        delegate?.resetFilterState(filterState: false)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelButtonAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerVal.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerVal[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rankBy = pickerVal[row]
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

