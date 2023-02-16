//
//  User.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-31.
//

import Foundation


import FirebaseFirestoreSwift

struct User : Codable,Identifiable {
    
    @DocumentID   var id : String?
    var name : String?
    var surname : String?
    var personalId :Int?
    var address : String?
    var profession : String?
    var email : String
    var invoices: [Invoice] = []
   
    
    }
    
    
