

import UIKit

class CarrinhoViewController: UIViewController, UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbValorTotal: UILabel!
    
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


}
