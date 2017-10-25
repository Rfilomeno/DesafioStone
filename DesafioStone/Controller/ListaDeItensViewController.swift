

import UIKit

class ListaDeItensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var itens: [Item] = []
    var itensSelecionados:[Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartLabel: UILabel!
    @IBOutlet weak var btnComprar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnComprar.isEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        
        downloadJson()

        // Do any additional setup after loading the view.
    }
    
    func downloadJson(){
        let url = NSURL(string: "https://raw.githubusercontent.com/stone-pagamentos/desafio-mobile/master/products.json")
        
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error)-> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) {
                
                guard let data_array = jsonObj as? NSArray else
                {
                    return
                }
                for i in 0 ..< data_array.count
                {
                    if let data_object = data_array[i] as? NSDictionary
                    {
                        if let data_title = data_object["title"] as? String,
                            let data_price = data_object["price"] as? Double,
                            let data_zipcode = data_object["zipcode"] as? String,
                            let data_seller = data_object["seller"] as? String,
                            let data_thumbnailHd = data_object["thumbnailHd"] as? String,
                            let data_date = data_object["date"] as? String
                        {
                            self.itens.append(Item(title: data_title, price: data_price, zipcode: data_zipcode, seller: data_seller, thumbnailHd: data_thumbnailHd, date: data_date))
                        }
                        
                    }
                    //print(self.itens.count)
                }}
            
            
        } ).resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
        let moeda = "R$ "
        let seller = "Sold by "
        cell.cellTitle.text = itens[indexPath.row].title
        cell.cellSeller.text = seller + itens[indexPath.row].seller
        cell.cellPrice.text = moeda + String(itens[indexPath.row].price)
        
        let imgUrl = NSURL(string: itens[indexPath.row].thumbnailHd)
        if imgUrl != nil{
            let data = NSData(contentsOf: (imgUrl as URL?)!)
            cell.cellImageView.image = UIImage(data: data! as Data)
        }
        
        return cell
        
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == UITableViewCellAccessoryType.none{
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                itensSelecionados.append(itens[indexPath.row])
                
                print("item: \(itens[indexPath.row].title), adicionado com sucesso")
                cartLabel.text = String(self.itensSelecionados.count)
                if itensSelecionados.count > 0{
                    btnComprar.isEnabled = true
                }
            }else{
                cell.accessoryType = UITableViewCellAccessoryType.none
                for i in 0...itensSelecionados.count-1{
                    if itensSelecionados[i].title == itens[indexPath.row].title{
                        itensSelecionados.remove(at: i)
                        cartLabel.text = String(itensSelecionados.count)
                        
                        break
                    }
                }
                if itensSelecionados.count == 0{
                    btnComprar.isEnabled = false
                }
                print(itensSelecionados.count)
               
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let view = segue.destination as! CarrinhoViewController
        view.add(itens: itensSelecionados)
        
    }
    
    
    
    
}
