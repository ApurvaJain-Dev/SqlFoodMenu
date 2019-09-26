//
//  DatabaseLibrary.swift
//  SQLITEmachineTest1
//
//  Created by admin on 9/26/19.
//  Copyright © 2019 apurva. All rights reserved.
//

import Foundation
import SQLite3

class DatabaseLibrary
{
    
    var foodPrice = [String]()
    var foodName = [String]()
    static let sharedObject = DatabaseLibrary()
    //Creating database for food menu
    func databasePath() -> String
    {
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = dir.first!
        return path+"/foodMenuDatabase.sqlite"
    }
    
    //
    func executeQuery(query: String) -> Bool
    {
        let dbPath = databasePath()
        var db: OpaquePointer? = nil
        var stmt: OpaquePointer? = nil
        var success: Bool = false
        if sqlite3_open(dbPath, &db) == SQLITE_OK
        {
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK
            {
                if sqlite3_step(stmt) == SQLITE_DONE
                {
                    success = true
                }
                else
                {
                    print("Error is stop:\(sqlite3_errmsg(stmt!))")
                }
            }
            else
            {
                print("Error is prepare:\(sqlite3_errmsg(stmt))")
            }
        }
        else
        {
            print("Error in open:\(sqlite3_errmsg(stmt!))")
        }
        return success
    }
    
    func selectAllTask(query: String)
    {
        let dbPath = databasePath()
        var db: OpaquePointer? = nil
        var stmt: OpaquePointer? = nil
        
        if sqlite3_open(dbPath, &db) == SQLITE_OK
        {
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK
            {
                foodName.removeAll()
                foodPrice.removeAll()
                while sqlite3_step(stmt) == SQLITE_ROW
                {
                    let fName = sqlite3_column_text(stmt, 0)
                    let fooName = String(cString: fName!)
                    foodName.append(fooName)
                    let fPrice = sqlite3_column_text(stmt, 1)
                    let fooPrice = String(cString: fPrice!)
                    foodPrice.append(fooPrice)
                }
            }
            else
            {
                print("Error is prepare: \(sqlite3_errmsg(stmt!))")
            }
        }
        else
        {
            print("Error in open: \(sqlite3_errmsg(stmt!))")
        }
    }
    
    
    // creting table for our database
    func createTable() {
        
        let createQuery = "create table if not exists menuTable(foodName text, foodPrice text)"
        let isSuccess = executeQuery(query: createQuery)
        if isSuccess {
            print("table created successfully")
        }
        else
        {
            print("table creation failed")
        }
        }
    
    
}
