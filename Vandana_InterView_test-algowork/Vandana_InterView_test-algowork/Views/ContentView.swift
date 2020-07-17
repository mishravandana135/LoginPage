//
//  ContentView.swift
//  Vandana_InterView_test-algowork
//
//  Created by Vandana Mishra on 7/15/20.
//  Copyright © 2020 Vandana Mishra. All rights reserved.
//

import SwiftUI
import ValidatedPropertyKit

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)


struct LoginVC: View {
    @Environment(\.managedObjectContext) var context
    
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State var height : CGFloat = 0
    
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMsg = ""
    
    
    // @State public var saveloginData = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    var body: some View {
        
        //enabling ScrollView based on height
        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : (self.height == 0 ? .init() : .vertical), showsIndicators: false){
            
            ZStack {
                VStack {
                    // HelloText()
                    UserImage()
                    UsernameTextField(username: $username)
                    PasswordSecureField(password: $password)
                    EmailSecureField(email: $email)
                    
                    if authenticationDidFail {
                        
                        Text("Fill All data and Try again.")
                            .offset(y: -10)
                            .foregroundColor(.red)
                        
                    }
                    
                    Button(action: {
                        
                        if self.username != "" && self.password != ""  && self.email != ""{
                            
        
                            self.authenticationDidSucceed = true
                            self.authenticationDidFail = false
                            
                            let dataItem = LoginCrediential(context: self.context)
                            dataItem.userName = self.username
                            dataItem.password = self.password
                            dataItem.email = self.email
                            // coredata Save
                            
                            do {
                                try self.context.save()
                                print("Save")
                            } catch  {
                                print("not save")
                            }
                            self.username = ""
                            self.password = ""
                            self.email = ""
                            
                        } else {
                            self.authenticationDidFail = true
                            self.authenticationDidSucceed = false
                        }
                        
                        
                    }) {
                        LoginButtonContent()
                    }
                }
                    // since all edges are ignored...
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                if authenticationDidSucceed {
                    Text("Login succeeded!")
                        
                        
                        .font(.headline)
                        .frame(width: 250, height: 80)
                        .background(Color.yellow)
                        .cornerRadius(20.0)
                        .animation(Animation.default)
                }
            }
            
        }
            // moving view up
            .padding(.bottom, self.height)
            .background(Color.black.opacity(0.03).edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { (not) in
                    let data = not.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
                    let height = data.cgRectValue.height - (UIApplication.shared.windows.first?.safeAreaInsets.bottom)!
                    
                    self.height = height
                    // removing outside SafeArea Height...
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { (_) in
                    
                    self.height = 0
                }
        }
        
    }
    func wordError(title: String, message: String){
        errorMsg = message
        errorTitle = title
        showError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginVC()
    }
}

struct UserImage: View {
    var body: some View {
        Image("userImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.black)
            .cornerRadius(35.0)
    }
}

struct UsernameTextField: View {
    
    @Binding var username: String
    
    var body: some View {
        TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField: View {
    
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct EmailSecureField: View {
    
    @Binding var email: String
    
    var body: some View {
        TextField("Email", text: $email)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

