//  Gruppe 1 <-

//  Gruppenmitglieder:
//  1. Mert Sürü (190528)
//  2. Valmir Muhaheri(190500)
//  3. Marco Vivod (190539)
//  4. Mustafa Ünaldi (190532)


//
//  NavigationViewController.swift
//  HHN-App
//
//  Created by Mert Sürü on 27.06.17.
//  Copyright © 2017 Mert Sürü. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class NavigationViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var currentLocation: CLLocation?
    var targetIndex: Int?
    
    let targets = [
        CLLocation(latitude:49.148288,longitude:9.216576),
        CLLocation(latitude:49.123248,longitude:9.210911),
        CLLocation(latitude:49.112915,longitude:9.745572),
        CLLocation(latitude:49.275650,longitude:9.712207)
    ]
    
    let targetNames = [
        "Campus Heilbronn: Am Europaplatz",
        "Campus Heilbronn: Sontheim",
        "Campus Schwäbisch Hall",
        "Campus Künzelsau"
    ]
    
    let defaultLocation = CLLocation(latitude:49.142552,longitude:9.218364)
    let zoomLevel: Float = 14.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location:CLLocation = currentLocation ?? defaultLocation
        
        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        mapView.camera=camera
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.animate(to: camera)
        
        let startMarker = GMSMarker(position: location.coordinate)
        startMarker.title = "Start"
        startMarker.map = mapView
        
        guard let index = targetIndex
            else {
                self.distanceLabel.text = "Entfernung nicht verfügbar"
                self.durationLabel.text = "Dauer nicht verfügbar"
                return
        }
        if index < 0 {
            self.distanceLabel.text = "Entfernung nicht verfügbar"
            self.durationLabel.text = "Dauer nicht verfügbar"
            return
        }
        let target = targets[index]
        
        let targetMarker = GMSMarker(position: target.coordinate)
        targetMarker.title = targetNames[index]
        targetMarker.map = mapView
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?origin=\(location.coordinate.latitude),\(location.coordinate.longitude)&destination=\(target.coordinate.latitude),\(target.coordinate.longitude)&key=AIzaSyAihBwBjMw0lIZz6BqP6XEBBN0GFLxSU84"
        
        print(directionURL)
        
        Alamofire.request(directionURL).responseJSON
            { response in
                
                if let JSON = response.result.value {
                    
                    let mapResponse: [String: AnyObject] = JSON as! [String : AnyObject]
                    
                    let routesArray = (mapResponse["routes"] as? Array) ?? []
                    
                    let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]
                    
                    let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                    let polypoints = (overviewPolyline["points"] as? String) ?? ""
                    let line  = polypoints
                    
                    let path = GMSMutablePath(fromEncodedPath: line)
                    let polyline = GMSPolyline(path: path)
                    polyline.strokeWidth = 5
                    polyline.strokeColor = .blue
                    polyline.map = self.mapView
                    
                    guard let path2 = path
                        else {
                            self.distanceLabel.text = "Entfernung nicht verfügbar"
                            self.durationLabel.text = "Dauer nicht verfügbar"
                            return
                    }
                    let pathCount = path2.count()
                    if pathCount < 2 {
                            self.distanceLabel.text = "Entfernung nicht verfügbar"
                            self.durationLabel.text = "Dauer nicht verfügbar"
                            return
                    }
                    
                    
                    var bounds = GMSCoordinateBounds()
                    for i in 1...pathCount {
                        let coordinate = path2.coordinate(at: i)
                        bounds = bounds.includingCoordinate(coordinate)
                    }
                    self.mapView.animate(with: GMSCameraUpdate.fit(bounds))
                    
                    let legs:Array = (routes["legs"] as? Array) ?? []
                    
                    let distance = ((legs.first as? Dictionary<String, AnyObject>)?["distance"]?["text"] as? String) ?? ""
                    let duration = ((legs.first as? Dictionary<String, AnyObject>)?["duration"]?["text"] as? String) ?? ""
                    
                    print(distance,duration)
                    
                    self.distanceLabel.text = "Entfernung: " + distance
                    self.durationLabel.text = "Dauer: " + duration
                }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

