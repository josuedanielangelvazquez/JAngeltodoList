//
//  TareasViewModel.swift
//  JAngeltodoList
//
//  Created by MacBookMBA6 on 03/04/23.
//

import Foundation
import SQLite3
class TareasViewModel{
    func getdatename(  mounth: Int, year : Int)->[days]{
        
            var arraydays = [days]()
            let calendar = Calendar.current
            let dateComponents = DateComponents(year: 2023, month: 4)
            let startDate = calendar.date(from: dateComponents)!
            let range = calendar.range(of: .day, in: .month, for: startDate)!
            let rangecount = range.count

            for day in range.lowerBound..<range.upperBound {
                let dateformatter = DateFormatter()
                let dateformatternumber = DateFormatter()
                dateformatter.dateFormat = "EEE"
                dateformatternumber.dateFormat = "dd"
                let dateComponents = DateComponents(year: 2023, month: 4, day: day)
                var date = calendar.date(from: dateComponents)!
                var dateformatedfinish = dateformatter.string(from: date)
                var datenumberdayfinish = dateformatternumber.string(from: date)
                 var Days = days(daynumber: datenumberdayfinish, dayname: dateformatedfinish)
                arraydays.append(Days)
             
                }
            
            return  arraydays
        }
    func addCategorie(categoria : Category)-> Result{
        var result = Result()
        let context = DB.init()
        let query = "Insert INTO Categorias(NameCategoria) VALUES(?)"
        var statement : OpaquePointer? = nil
        
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                sqlite3_bind_text(statement, 1, (categoria.namecategory as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statement) == SQLITE_DONE{
                    result.Correct = true
                }
                else{
                    result.Correct = false
                }
            }
        }
        catch let error {
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
    return result
    }
    func geatllCategories()-> Result{
        var result = Result()
        let context = DB.init()
        let query = "Select IdCategoria, NameCategoria FROM  Categorias"
        var statement : OpaquePointer? = nil
        do{
            if sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var categorias  = Category(idcategory: 0, namecategory: "")
                    
                    categorias.idcategory = Int(sqlite3_column_int(statement, 0))
                    categorias.namecategory = String(cString: sqlite3_column_text(statement, 1)!)
                    result.Objects?.append(categorias)
                }
                result.Correct = true
            }
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
            
        }
        return result
    }
    func addtask(task : Tasck )->Result{
        var result = Result()
        let context  = DB.init()
        let query = "INSERT INTO Tarea(Name, HoraInicio, HoraTermino, IdCategoria, Fecha) VALUES(?, ?, ?, ?, ?)"
        var statementx  : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statementx, nil) == SQLITE_OK{
                sqlite3_bind_text(statementx, 1, (task.Name as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statementx, 2, (task.HoraInicio as NSString).utf8String, -1, nil)
                sqlite3_bind_text(statementx, 3, (task.HoraTermino as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statementx, 4, Int32(task.IdCategori))
                sqlite3_bind_text(statementx, 5, (task.Fecha as NSString).utf8String, -1, nil)
                
                if sqlite3_step(statementx) == SQLITE_DONE{
                    result.Correct = true
                }
                else{
                    result.Correct = false
                }
            }
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
    
   func gettaskbyid(idtask : Int)-> Result{
       var result = Result()
       let context = DB.init()
       let query = "Select IdBalance, Name, HoraInicio, HoraTermino, IdCategoria, Fecha FROM Tarea WHERE (IdBalance = \(idtask))"
       var statement : OpaquePointer? = nil
       do{
           if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
               while sqlite3_step(statement) == SQLITE_ROW{
                   var task = Tasck(idtask: 0, Name: "", HoraInicio: "", HoraTermino: "", IdCategori: 0, Fecha: "")
                   task.idtask = Int(sqlite3_column_int(statement, 0))
                   task.Name = String(cString:  sqlite3_column_text(statement, 1))
                   task.HoraInicio = String(cString: sqlite3_column_text(statement, 2))
                   task.HoraTermino = String(cString: sqlite3_column_text(statement, 3))
                   task.IdCategori = Int(sqlite3_column_int(statement, 4))
                   task.Fecha = String(cString: sqlite3_column_text(statement, 5))
                   result.Object = task
               }
               result.Correct = true
           }
       }
       catch let error{
           result.Correct = false
           result.ErrorMessage = error.localizedDescription
           result.Ex = error
       }
       return result
    }
    func gettaskbyday(fecha : String) -> Result{
        var result = Result()
        let context = DB.init()
        let query = "Select IdBalance, Name, HoraInicio, HoraTermino, IdCategoria, Fecha FROM Tarea WHERE (fecha = '\(fecha)')"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var task = Tasck(idtask: 0, Name: "", HoraInicio: "", HoraTermino: "", IdCategori: 0, Fecha: "")
                    task.idtask = Int(sqlite3_column_int(statement, 0))
                    task.idtask = Int(sqlite3_column_int(statement, 0))
                    task.Name = String(cString: sqlite3_column_text(statement, 1))
                    task.HoraInicio = String(cString: sqlite3_column_text(statement, 2))
                    task.HoraTermino = String(cString: sqlite3_column_text(statement, 3))
                    task.IdCategori = Int(sqlite3_column_int(statement, 4))
                    task.Fecha = String(cString: sqlite3_column_text(statement, 5))
                    result.Objects?.append(task)
                }
                result.Correct = true
            }
        }
        catch let error{
            result.Correct = false
            result.ErrorMessage = error.localizedDescription
            result.Ex = error
        }
        return result
    }
}
