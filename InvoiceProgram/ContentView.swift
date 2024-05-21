//
//  ContentView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.

import PDFKit
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation


var email = "" 
struct ContentView: View {
    
    
    @State private var CreateAnInvoiceitem = "contextualmenu.and.cursorarrow.fill"
    @EnvironmentObject var viewLoginUser: LoginUser
    @State  var password = ""
    @State private var userIslogggedIn = false
    @State var user : User?
    var db = Firestore.firestore()
    @State var users =  [User]()
    
    
    
    var body: some View {
        
        NavigationView{
            
            ZStack{
                if viewLoginUser.signedIn {
                    
                    Text("").onAppear{
                        
                        getCurrentUser()
                        print("här är jag 2")
                        
                        
                    }
                    
                    
                    if let user = self.user {
                        
                        TabView{
                            NewClientView()
                                .tabItem {
                                    Image(systemName: "florinsign.square")
                                        .resizable()
                                    
                                    Text("Kunder")
                                }
                            
                            StartListView(user: user)
                            
                                .tabItem {
                                    Image(systemName: "person.fill.badge.plus")
                                        .resizable()
                                    
                                    Text("FAKTUROR")
                                    
                                }
                            SalaryView()
                                .tabItem{
                                    Image(systemName: "dollarsign.square")
                                        .resizable()
                                    
                                }
                            
                        }
                        .accentColor(.orange)
                        .offset(y:20)
                        .ignoresSafeArea()
                        
                        
                    }
                    
                    
                    
                    Button(action: {
                        viewLoginUser.signOut()
                        user = nil
                        //   email = ""
                    }, label:{ Text("logga ut")
                            .font(.system(size:12))
                        Image(systemName: "figure.walk.departure")
                            .resizable()
                            .frame(width: 10, height: 10)
                        
                    })
                    
                    .offset(x: -45 ,y: -330)
                    
                    .ignoresSafeArea()
                    
                    
                } else {
                    SignInView()
                }
            }
            
            .onAppear{
                
                viewLoginUser.signedIn = viewLoginUser.isSignedIn
                listenToFirestore()
                
                
            }
        }
        
    }
    func listenToFirestore() {
        db.collection("users").addSnapshotListener { snapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            guard let snapshot = snapshot else {
                print("Error: snapshot is nil")
                return
            }

            users.removeAll()
            for document in snapshot.documents {
                do {
                    let user = try document.data(as: User.self)
                    users.append(user)
                    print(user)
                    print("added to list")
                } catch {
                    print("Error decoding item: \(error)")
                }
            }
        }
    }

    func getCurrentUser(){
        print("i get getcurrentuser")
        print(self.user?.email ?? "null")
        for user in users {
            //   print(user.email)
            // print(email)
            if(user.email == email){
                print("hittade!!")
                print(user.email)
                self.user = user
            }
        }
        
    }
    
}


struct StartListView: View {
    var db = Firestore.firestore()
    @State var invoices = [Invoice]()
    @State var user: User
    
    var body: some View {
        VStack{
            
            
            NavigationLink(destination: NewInvoice(user: user)){
                
                Text("Skapa en faktura")
                    .foregroundColor(.white)
                    .font(.system(size: 7))
                    .frame(width: 40 , height: 35)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30))
            }
            .offset(x:30 ,y: 40)
            .ignoresSafeArea()
            
            
            List(invoices) { invoice in
                NavigationLink(destination: InvoiceDetails(invoice: invoice)) {
                    Text("Fakturanummer \(invoice.invoiceNummer)")
                        .foregroundColor(.white)
                    
                    Image("Frame1")
                        .resizable()
                        .scaledToFill()
                    
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 30,style: .continuous)
                        .foregroundStyle(.linearGradient(colors: [.black, .white], startPoint: .topLeading, endPoint: .bottomTrailing)))
                .padding()
                
                
            }
            
            
        }
        
        .onAppear {
            listenToFirestore()
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
                        if(invoice.user.email ==  user.email){
                            invoices.append(invoice)
                        }
                    case .failure(let error) :
                        print("Error decoding item: \(error)")
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







