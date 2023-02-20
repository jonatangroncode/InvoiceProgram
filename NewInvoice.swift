//
//  NewInvoice.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-09.
//

import SwiftUI
import Firebase
struct NewInvoice: View {
    var db = Firestore.firestore()
    // @State var invoices =  [Invoice]()
    @State private var clientName = ""
    @State private var nameInvoice = ""
    @State private var invoiceNummerCounter = 0
    @State var invoices =  [Invoice]()
    @State var invoice : Invoice?
    @State var user: User
    @State var users =  [User]()
    @State var client: Client
    @State var clients =  [Client]()
    var body: some View {
        TextField("Kund", text: $clientName)
            .font(.largeTitle)
            .foregroundColor(.black)
        TextField("faktura namn", text: $nameInvoice)
            .font(.largeTitle)
            .foregroundColor(.black)
        
        
        
        //  TextField("Belopp", text: $createNewInvoice)
        Button{
            getChosenClient()
            addNewInvoice(invoiceName: nameInvoice,
                          cli: Client( name: client.name, organizationNumber: client.organizationNumber, CompanyAdres: client.CompanyAdres, vat: client.vat, personalId: client.personalId, referens: client.referens),
                          user:User(email: user.email),
                          invoiceNr: .random(in: 1...100) )
            //newInvoiceNummer()
        } label: {
            Text("Spara Faktura")
                .foregroundColor(.black)
                .background(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding()
        }
        .onAppear{
            
            listenToUserInFirestore()
            listenToClientInFirestore()
         
        }
        }
        func addNewInvoice(invoiceName: String, cli : Client,user : User, invoiceNr : Int) {
            
            var date: String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.string(from: Date())}
            let invoice = Invoice(name: invoiceName, client: cli,user: user ,invoiceNummer: invoiceNr,date: date)
            
            do{
                _ = try    db.collection("invoices").addDocument(from: invoice)
                
            }catch {
                print("Error saving to DB")
            }
            
        }
    
        
        func listenToUserInFirestore()  {
            
            db.collection("users").addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                
                if let err = err {
                    print("Error getting document \(err)")
                } else {
                    users.removeAll()
                    for document in snapshot.documents {
                        
                        print(document)
                        let result = Result {
                            try document.data(as: User.self)
                            
                        }
                        switch result  {
                        case .success(let user)  :
                            users.append(user)
                            print(user)
                            print("added to  list")
                        case .failure(let error) :
                            print("Error decoding item: \(error)")
                        }
                        
                    }
                    
                }
            }
            
        }
        func listenToClientInFirestore()  {
            
            db.collection("clients").addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                
                if let err = err {
                    print("Error getting document \(err)")
                } else {
                    clients.removeAll()
                    for document in snapshot.documents {
                        
                        print(document)
                        let result = Result {
                            try document.data(as: Client.self)
                            
                        }
                        switch result  {
                        case .success(let client)  :
                            clients.append(client)
                        case .failure(let error) :
                            print("Error decoding item: \(error)")
                        }
                        
                    }
                    
                }
            }
            
        }
    
    
    func getChosenClient(){
      
        for client in clients {
         //   print(user.email)
           // print(email)
            if(client.name == clientName){
                print("hittade!!")
                print(client.name ?? "")
                self.client = client
                
                    
            }
        }
       
    }
}



/*struct NewInvoice_Previews: PreviewProvider {
    static var previews: some View {
        NewInvoice()
    }
    
}*/
