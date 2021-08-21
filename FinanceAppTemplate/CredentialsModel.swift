// CredentialsModel.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let credentialsModel = try? newJSONDecoder().decode(CredentialsModel.self, from: jsonData)

import Foundation

// MARK: - CredentialsModel
struct CredentialsModel: Codable {
    let username: String
    let password: String
}
