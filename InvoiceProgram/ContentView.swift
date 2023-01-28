//
//  ContentView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import SwiftUI
import Firebase

struct ContentView: View {
    //var db = Firestore.firestore()
    // @State var invoices = [Invoice]()
  // @State var invoice =  [Invoice]()
   @State var invoice = [Invoice]()
   
    @State var dateString = ""
    init() {
        
          invoice.append(Invoice(name: "Ernesto",companyName: "DreamIt" , organizationNumber: 555263501,invoiceNummer: 1111 , CompanyAdres: "Sunneplan12",  date: Date.now , vat: 841206065201, amount: 100000.00 ))
        
        //invoice.append(Invoice(organizationNumber: "5555555"))
        //invoice.append(Invoice(companyName: "DreamIT"))
    }

    var body: some View{
        VStack(alignment: .leading){
            HStack{
                
                
                Text("DreamIT")
                    .foregroundColor(.orange)
                    .font(.system(size: 25 ,weight: .bold,design: .rounded))
                    .padding()
                    .background(Color.black)
                
              
                
                
            }
            HStack(alignment: .center){
            Text("Fakturera utan eget företag")
                .font(.subheadline)
                .foregroundColor(.orange)
                .font(.system(size: 25 ,weight: .bold,design: .rounded))
               .background(Color.black)
        }
           
            HStack{
                Text("Fakturanummer:")
                    .foregroundColor(.orange)
                Text("1111")
                    .foregroundColor(.purple)
            }
        
               
                Text("Faktura Datum: ")
                .foregroundColor(.orange)
                Text("2023-01-26")
                .foregroundColor(.purple)
               
               
            
          //  Text("Belopp")
            //    .foregroundColor(.orange)
            //Text("100000")
              //  .foregroundColor(.purple)
        }
        //.background(Color.black)
        .padding()
        .cornerRadius(20)
        .frame(width: 360,height: 150)
        
        HStack{
            
            
           /* VStack { List (invoice){ invoices in
                Text("företagsnamn:" + invoices.name)
                Text("namn på ägare:  " + invoices.companyName)
                Text("Orginisationsnummer:    \(invoices.organizationNumber) ")
                Text("Fakturanummer   \(invoices.invoiceNummer)")
                Text("momsnummer  \(invoices.vat)" )
                Text(invoices.CompanyAdres)
            }
                
            }*/
            
            
            
        }.onAppear()
        }
    
    
  
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
    
    
   /* func saveToFirestore(invoiceName: String) {
        let invoice = Invoice(name: invoiceName)
        do{
            _ = try   db.collection("invoices").addDocument(from: invoice)
        }catch{
            print("Error saving to DB")
        }
    }
    func listenToFirestore(){
        db.collection("invocies").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
               // invoices.removeAll()
                for document in snapshot.documents {

                    let result = Result {
                        try document.data(as: Invoice.self)
                    }
                    switch result  {
                    case .success(let invoice)  :
                        invoices.append(invoice)
                    case .failure(let error) :
                        print("Error decoding invoice: \(error)")
                    }
                }
            }
        }
        
    }*/
    
