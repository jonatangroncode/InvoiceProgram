//
//  SignUpView.swift
//  InvoiceProgram
//
//  Created by Jonatan Grön on 2024-05-21.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    var db = Firestore.firestore()
    
    @EnvironmentObject var viewLoginUser: LoginUser
    
    @State var emailText = ""
    @State  var password = ""
    @State private var userIslogggedIn = false
    
    
    
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


#Preview {
    SignUpView()
}
