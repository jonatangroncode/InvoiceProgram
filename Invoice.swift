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
    var name : String?
    var company : Company?
    var client : Client?
    var user : User
    var invoiceNummer : Int = 0
    var CompanyAdres : String?
    var vat : Int = 0
    var date : String
    var lastPayDate : Date
    var amount:  Double
    var total : Double {
    return amount * 1.25
}
    
    
    
}

