//
//  Invoice.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import Foundation

import FirebaseFirestoreSwift

struct Invoice : Codable, Identifiable  {
    @DocumentID   var id : String?
    var name : String
    var company : Company
    var client : Client
    var user : User
    var invoiceNummer : Int
    var CompanyAdres : String?
    var date : Date = Date()
    var vat : Int = 0
    var amount: Double?
 //   var total : Double {
        //return amount? * 1.25
    }
    
    
    
//}

