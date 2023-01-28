//
//  Invoice.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import Foundation

import FirebaseFirestoreSwift
struct Invoice : Codable, Identifiable {
    var id = UUID()
    var name : String
    var companyName : String
    var organizationNumber : Int = 0
    var invoiceNummer : Int = 0
    var CompanyAdres : String
    var date : Date
    var vat : Int = 0
    var amount: Double
    //var total : Double {
      //  return amount * 1.25
    //}
    
    

    
}

