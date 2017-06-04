//
//  MenuViewController.swift
//  HHN-App
//
//  Created by Mergim Muhaxheri on 01.06.17.
//  Copyright © 2017 Mert Sürü. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{

    let title_arr = ["Standorte" , "Routenberechnung" , "Projektbeschreibung", "Impressum"]
    
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
        
        cell.lable_titel.text = title_arr[indexPath.row]
        return cell
    }
    
}
