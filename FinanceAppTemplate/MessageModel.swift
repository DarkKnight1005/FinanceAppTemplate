// MessageModel.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let messageModel = try? newJSONDecoder().decode(MessageModel.self, from: jsonData)

import Foundation

// MARK: - MessageModel
struct MessageModel: Codable, Hashable {
    let msg: String
}
