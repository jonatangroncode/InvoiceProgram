//
//  ContentView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
/*
   
   
   NewClientView()
       .tabItem(){
           Image(systemName: "person.fill.badge.plus")
               .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
           Text("Kunder")
           
       }*/
//
import PDFKit
import SwiftUI
import Firebase
import FirebaseAuth

var email = "" 
struct ContentView: View {
    
    @State private var CreateAnInvoiceitem = "contextualmenu.and.cursorarrow.fill"
    //var db = Firestore.firestore()
    
    @EnvironmentObject var viewLoginUser: LoginUser
    //   @ObservedObject var sharedData = SharedData()
    @State  var password = ""
    @State private var userIslogggedIn = false
    @State var user : User?
    var db = Firestore.firestore()
    //@State var dateString = ""
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
                     
                     Spacer()
                     
                    
                    
                    
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
       
            func listenToFirestore()  {
                
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

struct SignInView: View {
    //  var db = Firestore.firestore()
    
    @EnvironmentObject var viewLoginUser: LoginUser
    @State var emailText = ""
  //  @ObservedObject var sharedData = SharedData()
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
                
                
                
                VStack(spacing: 20){
                    Text("Välkommen")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(y: -70)
                    
                    
                    
                    Text("Början till att äga din dröm")
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .offset(y: -100)
                    
                    TextField("email",text: $emailText)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: emailText.isEmpty){
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
                    Button { //register()
                        email = emailText
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                       viewLoginUser.signIn(email:email, password: password)
                        
                    }label: {
                        Text("logga in")
                            .bold()
                            .frame(width: 200, height: 40)
                        
                            .background(
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .fill(.linearGradient(colors: [.blue , .black], startPoint: .top, endPoint: .bottomTrailing))
                                
                            )
                    }
                    .padding()
                 
                    NavigationLink("Skapa ett konto här", destination: SignUpView())
                    
                    
                  
    
                    
                   
                    
                    
                    Text( "DreamIT to live IT")
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

}

        struct SignUpView: View {
              var db = Firestore.firestore()
            
            @EnvironmentObject var viewLoginUser: LoginUser
            
            @State var emailText = ""
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
                        
                           
                        
                        VStack(spacing: 20){
                            Text("Välkommen")
                                .foregroundColor(.white)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .offset(y: -70)
                            
                            
                            
                            Text("Början till att äga din dröm")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .offset(y: -100)
                            
                            TextField("email",text: $emailText)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .foregroundColor(.white)
                                .textFieldStyle(.plain)
                                .placeholder(when:emailText.isEmpty){
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
                            Button { //register()
                                email = emailText
                                guard !email.isEmpty, !password.isEmpty else {
                                    return
                                }
                               viewLoginUser.signUp(email: email, password: password)
                               print("signedUp1")
                                saveToFirestore(user: User( email: email))
                            }label: {
                                Text("Skapa Konto! ")
                                    .bold()
                                    .frame(width: 200, height: 40)
                                
                                    .background(
                                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                                            .fill(.linearGradient(colors: [.blue , .black], startPoint: .top, endPoint: .bottomTrailing))
                                        
                                    )
                            }
                            .padding()
                            Spacer()
                              
                           NavigationLink("Gå till login!",destination: SignInView())
                                .foregroundColor(.blue)
                           .padding()
                       
                            /*  Button{
                             //  login()
                             }label: {
                             Text("Är du redan en användare? Logga in här")
                             .bold()
                             .foregroundColor(.white)
                             .padding(-40)
                             }*/
                            
                          
                            
                            
                            Text( "DreamIT to live IT")
                                .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .offset(y: 130)
                                .frame(alignment: .center)
                                .padding()
                             
                        }
                        .padding()
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
                
            }
            func saveToFirestore(user :User) {
             
                    print("inFunction")
                    do{
                        _ = try    db.collection("users").addDocument(from: user)
                        
                    }catch {
                        print("Error saving to DB")
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
    
    
    
     /*  
    */
    
    
    

