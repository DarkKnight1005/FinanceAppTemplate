//
//  Wrapper.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 19.08.21.
//

import SwiftUI

class LoginDetails: ObservableObject{
    @Published var isLoggedIn: Bool = false;
}

struct Wrapper: View {
    
    @EnvironmentObject var loginDetails: LoginDetails;

    @StateObject var loginDetailsState: LoginDetails = LoginDetails();
    
    var body: some View {
        ZStack{
            if(!self.loginDetailsState.isLoggedIn){
                LoginScreen(loginDetails: loginDetailsState)
            }else{
                MainScreen();
            }
        }.onAppear {
            loginDetailsState.isLoggedIn = UserDefaults.standard.bool(forKey: "isLogedIn")
        }
//        .environmentObject(loginDetailsState)
    }
}

struct Wrapper_Previews: PreviewProvider {
    static var previews: some View {
        Wrapper()
    }
}
