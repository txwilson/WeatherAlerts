//
//  ViewController3.swift
//  MidTerm
//
//  Created by Tyler Wilson on 10/7/16.
//  Copyright © 2016 Tyler Wilson. All rights reserved.
//

import UIKit
import MapKit


class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        latLon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getAlertInfo(_ alerts: [String]){
        test = alerts
    }
    
    var place: String = String()
    
    func saveState(_ state: String){
        place = state
    }
    
    var test: [String] = []
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int)-> Int {
        return test.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!)-> UITableViewCell!{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: "cell")
        let cellText:String = test[indexPath.row]
        cell.textLabel?.text = cellText
        switch cellText {
        case "Moderate":
            cell.backgroundColor = UIColor.yellow
        case "Severe":
            cell.backgroundColor = UIColor.orange
        case "Extreme":
            cell.backgroundColor = UIColor.red
        default:
            cell.backgroundColor = nil

        }
        return cell
    }

    
    @IBOutlet weak var map: MKMapView!
    var lat: Double = Double()
    var lon: Double = Double()
    
    func latLon(){
        if(test[8 ].isEmpty){
            lat = 0
            lon = 0
        }else{
        print(test)
        let latlon:String = test[8]
        let seperateSpace = latlon.components(separatedBy: " ")
        let seperateComma = seperateSpace[0].components(separatedBy: ",")
        lat = Double(seperateComma[0])!
        lon = Double(seperateComma[1])!
        loadMap()
        }
    }

    
    func loadMap(){
        let location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let span = MKCoordinateSpanMake(5,5)
        let region = MKCoordinateRegion(center:location, span:span)
        map.setRegion(region, animated:true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "back"{
            if let destination = segue.destination as? ViewController2 {
                destination.getState(place)
            }
        }
    }
    
    
    
    
    
}
