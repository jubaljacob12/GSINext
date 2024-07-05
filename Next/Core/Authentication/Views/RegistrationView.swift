//
//  RegistrationView.swift
//  NextApp
//
//  Created by JJMac on 3/07/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var fullname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack{
            Color(.init(red: 0.32, green: 0.09, blue: 0.6, alpha: 1))
                .ignoresSafeArea()
            VStack(alignment: .leading,spacing: 20){
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }
                
                Text("Create new account")
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
                VStack{
                    VStack(spacing: 56){
                        CustomInputField(text: $fullname, title: "Full name", placeholder: "Enter your name")
                        CustomInputField(text: $email, title: "Email Address", placeholder: "name@example.com")
                        CustomInputField(text: $password, title: "Create Password", placeholder: "Enter your password", isSecureField: true)


                    }
                    .padding(.leading)
                    Spacer()
                    
                    Button{
                        viewModel.registerUser(withEmail: email, password: password, fullname: fullname)
                    } label: {
                        HStack {
                            Text("SIGN UP")
                                .foregroundColor(.black)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                
                

            }
            .foregroundColor(.white)
        }
    }
}

#Preview {
    RegistrationView()
}
