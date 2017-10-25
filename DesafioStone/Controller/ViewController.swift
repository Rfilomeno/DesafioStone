//
//  ViewController.swift
//  DesafioStone
//
//  Created by Rodrigo Filomeno on 22/10/17.
//  Copyright © 2017 Rodrigo Filomeno. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    var itens:[Item] = []
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myIndicator.isHidden = true
        let database = TransacoesDao()
        database.createDB()
        //database.dropTable()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startIndicator(_ sender: UIButton) {
        myIndicator.isHidden = false
        myIndicator.startAnimating()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        myIndicator.isHidden = true
        myIndicator.stopAnimating()
    }
    

}

