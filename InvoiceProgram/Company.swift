//
//  Company.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-31.
//

import Foundation
import FirebaseFirestoreSwift

struct Company : Codable  {
    
    var name : String
    var organizationNumber : Int
    var CompanyAddress : String
    var vatNumber : Int
    var ourReference : String
    }
    
    

    



