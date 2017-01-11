//
//  ViewController2.swift
//  MidTerm
//
//  Created by Tyler Wilson on 10/6/16.
//  Copyright © 2016 Tyler Wilson. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, XMLParserDelegate{


    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://alerts.weather.gov/cap/fl.php?x=0")
        let xmlParser = XMLParser(contentsOf: url!)
        xmlParser?.delegate = self
        xmlParser?.parse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var alertState:String = ""

    func getState(_ state: String){
        alertState = state
    }
    
    func tableView(_ tableView: UITableView!, numberOfRowsInSection section: Int)-> Int {
        return self.alerts.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAtIndexPath indexPath: IndexPath!)-> UITableViewCell!{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle,reuseIdentifier: "cell")
        alertInfo = alerts[indexPath.row]
        cell.textLabel?.text = alertInfo.event
        cell.detailTextLabel?.text = alertInfo.severity
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath){
        self.performSegue(withIdentifier: "detailAlert", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailAlert"{
            if let destination = segue.destination as? ViewController3 {
                weatherInfo()
                destination.saveState(alertState)
                destination.getAlertInfo(array)
            }
        }
    }
    
    var array: [String] = []

    func weatherInfo(){
        array.append(alertInfo.event)
        array.append(alertInfo.severity)
        array.append(alertInfo.summary)
        array.append(alertInfo.effective)
        array.append(alertInfo.expires)
        array.append(alertInfo.urgency)
        array.append(alertInfo.certainty)
        array.append(alertInfo.link)
        array.append(alertInfo.polygon)
    }
    
    var eventFound: Bool = false
    var alerts: [values] = []
    var event: String = ""
    var severity: String = ""
    var summary: String = ""
    var effective: String = ""
    var expires: String = ""
    var urgency: String = ""
    var certainty: String = ""
    var polygon: String = ""
    var link: String = ""
    var name: String = ""
    var value = values()
    var alertInfo = values()
    
    struct values{
        var event: String = String()
        var severity: String = String()
        var summary: String = String()
        var effective: String = String()
        var expires: String = String()
        var urgency: String = String()
        var certainty: String = String()
        var polygon: String = String()
        var link: String = String()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        name = elementName
        switch elementName {
        case "cap:event":
            eventFound = true
        case "cap:severity":
            eventFound = true
        case "cap:polygon":
            eventFound = true
        case "summary":
            eventFound = true
        case "cap:effective":
            eventFound = true
        case "cap:expires":
            eventFound = true
        case "cap:urgency":
            eventFound = true
        case "cap:certainty":
            eventFound = true
        case "link":
            eventFound = true
        default:
            eventFound = true
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, nameSpaceURI: String?, qualifiedName qName: String?){
        switch elementName {
        case "cap:event":
            eventFound = false
        case "cap:severity":
            eventFound = false
        case "cap:polygon":
            eventFound = false
        case "summary":
            eventFound = true
        case "cap:effective":
            eventFound = true
        case "cap:expires":
            eventFound = true
        case "cap:urgency":
            eventFound = true
        case "cap:certainty":
            eventFound = true
        case "link":
            eventFound = true
        default:
            eventFound = false
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        let removeWhiteSpace = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (eventFound) {
            switch name {
            case "cap:event":
                value.event += removeWhiteSpace
                alerts.append(value)
            case "cap:severity":
                value.severity += removeWhiteSpace
                alerts.append(value)
            case "cap:polygon":
                value.polygon += removeWhiteSpace
                alerts.append(value)
            case "summary":
                value.summary += removeWhiteSpace
                alerts.append(value)
            case "cap:effective":
               value.effective += removeWhiteSpace
               alerts.append(value)
            case "cap:expires":
                value.expires += removeWhiteSpace
                alerts.append(value)
            case "cap:urgency":
               value.urgency += removeWhiteSpace
               alerts.append(value)
            case "cap:certainty":
               value.certainty += removeWhiteSpace
               alerts.append(value)
            case "link":
               value.link += removeWhiteSpace
               alerts.append(value)
            default:
                eventFound = false
            }
        }
    }

}
