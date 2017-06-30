//
//  MapViewController.swift
//  HHN-App
//
//  Created by Mert Sürü on 30.06.17.
//  Copyright © 2017 Mert Sürü. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
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
    
    let zoomLevel: Float = 15.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let index = targetIndex
            else {
                return
        }
        if index < 0 {
            return
        }
        let target = targets[index]
        let camera = GMSCameraPosition.camera(withLatitude: target.coordinate.latitude,
                                              longitude: target.coordinate.longitude,
                                              zoom: zoomLevel)
        
        self.mapView.camera=camera
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let targetMarker = GMSMarker(position: target.coordinate)
        targetMarker.title = targetNames[index]
        targetMarker.map = mapView
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
