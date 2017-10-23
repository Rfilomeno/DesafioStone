

import Foundation

public class Compra{
    
    var card_number:String
    var value:Double
    var cvv:Int
    var card_holder_name:String
    var exp_date:String
    var data_compra = Date()
    
    
    
    init(card_number:String, value:Double, cvv:Int, card_holder_name:String, exp_date:String){
         self.card_number = card_number
         self.value = value
         self.cvv = cvv
         self.card_holder_name = card_holder_name
         self.exp_date = exp_date
        

    }
}
