//
//  ApiManager.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 19.08.21.
//

import Foundation

class ApiManager: ObservableObject{
    
    var serverUrl: String = "http://localhost:5005";
    
    var loginPath: String = "/signin";
    
    @Published var isRegistered: Bool = false;
    
    public func signIn(username_i: String, password_i: String, completion: @escaping (Bool) -> ()) -> Void {
        
        var isSuccess: Bool = false;
        
        guard let url = URL(string: serverUrl + loginPath) else {
//            return false;
            isSuccess = false;
            completion(isSuccess);
            return
        };
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       
        let jsonData = try! JSONEncoder().encode(CredentialsModel(username: username_i, password: password_i))
        
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            let message = try! JSONDecoder().decode(MessageModel.self, from: data!)
            
            print(message.msg);
            
            isSuccess = message.msg.lowercased() == "success";
            DispatchQueue.main.async {
                completion(isSuccess);
            }
        }.resume()
    }
}
