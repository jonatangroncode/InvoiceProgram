//
//  LoginUser.swift
//  InvoiceProgram
//
//  Created by Ernesto Carocca on 2023-02-01.
//
/*
import SwiftUI


struct LoginUser: View {
    @State var email = ""
    @State  var password = ""
    var body: some View {
        var body: some View {
                        ZStack{
                            Color.black
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 1000, height: 400)
                                .rotationEffect(.degrees(135))
                                .offset(y:-350)
                            
                            VStack(spacing: 20){
                                Text("Välkommen Chefen ")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .bold, design: .rounded))
                                    .offset(y: -100)
                                
                             //   TextField("Email", text: "\(email)")
                               //     .foregroundColor(.white)
                                 //   .textFieldStyle(.plain)
                                
                            }
                            Rectangle()
                                .frame(width: 350, height: 1)
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 350)
                        
                        .ignoresSafeArea()
                    }
                }

                //struct LoginUser_Previews: PreviewProvider {
                  //  static var previews: some View {
                    //    LoginUser()
                   // }
                //}
                
            
/*
extension View {
    func placeholder<Content:View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
       
            ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1: 0)
            self
            
        }
    }
     
}*/

*/
