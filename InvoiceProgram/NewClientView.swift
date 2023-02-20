//
//  NewClientView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-15.
//

import SwiftUI
import Firebase
var clientName = ""
 var clientAddress = ""
 var clientYourRefName = ""
 var organizationNumber = 0
var vatNumber = 0
struct NewClientView: View {
    
    
    var body: some View {
        
        NavigationView{
        
            VStack{
               
                NavigationLink("SKAPA EN KUND", destination: CreateClientView())
                
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 300, height: 100)
                
                    .background(
                       
                        RoundedRectangle(cornerRadius: 30,style: .continuous)
                        
                            .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)))
                
            }
        
        }
    }
    
}
struct CreateClientView: View{
    var db = Firestore.firestore()
    
    @State var clientName = ""
    @State var clientAddress = ""
    @State var clientYourRefName = ""
    @State  var organizationNumber = ""
    @State var vatNumber = ""

    var body: some View{
     
        VStack{
            TextField("Kund", text: $clientName)
                .font(.largeTitle)
                .foregroundColor(.black)
            TextField("Adress", text: $clientAddress)
                .font(.largeTitle)
                .foregroundColor(.black)
            TextField("Referens", text: $clientYourRefName)
                .font(.largeTitle)
                .foregroundColor(.black)
            TextField("Orgnummer", text: $organizationNumber)
                .font(.largeTitle)
                .foregroundColor(.black)
            TextField("Momsnummer", text: $vatNumber)
                .font(.largeTitle)
                .foregroundColor(.black)
            
        }
        Button(action:{
            addNewClient()
         /*   clientName = ""
            vatNumber = ""
            clientAddress = ""
            clientYourRefName = ""
            organizationNumber = ""*/
            makeEmptyString()
        },
               label: {Text("Spara Kund")
        } ) }
               
    
    func addNewClient() {
    
        let client = Client( name: clientName, organizationNumber: organizationNumber, CompanyAdres: clientAddress, vat: vatNumber, referens: clientYourRefName)
        
       // var newList = user.invoices
        //newList.append(invoice)
        //user.invoices = newList
        
        do{
            _ = try    db.collection("clients").addDocument(from: client)
            
        }catch {
            print("Error saving to DB")
        }
        
    }
    func makeEmptyString() {
        clientName = ""
        vatNumber = ""
        clientAddress = ""
        clientYourRefName = ""
        organizationNumber = ""
        
    }
    
}

struct NewClientView_Previews: PreviewProvider {
    static var previews: some View {
        NewClientView()
    }
}
