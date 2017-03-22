//
//  CatchViewController.swift
//  PokemonSaga
//
//  Created by KR DEVARAJAN NAIR on 2017/03/17.
//  Copyright © 2017 KR DEVARAJAN NAIR. All rights reserved.
//

import UIKit

class CatchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var allCaught:[Pokemon]=[]
    var allUnCaught:[Pokemon]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCaught=getAllCaught()
        allUnCaught=getAllUnCaught()
        
        tblView.delegate=self
        tblView.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0{
            return "Caught"
        }
        else{
            return "UnCaught"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0{
            return allCaught.count
        }
        else{
            return allUnCaught.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=UITableViewCell()
        
        let pokemon=indexPath.section==0 ? allCaught[indexPath.row] : allUnCaught[indexPath.row]
        
        cell.textLabel?.text=pokemon.name
        cell.imageView?.image=UIImage(named: pokemon.image!)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMap(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
