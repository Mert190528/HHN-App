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
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
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
    
    
}


