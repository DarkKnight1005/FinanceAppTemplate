//
//  KeyboardHeigh.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 16.08.21.
//

import Foundation
import SwiftUI


extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0;
    }
}
