//
//  DB.swift
//  JAngeltodoList
//
//  Created by MacBookMBA6 on 03/04/23.
//

import Foundation

import SQLite3
class DB{
    let path = "Document.JAngelExpense.sql"
    var  db : OpaquePointer? = nil
    
    init() {
        db = OpenConexion()
    }
    func OpenConexion() -> OpaquePointer? {
//        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
        
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(self.path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) == SQLITE_OK
        {
            print("Conexion Correcta")
            print( filePath.path())
           
          
            let createtableCategoriasQuery = "CREATE TABLE IF NOT EXISTS Categorias (IdCategoria INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, NameCategoria TEXT UNIQUE)"
          
            let createtabletareas = "CREATE TABLE IF NOT EXISTS Tarea(IdBalance INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Completado INTEGER, Name TEXT, HoraInicio TEXT, HoraTermino TEXT, IdCategoria INTEGER, Fecha TEXT, FOREIGN KEY (IdCategoria) REFERENCES Categorias(IdCategoria))"
                        
            
            if sqlite3_exec(db, createtableCategoriasQuery, nil, nil, nil) != SQLITE_OK{
                print("error al crear la base de datos")
            }
         
                
            if sqlite3_exec(db, createtabletareas, nil, nil, nil) != SQLITE_OK{
                print("error al crear la base de datos")
            }
            
            
            else{
                print("Everything is fine")
            }
            return db

        }
        else{
            print("Error")
            print(NSLog("Failed to create table: %s", sqlite3_errmsg(db))
)
            return nil
        }
      
    }
    
    
}
