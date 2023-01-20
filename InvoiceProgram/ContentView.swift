//
//  ContentView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import SwiftUI
import Firebase

struct ContentView: View {
 var db = Firestore.firestore()
 @State var invoices = [Invoice]()
@State var newInvoiceName = ""
    
    
    var body: some View {
        VStack {
            List{
                ForEach(invoices) { invoice in
                    Text(invoice.name)
                }
            }
            
        }.onAppear(){
           listenToFirestore()
        }
        .padding()
        
    }
    
    func saveToFirestore(invoiceName: String) {
       // let invoice = Invoice(name: invoiceName)
        db.collection("invoices").addDocument(data: ["name" : invoiceName, "categori" : "", "done" :  false])
    }
    func listenToFirestore(){
        db.collection("invoices").addSnapshotListener {snapshot ,err in
            guard let snapshot = snapshot else {return}
            if let err = err {
                print("Error getting document \(err)")
                   
                } else {
                    
                    for document in snapshot.documents {
                       let invoice = Invoice(id:document.documentID,
                                                            name:document["name"] as! String,
                                                                catergory: document ["categori"] as! String,
                                                                done: document["done"] as! Bool)
                        
                        invoices.append(invoice)
                        }
                    }
                }
            }
            
        }




