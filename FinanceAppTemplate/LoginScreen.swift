//
//  LoginScreen.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 16.08.21.
//

import SwiftUI

struct LoginScreen: View {
    
    @StateObject var loginDetails: LoginDetails;
    
    @State private var emailText: String = "";
    @State private var passwordText: String = "";
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background").ignoresSafeArea()
                VStack{
                    Spacer()
                    Image("Logo_Rounded")
                        .resizable()
                        .frame(width: UIScreen.screenWidth / 3, height: UIScreen.screenWidth / 3, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .hueRotation(Angle(degrees: 30))
                        .opacity(0.8)
                        
                    Group{
                        Spacer()
                        Spacer()
                    }
                    EmailField(fieldName: "Email Adress", placeHolder: "name@gmail.com", emailText: $emailText)
                    PasswordField(fieldName: "Password", placeHolder: "••••••••••", passwordText: $passwordText)
                        .padding()
                    Button(action: {
                        ApiManager().signIn(username_i: emailText, password_i: passwordText, completion: { data in
                            loginDetails.isLoggedIn = data;
                            UserDefaults.standard.set(data, forKey: "isLogedIn");
                        })
                        
                    }, label: {
                        LoginButton(buttonName: "Login")
                    })
//                    NavigationLink(destination: MainScreen()) {
//                            LoginButton(buttonName: "Login")
//                    }
//                    .buttonStyle(PlainButtonStyle())
                    
                    Group{
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                   
                }
            }.ignoresSafeArea()
            .environmentObject(loginDetails)
        }
    }
}

struct EmailField: View {
    
    var fieldName: String;
    var placeHolder: String;
    
    @Binding var emailText: String;
    
    var body: some View {
        ZStack(){
            Color.white
            VStack(alignment: .leading){
                Text(fieldName)
                    .font(.headline)
                    .foregroundColor(Color("SubTitle").opacity(0.8))
                    .alignmentGuide(.leading, computeValue: { dimension in
                        UIScreen.screenWidth / 1.4
                    })
                Spacer()
                HStack{
                    Image(systemName: "envelope")
                    TextField(placeHolder, text: $emailText)
                }.alignmentGuide(.leading, computeValue: { dimension in
                    UIScreen.screenWidth / 1.4
                })
                
            }
            .frame(width: UIScreen.screenWidth / 1.5, height: 55, alignment: .center)
            .padding(.trailing)
            .padding(.horizontal)
        }
        .frame(width: UIScreen.screenWidth / 1.2, height: 90, alignment: .center)
        .cornerRadius(25)
        .shadow(color: Color("AccentRound").opacity(0.6), radius: 15, x: 0, y: 10)
    }
}


struct LoginButton: View {
    
    var buttonName: String;
    
//    @State private var emailText: String = "";
    
    var body: some View {
        ZStack(){
            Color("MainColor")
            Text(buttonName)
                .foregroundColor(.white)
                .bold()
                .font(.title3)
        }
        .frame(width: UIScreen.screenWidth / 1.2, height: 60, alignment: .center)
        .cornerRadius(50)
        .shadow(color: Color("AccentRound").opacity(0.5), radius: 10, x: 0, y: 10)
       
    }
}

struct PasswordField: View {
    
    var fieldName: String;
    var placeHolder: String;
    
    @Binding var passwordText: String;
    @State private var needObscure: Bool = true;
    
//    @Binding private var needObscure : Bool = false;
    
    var body: some View {
        ZStack(){
            Color.white
            VStack(alignment: .leading){
                Text(fieldName)
                    .font(.headline)
                    .foregroundColor(Color("SubTitle").opacity(0.8))
//                    .alignmentGuide(.leading, computeValue: { dimension in
//                        UIScreen.screenWidth / 1.4
//                    })
                Spacer()
                HStack{
                    Image(systemName: "lock")
                    if(needObscure){
                        SecureField(placeHolder, text: $passwordText)
                    }else{
                        TextField(placeHolder, text: $passwordText)
                    }
                    Spacer()
                    ObscureButton(needObscure: $needObscure)
//                    Image(systemName: "eye")
                    
                }
//                .alignmentGuide(.leading, computeValue: { dimension in
//                    UIScreen.screenWidth / 1.4
//                })
                
            }
            .frame(width: UIScreen.screenWidth / 1.4, height: 55, alignment: .center)
            .padding(.trailing)
            .padding(.horizontal)
        }
        .frame(width: UIScreen.screenWidth / 1.2, height: 90, alignment: .center)
        .cornerRadius(25)
        .shadow(color: Color("AccentRound").opacity(0.5), radius: 10, x: 0, y: 10)
    }
}

struct ObscureButton: View{
    
    @Binding var needObscure : Bool;
//
//    init(_ needObscure: Bool) {
//        self.needObscure = needObscure;
//    }
    
    var body: some View{
        Button(action: {
            needObscure = !needObscure;
        }, label: {
            needObscure
            ? Image(systemName: "eye")
            : Image(systemName: "eye.slash")
        })
    }
}



//struct LoginScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginScreen().previewDevice(
//            "iPhone 12 Pro"
//        )
//    }
//}
