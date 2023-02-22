//
//  NewClientView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-15.
//
import Foundation
import SwiftUI
import Firebase

 var clientAddress = ""
 var clientYourRefName = ""
 var organizationNumber = 0
var vatNumber = 0
var clientName = ""


struct NewClientView: View {
    @State var clients =  [Client]()
    var db = Firestore.firestore()
    
    @State var client: Client?
    var body: some View {
        VStack{
            
            
            /*.ignoresSafeArea()
             .frame(width: 80, height: 500)
             .rotationEffect(.degrees(690))
             .offset(y:2)
             */
            
            NavigationView{
                
                
                
                List{
                    ForEach(clients) { client in
                        NavigationLink( destination: clientDetailsView(client: client)){
                            Text(client.name ?? "")
                            
                            
                            
                        }
                        
                        .padding(20)
                        .ignoresSafeArea()
                        .background(
                            
                            RoundedRectangle(cornerRadius: 30,style: .continuous)
                            
                                .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)))
                    }
                    
                }
                .navigationBarItems(trailing: NavigationLink(destination: CreateClientView()){
                    // circlenavigationCrateClient(color: .black, navigationText: "Ny kund")
                    Image(systemName: "person.3.sequence.fill")
                        .foregroundColor(.green)
                        .padding()
                        .ignoresSafeArea()
                })
                
                
                
                
                
                
                
                
                
                
                
            }
            .onAppear{
                getChosenClient()
                listenToClientInFirestore()
                
                
            }
        }
    }
    struct clientDetailsView: View {
        var client: Client
        var body: some View {
            Form{
                Text("FÖRETAG" + " \(client.name ?? "")")
                    .foregroundColor(.black)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 30,style: .continuous)
                        
                            .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)))
                
                Text("FÖRETAG ADRESS" + " \(client.CompanyAdres ?? "")")
                    .foregroundColor(.black)
                Text("REFERENS" + " \(client.referens ?? "")")
                    .foregroundColor(.black)
                Text("ORGNUMMER" + " \(client.organizationNumber ?? "")")
                    .foregroundColor(.black)
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
    func listenToClientInFirestore() {
        
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
    
 
}
            
    struct CreateClientView: View{
        var db = Firestore.firestore()
        
        @State var clientName = ""
        @State var clientAddress = ""
        @State var clientYourRefName = ""
        @State  var organizationNumber = ""
        @State var vatNumber = ""
        
        var body: some View{
            
            ZStack(){
                Color.black
                    .ignoresSafeArea()
                    .frame(width: 40, height: 1000)
                    .rotationEffect(.degrees(690))
                    .offset(y:2)
                    .padding()
                
                    .background(
                        
                        RoundedRectangle(cornerRadius: 20,style: .continuous)
                        
                            .foregroundStyle(.linearGradient(colors: [.orange.opacity(0.2), .red.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing)))
                
                VStack{
                    
                    TextField("kund ",text: $clientName)
                        .padding()
                        .background(  RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.orange.opacity(0.3), .red.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)))
                        .foregroundColor(.black)
                        .bold()
                        .font(.headline)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    
                    
                    TextField("Adress", text: $clientAddress)
                        .padding()
                        .background(  RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.orange.opacity(0.3), .red.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)))
                        .foregroundColor(.black)
                        .bold()
                        .font(.headline)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Referens", text: $clientYourRefName)
                        .padding()
                        .background(  RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.orange.opacity(0.3), .red.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)))
                        .foregroundColor(.black)
                        .bold()
                        .font(.headline)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Orgnummer", text: $organizationNumber)
                        .padding()
                        .background(  RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.orange.opacity(0.3), .red.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)))
                        .foregroundColor(.yellow)
                        .bold()
                        .font(.headline)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    TextField("Momsnummer", text: $vatNumber)
                        .padding()
                        .background(  RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .foregroundStyle(.linearGradient(colors: [.orange.opacity(0.3), .red.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)))
                        .foregroundColor(.black)
                        .bold()
                        .font(.headline)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    
                    Button(action:{
                        addNewClient()
                        /*   clientName = ""
                         vatNumber = ""
                         clientAddress = ""
                         clientYourRefName = ""
                         organizationNumber = ""*/
                        makeEmptyString()
                    },
                           label: {Text("Spara Kund".uppercased())
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)))
                            .font(.headline)
                    })
                    
                    
                }
            }
            .ignoresSafeArea()
            
        }
        
        
        func addNewClient() {
            
            let client = Client( name: clientName, organizationNumber: organizationNumber, CompanyAdres: clientAddress, vat: vatNumber, referens: clientYourRefName)
            
            
            
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
    
    
    struct NewCientView_Previews: PreviewProvider {
        static var previews: some View {
            NewClientView( client: Client())
        }
    }
    
    
    
    /*
     Color.black
     .ignoresSafeArea()
     .frame(width: 80, height: 1000)
     .rotationEffect(.degrees(690))
     .offset(y:2)
     .padding()
     
     .background(
     
     RoundedRectangle(cornerRadius: 30,style: .continuous)
     
     .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing)))*/
    
    
    
    
    //.navigationBarItems(trailing:
    //                      NavigationLink(destination: CreateClientView()){
    //})
    
    /*   Circle()
     .fill(LinearGradient(gradient: Gradient(colors: [.black, .orange,.white]), startPoint: .leading, endPoint: .trailing)) as! Circle
     Text("NY KUND")
     .foregroundColor(.white)
     .font(.system(size: 25))
     .bold()
     
     
     .frame(width: 150, height: 150)
     
     
     })*/


    
        struct circlenavigationCrateClient: View{
            var color: Color
            var navigationText: String
            var body: some View{
                ZStack {
                    Circle()
                        .frame(width: 50, height: 60)
                        .foregroundColor(color)
                        .padding(40)
                        .ignoresSafeArea()
                    
                    Text("NY KUND")
                        .foregroundColor(.white)
                        .font(.system(size: 10,weight: .bold))
                        .bold()
                }
                
                
                
                
            }
        }
