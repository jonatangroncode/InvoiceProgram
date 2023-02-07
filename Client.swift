//
//  Client.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-31.

//  Created by Ernesto Carocca on 2023-01-18.
//

import Foundation
import FirebaseFirestoreSwift
struct Client : Codable,Identifiable  {
    @DocumentID  var id : String?
    var name : String
    var organizationNumber : Int = 0
    var CompanyAdres : String?
    var vat : Int = 0
    var personalId :Int? = nil
    
    }
    
    

    
//}

