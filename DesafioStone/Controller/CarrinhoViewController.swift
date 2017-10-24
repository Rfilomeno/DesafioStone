

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
        if nomeTF.text == "" || cartaoTF.text == "" || mesVencTF.text == "" || anoVencTF.text == "" || cvvTF.text == ""{
            print("Algum(s) valor(es) não preenchido(s)")
        }else{
        let nome = nomeTF.text
        let cartao = cartaoTF.text
        let mes = mesVencTF.text
        let ano = anoVencTF.text
        let cvv = Int(cvvTF.text!)
        
        let compra = Compra(card_number: cartao!, value: total, cvv: cvv!, card_holder_name: nome!, exp_date: "\(mes!)/\(ano!)")
        
        enviaJson(compra: compra)
        let database = TransacoesDao()
            let digitosDoCartao = Array(compra.card_number.characters)
            if digitosDoCartao.count > 4{
                var ultimosDigitos = String(digitosDoCartao[digitosDoCartao.count-4])
                ultimosDigitos += String(digitosDoCartao[digitosDoCartao.count-3])
                ultimosDigitos += String(digitosDoCartao[digitosDoCartao.count-2])
                ultimosDigitos += String(digitosDoCartao[digitosDoCartao.count-1])
                compra.card_number = ultimosDigitos
            }
        database.adicionaTransacao(compra)
        }
    }
    
    func enviaJson(compra: Compra){
        let url = URL(string: "https://private-9e3ae-rodrigofilomeno.apiary-mock.com/questions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        request.httpBody = "{\n  \"card_number\": \"\(compra.card_number)\",\n  \"value\": \(compra.value),\n  \"cvv\": \(compra.cvv),\n  \"card_holder_name\": \"\(compra.card_holder_name)\",\n  \"exp_date\": \"\(compra.exp_date)\"\n}".data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response, let data = data {
                //entrar com caixa de dialogo falando que a compra foi bem sucedida
                print(response)
                //print(String(data: data, encoding: .utf8))
            } else {
                //entrar com caixa de dialogo falando que a compra foi mal sucedida
                print(error)
            }
        }
        
        task.resume()
    }


}
