//
//  ContentView.swift
//  FinanceAppTemplate
//
//  Created by Ayaz Panahov on 16.08.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Wrapper();
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().previewDevice(
                "iPhone 12 Pro"
            )
        }
    }
}
