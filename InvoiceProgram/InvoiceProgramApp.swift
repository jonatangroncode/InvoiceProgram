//
//  InvoiceProgramApp.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-01-18.
//

import SwiftUI
import Firebase
@main
struct InvoiceProgramApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
