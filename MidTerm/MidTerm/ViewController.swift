//
//  ViewController.swift
//  MidTerm
//
//  Created by Tyler Wilson on 10/3/16.
//  Copyright © 2016 Tyler Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var stateChoice:String = ""
    var states = ["AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"]
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)->Int {
        return states.count
    }
    
    func pickerView(_ pickerView:UIPickerView, titleForRow row: Int, forComponent component: Int)->String! {
        return states[row] 
        
    }
    
    func pickerView(_ pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        stateChoice = states[row]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stateAlerts"{
            if let destination = segue.destination as? ViewController2 {
               destination.getState(stateChoice)
            }
        }
    }
}

