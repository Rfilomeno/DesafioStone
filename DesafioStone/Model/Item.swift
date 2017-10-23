
import Foundation

public class Item{
    var title = ""
    var price = 0.0
    var zipcode = ""
    var seller = ""
    var thumbnailHd = ""
    var date = ""
    
    
    
    init(title:String, price:Double, zipcode:String, seller:String, thumbnailHd:String, date:String)
    {
        self.title = title
        self.price = price/100
        self.zipcode = zipcode
        self.seller = seller
        self.thumbnailHd = thumbnailHd
        self.date = date
    }
}
