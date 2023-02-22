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
    @State var jobAssignment = ""
    @State var workedHour = ""
    @State var reference = ""
    @State var invoiceAmount = ""
    @State var lastInvoicePayDate = Date()
    @State var invoices =  [Invoice]()
    @State var invoice : Invoice?
    @State var users =  [User]()
    @State var client: Client?
    @State var clients =  [Client]()
    @State var user : User
    @State var clientName = ""
    
   
    var body: some View
    {
        Section(header: Text("Faktura uppgifter")){
            
            Form{
                DatePicker("Förfallodag", selection: $lastInvoicePayDate,  displayedComponents: .date)
                TextField("Kund", text: $clientName)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                TextField("Faktura belopp", text: $invoiceAmount)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                TextField("UPPDRAG", text: $jobAssignment)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                TextField("ANTAL TIM", text: $workedHour)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                TextField("REFERENS", text: $reference)
                    .font(.largeTitle)
                    .foregroundColor(.black)
            }
        }
        
        
        
        //  TextField("Belopp", text: $createNewInvoice)
        Button{
           let invoiceAmountDouble = Double(invoiceAmount)
            getChosenClient()
            addNewInvoice(invoiceAmount: invoiceAmountDouble ?? 0.0,
                          cli: Client( name: clientName, organizationNumber: client?.organizationNumber, CompanyAdres: client?.CompanyAdres, vat: client?.vat, personalId: client?.personalId, referens: client?.referens),
                          user:User(email: user.email), 
                                     lastPayDate: lastInvoicePayDate)
            //newInvoiceNummer()
        } label: {
            
            
            Text("Spara Faktura")
                .foregroundColor(.black)
                .background(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding()
        }
        
        }
    func addNewInvoice(invoiceAmount: Double ,cli : Client,user : User, lastPayDate : Date) {
            
            var date: String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.string(from: Date())}

        getLastInvoiceNumber { newInvoiceNumber in
            let invoice = Invoice(client: cli,user: user ,invoiceNummer: newInvoiceNumber,date: date, lastPayDate: lastPayDate, amount: invoiceAmount)
            
            do{
                _ = try    db.collection("invoices").addDocument(from: invoice)
                
            }catch {
                print("Error saving to DB")
            }
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
    func getLastInvoiceNumber(completion: @escaping (Int) -> Void) {
        db.collection("invoices")
            .order(by: "invoiceNummer", descending: true)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error getting last invoice number: \(error)")
                    completion(0)
                } else {
                    let lastInvoiceNumber = snapshot?.documents.first?.data()["invoiceNummer"] as? Int ?? 0
                    completion(lastInvoiceNumber + 1)
                }
            }
    }

}



/*struct NewInvoice_Previews: PreviewProvider {
    static var previews: some View {
        NewInvoice()
    }
    
}*/
