//
//  ContentView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import SwiftUI
import Firebase
//import FirebaseAuth



struct ContentView: View {
    //  var db = Firestore.firestore()
    
    
    
    @State var email = ""
    @State  var password = ""
    @State private var userIslogggedIn = false
    //@State var dateString = ""
    
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.black
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 600, height: 1000)
                    .rotationEffect(.degrees(650))
                    .offset(y:-350)
                
                    .navigationBarItems(trailing: NavigationLink(destination:InvoicesView()){
                        Text("Logga In")
                    })
                
                VStack(spacing: 20){
                    Text("Välkommen")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(y: -70)
                    
                    
                    
                    Text("Början till att äga din dröm")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .offset(y: -100)
                    
                    TextField("email",text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty){
                            Text("Email")
                                .foregroundColor(.white)
                                .bold()
                            
                        }
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("password",text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty){
                            Text("Lösenord")
                                .foregroundColor(.white)
                                .bold()
                        }
                    
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    Button { register()
                    }label: {
                        Text("Registrera dig här!")
                            .bold()
                            .frame(width: 200, height: 40)
                        
                            .background(
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.linearGradient(colors: [.blue , .black], startPoint: .top, endPoint: .bottomTrailing))
                                
                            )
                    }
                    .padding(.top)
                    .offset(y:50)
                    Button{
                        login()
                    }label: {
                        Text("Är du redan en användare? Logga in här")
                            .bold()
                            .foregroundColor(.white)
                            .padding(-40)
                    }
                    
                    .ignoresSafeArea()
                    
                    
                    Text( "DreamIT to liv IT")
                        .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .offset(y: 130)
                        .frame(alignment: .center)
                        .padding()
                    
                }
                
                .frame(width:350, height: 1)
                .foregroundColor(.white)
                
            }
            
            
            .frame(width: 50)
            
            .onAppear(){
                
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIslogggedIn.toggle()
                    }
                }
            }
            
        }
        .ignoresSafeArea()
    }
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            
        }
    }
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
        
    }
    
    
    
    
    struct userLogIn:View {
        var body: some View {
            
            Text("Logga in ")
                .font(.system(size: 30,weight: .heavy))
                .frame(width: 200,height: 50,
                       alignment: .center)
                .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .padding()
                .ignoresSafeArea()
        }
    }
    
    struct InvoicesView: View {
        var db = Firestore.firestore()
        @State var invoices =  [Invoice]()
        
        
        
        var body: some View {
            
            
            
            VStack(alignment: .leading){
                
                //  RoundedRectangle(cornerRadius: 50, style: .circular)
                
                /*  if(!invoices.isEmpty){
                 Text(invoices[0].company.name)
                 .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                 .font(.system(size: 20, weight: .bold, design: .rounded))
                 .offset(y: -500)
                 .frame(alignment: .center)
                 
                 
                 
                 
                 }
                 */
                NavigationView{
                    List(invoices) { invoice in
                        Text("Fakturanummer \(invoice.invoiceNummer)")
                    }
                    .navigationTitle("faktura")
                    .navigationBarItems(trailing: Button(action: { //add
                    },label:{ Image(systemName: "plus")
                        
                    }))
                }
                
                
                
                
                
                .padding()
                .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .background(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                
                .navigationTitle("Fakturor")
                
                
                
                .onAppear(){
                    
                    
                    let company =   Company(name: "DreamIt", organizationNumber: 555, CompanyAddress: "Sunneplan12", vatNumber: 55501, ourReference: "Ernesto")
                    
                    let user = User(name: "Leandro", surname: "abduka", personalId: 1984, profession: "smart", email: " lea@samrt.se")
                    
                    let client = Client(name: "kth", organizationNumber: 5511)
                    
                    // saveToFirestore(invoiceName: client.name, comp: company, cli: client, user: user, invoiceNr: 506, currentDate: Date.now)
                    
                    listenToFirestore()
                    
                    
                }
            }
        }
        func saveToFirestore(invoiceName: String,comp : Company ,cli : Client,user : User, invoiceNr : Int, currentDate: Date) {
            let invoice = Invoice(name: invoiceName, company: comp, client: cli,user: user ,invoiceNummer: invoiceNr , date: currentDate)
            
            do{
                _ = try    db.collection("invoices").addDocument(from: invoice)
                
            }catch {
                print("Error saving to DB")
            }
            
        }
        
        
        func listenToFirestore() {
            db.collection("invoices").addSnapshotListener { snapshot, err in
                guard let snapshot = snapshot else {return}
                
                if let err = err {
                    print("Error getting document \(err)")
                } else {
                    invoices.removeAll()
                    for document in snapshot.documents {
                        
                        let result = Result {
                            try document.data(as: Invoice.self)
                        }
                        switch result  {
                        case .success(let invoice)  :
                            invoices.append(invoice)
                        case .failure(let error) :
                            print("Error decoding item: \(error)")
                        }
                    }
                }
            }
        }
    }
    
}
        
        extension View {
            func placeholder<Content:View>(
                when shouldShow: Bool,
                alignment: Alignment = .leading,
                @ViewBuilder placeholder: () -> Content) -> some View {
                    
                    ZStack(alignment: alignment) {
                        placeholder().opacity(shouldShow ? 1 : 0)
                        self
                        
                    }
                }
        }
    
    
    
    
    
    
    
    
        struct ContentView_Previews: PreviewProvider {
         static var previews: some View {
          ContentView()
      }
    }
    
    
    
    

