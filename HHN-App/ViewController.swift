//
//  ViewController.swift
//  HHN-App
//
//  Created by Mert Sürü on 01.06.17.
//  Copyright © 2017 Mert Sürü. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var menu_vc : MenuViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
    }

    
    @IBAction func menu_action(_ sender: UIBarButtonItem) {
        
        
        if AppDelegate.menu_bool{
            
        //show menu
        show_menu()
        
        }else{
            
        //close menu
        close_menu()
        }
        
        
    }
    
    
    func show_menu()
    {
        self.menu_vc.view.backgroundColor =  UIColor.black.withAlphaComponent(0.6)
        self.addChildViewController(menu_vc)
        self.view.addSubview(menu_vc.view)
        
        
    }
    
    
    func close_menu()
    {
    
        self.menu_vc.view.removeFromSuperview()
        
        
    }
    
    
}


