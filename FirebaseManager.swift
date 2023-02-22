//
//  Firebase.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-14.
//
/*
class FirebaseManager: ObservableObject {
    
    @State private var clientName = ""
    @State private var nameInvoice = ""
    @State private var invoiceNummerCounter = 0
    @Published var invoices = [Invoice]()
    @Published var invoice : Invoice?
    @Published var user: User
    @State var users =  [User]()
    @Published var client: Client?
    @Published var clients =  [Client]()

    init(clientName: String = "", nameInvoice: String = "", invoiceNummerCounter: Int = 0, invoices: [Invoice] , invoice: Invoice? , user: User, users: [User], client: Client?, clients: [Client] ) {
        self.clientName = clientName
        self.nameInvoice = nameInvoice
        self.invoiceNummerCounter = invoiceNummerCounter
        self.invoices = invoices
        self.invoice = invoice
        self.user = user
        self.users = users
        self.client = client
        self.clients = clients
    }
    
  
 
    func listenToUserInFirestore() {
        var db = Firestore.firestore()
        db.collection("users").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                self.users.removeAll()
                for document in snapshot.documents {
                    
                    print(document)
                    let result = Result {
                        try document.data(as: User.self)
                        
                    }
                    switch result  {
                    case .success(let user)  :
                        self.users.append(user)
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
        var db = Firestore.firestore()
        db.collection("clients").addSnapshotListener { snapshot, err in
            guard let snapshot = snapshot else {return}
            
            if let err = err {
                print("Error getting document \(err)")
            } else {
                self.clients.removeAll()
                for document in snapshot.documents {
                    
                    print(document)
                    let result = Result {
                        try document.data(as: Client.self)
                        
                    }
                    switch result  {
                    case .success(let client)  :
                        self.clients.append(client)
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
                print(client.name ?? "")
                print(client.name ?? "")
                self.client = client
                
                
            }
        }
            
    }
    
    }
    
    */

    
    

