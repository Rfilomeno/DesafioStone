

import Foundation
import SQLite

public class TransacoesDao{
    //variaveis para o banco de dados
    var database: Connection!
    let trasacoesTable = Table("transacoes")
    let id = Expression<Int>("id")
    let valor = Expression<Double>("valor")
    let data = Expression<Date>("data")
    let cartao = Expression<String>("cartao")
    let nomePortador = Expression<String>("nome")
    
    init(){
        
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("transacoes").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        }catch{
            print(error)
        }
    }
    func dropTable(){
        let dropTable = self.trasacoesTable.drop()
        do{
            try database.run(dropTable)
            print("Tabela apagada com sucesso")
        }catch{
            print(error)
        }
    }
    
    func createDB(){
        
        let createTable = self.trasacoesTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.valor)
            table.column(self.data)
            table.column(self.cartao)
            table.column(self.nomePortador)
        }
        
        do{
            try database.run(createTable)
            print("Tabela Criada com sucesso")
        }catch{
            print(error)
        }
        
    }
    
    func adicionaTransacao(_ compra: Compra){
    
        let insert =  self.trasacoesTable.insert(self.valor <- compra.value, self.data <- compra.data_compra, self.cartao <- compra.card_number, self.nomePortador <- compra.card_holder_name)
        
        do{
           try self.database.run(insert)
            print("Transacao adicionada ao BD.")
        }catch{
            print(error)
        }
    }
    
    func getTransacoes() -> [Transacao]{
        
        do{
            let resposta = try self.database.prepare(self.trasacoesTable)
            var transacoes: [Transacao] = []
                for transacao in resposta{
                    transacoes.append(Transacao(id: transacao[self.id], valor: transacao[self.valor], data: transacao[self.data], cartao: transacao[self.cartao], nome: transacao[self.nomePortador]))
                }
            return transacoes
        }catch{
            print(error)
            return []
        }
    }
}
