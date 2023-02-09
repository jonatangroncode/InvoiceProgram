//
//  InvoiceProgramApp.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import SwiftUI
import Firebase
import FirebaseAuth
@main

struct InvoiceProgramApp: App {
//@StateObject var newInvoice = NewInvoice()
    init(){
       
        FirebaseApp.configure()
        //Auth.auth().createUser(withEmail: Email, password: "" ) { authResult, error in
          //if let
        }

    //    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
      
  //  }
   
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
