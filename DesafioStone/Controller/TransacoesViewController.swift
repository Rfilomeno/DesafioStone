//
//  TransacoesViewController.swift
//  DesafioStone
//
//  Created by Rodrigo Filomeno on 24/10/17.
//  Copyright © 2017 Rodrigo Filomeno. All rights reserved.
//

import UIKit

class TransacoesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var transacoes:[Transacao] = []
    var moeda = "R$ "
    var hidedDigits = "****"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let database = TransacoesDao()
        transacoes = database.getTransacoes()
        print(transacoes.count)
        //tableView.estimatedRowHeight = 126
        //tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 126;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transacoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransacaoCell
        cell.idLabel.text = String(transacoes[indexPath.row].id)
        cell.valorLabel.text = moeda + String(transacoes[indexPath.row].valor)
        cell.dataLabel.text = String(describing: transacoes[indexPath.row].data)
        cell.cartaoLabel.text = hidedDigits + transacoes[indexPath.row].cartao
        cell.nomeLabel.text = transacoes[indexPath.row].nome
        
        return cell
    }

}
