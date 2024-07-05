//
//  LoginView.swift
//  NextApp
//
//  Created by JJMac on 3/07/24.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.init(red: 0.32, green: 0.09, blue: 0.6, alpha: 1))
                    .ignoresSafeArea()
                
                VStack{
                    // image and title
                    VStack(spacing: -16){
                        Image("logo")
                            .resizable()
                            .frame(width: 100, height: 100)
                    
                    }
                    
                    // input fields
                    
                    VStack(spacing: 24){
                        //input field 1
                        CustomInputField(text: $email, title: "Email Address", placeholder: "name@example.com")
                        
                        //input field 2
                        CustomInputField(text: $password, title: "Password", placeholder: "Enter your password",isSecureField: true)
                        
                        Button {
                            
                        } label: {
                            Text("Forgot password?")
                                .font(.system(size: 13,weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.top)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        

                    }
                    .padding(.horizontal)
                    .padding(.top,12)
                    
                   
                    
                    // social sign in view
                    VStack{
                        //dividers + text
                        HStack(spacing: 24){
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                            
                            Text("Login with Google")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            
                            Rectangle()
                                .frame(width: 76, height: 1)
                                .foregroundColor(.white)
                                .opacity(0.5)
                        }
                        
                        //sign up buttons
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Image("google")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .clipShape(Circle())
                            }

                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                    
                    // sign in button
                    Button{
                        viewModel.signIn(withEmail: email, password: password)
                        
                    } label: {
                        HStack {
                            Text("SIGN IN")
                                .foregroundColor(.black)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // sign up button
                    Spacer()
                    NavigationLink {
                        RegistrationView().navigationBarBackButtonHidden(true)
                    } label: {
                        HStack{
                            Text("Don't have an account?")
                                .font(.system(size: 14))
                            
                            Text("Sign Up")
                                .font(.system(size: 14,weight: .semibold))
                            
                        }
                        .foregroundColor(.white)
                    }

                }
            }
        }
    }
}

#Preview {
    LoginView()
}
