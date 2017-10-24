

import Foundation

public class Transacao{
    let id:Int
    let valor:Double
    let data:Date
    let cartao:String
    let nome:String
    
    init(id:Int, valor:Double, data:Date, cartao:String, nome:String){
        self.id = id
        self.valor = valor
        self.data = data
        self.cartao = cartao
        self.nome = nome
        
    }
}
