//
//  InvoiceDetails.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-09.
//

import SwiftUI

struct InvoiceDetails: View  {
    var invoice: Invoice
    let dateFormatter = DateFormatter()
    
    var body: some View {
        let lastPayDayString = convertDateToString(invoice.lastPayDate)
        
        VStack{
            VStack{ Color.black
                Text("DreamIT")
                    .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
            }
                .offset(y: -150)
                .font(.system(size: 35 ,weight: .bold))
                .bold()
                .padding()
            
                VStack{
                    VStack{
                        
                        Text("FAKTURA")
                            
                        Text("Kund:" + "\(invoice.client?.name ?? "")" )
                            .foregroundColor(.blue)
                        
                        Text("faktura datum" + "\(invoice.date)")
                            .foregroundColor(.white)
                    }
                        .bold()
                        .padding()
                        .foregroundColor(.white)
                   
                    VStack{
                        Text("Moms" + " \(invoice.total - invoice.amount)" +  " kr")
                        Text("ink moms " + "\(invoice.amount) " +  "  kr")
                        
                    }
                        .bold()
                        .foregroundColor(.white)
                        
                    VStack{
                        Text("FÖRFALLO DATUM" + lastPayDayString )
                            .foregroundColor(.black)
                    }
                     
                  
                }
                
            
           // .cornerRadius(30)
            //.background(Color.green)
            .foregroundColor(.white)
            .bold()
            .padding()
            .frame(width: 380, height: 180)
            .font(.system(size: 20 ,weight: .bold))
              
            .background(
          
            RoundedRectangle(cornerRadius: 30,style: .continuous)
            
            .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)))
           
            .offset(y: -150)
            
                  
            VStack{
                Text("FAKTURA TEXT")
                    .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .bold()
                    .padding()
                    .font(.system(size: 15 ,weight: .bold))
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                    .padding()
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                    .padding()
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                    .padding()
                
                    
            }
            .offset(y: -100)
            Spacer()
            
            VStack{
                  
                Text(" BELOPP ATT BETALA:" + "\(invoice.total)" + "kr")
                    .foregroundColor(.green)
                        .bold()
                        .frame(width:350, height: 50)
                        .font(.system(size: 15 ,weight: .bold))
                        .background(
                            
                            
                        RoundedRectangle(cornerRadius: 30,style: .continuous)
                        
                        .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)))
                }
                
            .padding()
          
            
            }
        
        .padding()
        .background(Color.black)
        .ignoresSafeArea()
            
            
            
            
        }
    
        
    }
func convertDateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
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
/*
struct InvoiceDetails_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceDetails(invoice: Invoice(user: User(email: "email", invoices: [Invoice]() ), date: "", lastPayDate: "", amount: 0.0))
    }
}
*/
