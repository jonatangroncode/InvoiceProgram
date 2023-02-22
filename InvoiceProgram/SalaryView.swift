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
                        .edgesIgnoringSafeArea(.all)
                    // Lägg till dina andra vyer ovanpå bakgrundsbilden här.
            Text("Min lön" )
                .foregroundColor(.orange)
                .font(.system(size: 40))
                }
            }    }


struct SalaryView_Previews: PreviewProvider {
    static var previews: some View {
        SalaryView()
    }
}
