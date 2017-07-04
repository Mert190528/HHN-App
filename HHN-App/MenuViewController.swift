//
//  MenuViewController.swift
//  HHN-App
//
//  Created by Valmir Muhaxheri on 01.06.17.
//  Copyright © 2017 Mert Sürü. All rights reserved.
//  Gruppe 1 <-

//  Gruppenmitglieder:
//  1. Mert Sürü (190528)
//  2. Valmir Muhaheri(190500)
//  3. Marco Vivod (190539)
//  4. Mustafa Ünaldi (190532)
//  
//  Icon von <a href="https://icons8.com/icon/10735/Go-Filled">, für Go.


import UIKit
import GoogleMaps

class MenuViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{

    let title_arr = ["Standorte" , "Navigation"]
    var currentLocation: CLLocation?
    @IBOutlet weak var menu_tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menu_tableView.delegate =  self
        menu_tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return title_arr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menu_cell") as! MenuTableViewCell
        
        cell.menuButton.setTitle(title_arr[indexPath.row], for: .normal)
        cell.menuButton.tag = indexPath.row
        if indexPath.row == 0 {
            cell.menuButton.addTarget(self, action: #selector(MenuViewController.segueAction0(_:)), for: .touchUpInside)
        } else {
            cell.menuButton.addTarget(self, action: #selector(MenuViewController.segueAction1(_:)), for: .touchUpInside)
        }


        return cell
    }
    
    func segueAction0(_ sender:UIButton!) {
        closeMenu()
        self.performSegue(withIdentifier: "moveToView0", sender: sender)
    }
    
    func segueAction1(_ sender:UIButton!) {
        closeMenu()
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.3, animations:{ ()->Void in
            self.view.frame = CGRect(x: +UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height)
        }){ (finished) in
            self.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "moveToView") {
//            if let destination = segue.destination as? ViewController {
//                if let button:UIButton = sender as! UIButton? {
//                    print(button.tag) //optional
//                    if button.tag == 0 {
//                    }
//                }
//                }
//            
//        }
        let destination = segue.destination as? LocationListController
        
        destination?.currentLocation = currentLocation
    }
}
