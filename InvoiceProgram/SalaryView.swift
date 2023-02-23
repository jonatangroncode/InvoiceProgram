//
//  InvoiceListView.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-08.
//

import SwiftUI

struct SalaryView: View {
    var body: some View {
        ZStack {
            
      
            
            
                    Image("salaray")
                        .resizable()
                        .scaledToFill()
                        
                        .ignoresSafeArea()
                    // Lägg till dina andra vyer ovanpå bakgrundsbilden här.
            Text("Min lön" )
                .foregroundColor(.white)
                .font(.system(size: 40))
                .bold()
                
                }
       
        .ignoresSafeArea()
        
            }
        
}


struct SalaryView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryView()
    }
}
