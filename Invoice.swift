//
//  Invoice.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import Foundation

import FirebaseFirestoreSwift
struct Invoice : Codable, Identifiable {
    
    
    var id = String()
    var name : String
    var catergory : String = " "
    var done : Bool = false
}
