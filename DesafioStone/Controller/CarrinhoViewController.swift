

import UIKit

class CarrinhoViewController: UIViewController, UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbValorTotal: UILabel!
    @IBOutlet weak var nomeTF: UITextField!
    @IBOutlet weak var cartaoTF: UITextField!
    @IBOutlet weak var mesVencTF: UITextField!
    @IBOutlet weak var anoVencTF: UITextField!
    @IBOutlet weak var cvvTF: UITextField!
    
    
    
    
    
    var itens:[Item] = []
    var total = 0.0
    var moeda = "R$ "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(itens.count)
        calculaTotal()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func add(itens: [Item]) {
        self.itens = itens
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = itens[indexPath.row].title
        cell.detailTextLabel?.text = moeda + String(itens[indexPath.row].price)
        return cell
    }
    
    func calculaTotal(){
        for i in 0...itens.count-1{
            total += itens[i].price
        }
        lbValorTotal.text = moeda + String(total)
    }
    
    @IBAction func finalizarCompra(_ sender: UIButton) {
        if nomeTF == nil || cartaoTF == nil || mesVencTF == nil || anoVencTF == nil || cvvTF == nil{
            return
        }
        let nome = nomeTF.text
        let cartao = cartaoTF.text
        let mes = mesVencTF.text
        let ano = anoVencTF.text
        let cvv = Int(cvvTF.text!)
        
        let compra = Compra(card_number: cartao!, value: total, cvv: cvv!, card_holder_name: nome!, exp_date: "\(mes!)/\(ano!)")
        
        print("nome: \(compra.card_holder_name)")
        print("cartão: \(compra.card_number)")
        print("Venc. \(compra.exp_date)")
        print("cvv: \(compra.cvv)")
        print("valor: \(String(compra.value))")
        print("data: \(compra.data_compra)")
    }
    
    
    
    
//    {
//    "card_number":"1234123412341234",
//    "value":7990,
//    "cvv":789,
//    "card_holder_name":"Luke Skywalker",
//    "exp_date":"12/24"
//    }


}
