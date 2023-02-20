//
//  InvoiceDetails.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-09.
//

import SwiftUI

struct InvoiceDetails: View  {
    var invoice: Invoice
    
    var body: some View {
   
        VStack( alignment: .leading){
            Color.black
            Text("Dreamit")
                .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding(40)
                .font(.caption)
                
                    .offset(y:-400)

            HStack{
              //  Text("faktura datum" + "\(invoice.date)")
                Text("funk")
                    .foregroundColor(.white)
                
                    .font(.caption)
                    .padding()
                    .foregroundColor(.white)
                    .offset(y:-600)
               }
          
            }
        .padding()
        .background(Color.black)
        
            
            
            
            
        }
        
    }


/*
 Text(invoice.name )
 Text("\(invoice.total) " + "kr")
 Text(" fakturanamn : " + invoice.name)
 Text(" faktura belopp ex moms : \(invoice.amount) " + "kr")
 Text("faktura belopp ink moms: \(invoice.total) " + "kr")
 Text(" Kund: " + "\(invoice.client?.name ?? "")")
 Text(" Referens:" +  "\(invoice.client?.referens ?? "")")
 Text(" Adress:" + "\(invoice.client?.CompanyAdres ?? "")")
 Text(" Orgnr :" + "\(invoice.client?.organizationNumber ?? "")")
 */

