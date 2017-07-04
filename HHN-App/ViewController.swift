//  Gruppe 1 <-

//  Gruppenmitglieder:
//  1. Mert Sürü (190528)
//  2. Valmir Muhaheri(190500)
//  3. Marco Vivod (190539)
//  4. Mustafa Ünaldi (190532)

//  ViewController.swift
//  HHN-App
//
//
//

import UIKit
import GoogleMaps
import DropDown

class ViewController: UIViewController {
    
    @IBAction func test(_ sender: Any) {
        dropDown.show()
    }
    
    @IBOutlet weak var dropDownList: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var openNavigationButton: UIButton!
    
    
    let dropDown = DropDown()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    
    var selectedIndex = -1
    
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: 49.14282, longitude: 151.199)
    
    var menu_vc : MenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        
        self.mapView.camera=camera
        self.mapView.settings.myLocationButton = true
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.mapView.isMyLocationEnabled = true
        
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
        
        
        
        // The view to which the drop down will appear on
        dropDown.anchorView = dropDownList // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Campus Heilbronn: Am Europaplatz", "Campus Heilbronn: Sontheim", "Campus Schwäbisch Hall", "Campus Künzelsau"]
        
        dropDown.selectionAction = { [unowned self] (index, item) in
            self.dropDownList.setTitle(item, for: .normal)
            self.selectedIndex = index
            self.openNavigationButton.isEnabled = true
        }
    }
    
    
    func respondToGesture(gesture : UISwipeGestureRecognizer)
    {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.left:
            print("Left Swipe")
            // show Menu
            show_menu()
            
        case UISwipeGestureRecognizerDirection.right:
            print("Right Swipe")
            close_on_swipe()
        default:
            break
        }
        
    }
    
    @IBAction func menu_action(_ sender: UIBarButtonItem) {
        if AppDelegate.menu_bool{
            //show menu
            menu_vc.currentLocation = currentLocation
            show_menu()
        }else{
            //close menu
            close_menu()
        }
    }
    
    func close_on_swipe()
    {
        if AppDelegate.menu_bool{
            
            //show menu
            //show_menu()
            
        }else{
            
            //close menu
            close_menu()
        }
    }
    
    func show_menu()
    {
        UIView.animate(withDuration: 0.3){ ()->Void in
            
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height)
            self.menu_vc.view.backgroundColor =  UIColor.black.withAlphaComponent(0.6)
            self.addChildViewController(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
            
        }
        
        
    }
    
    
    func close_menu()
    {
        
        UIView.animate(withDuration: 0.3, animations:{ ()->Void in
            self.menu_vc.view.frame = CGRect(x: +UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height)
        }){ (finished) in
            self.menu_vc.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
        
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? NavigationViewController
        
        destination?.currentLocation = currentLocation
        destination?.targetIndex = selectedIndex

    }
    
}

// Delegates to handle events for the location manager.
extension ViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        mapView.animate(to: camera)
        currentLocation = location
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}


