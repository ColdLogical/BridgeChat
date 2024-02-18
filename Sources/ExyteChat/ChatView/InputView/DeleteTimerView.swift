//
//  SwiftUIView.swift
//  
//
//  Created by Chintan Patel on 18/02/24.
//

import SwiftUI
import MijickPopupView

struct DeletePopup: CentrePopup{
    
    func createContent() -> some View {
            HStack(spacing: 0) {
                Text("Witaj okrutny świecie")
                Spacer()
                Button(action: dismiss) { Text("Dismiss") }
            }
            .padding(.vertical, 20)
            .padding(.leading, 24)
            .padding(.trailing, 16)
        }
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
            popup
                .horizontalPadding(20)
//                .bottomPadding(42)
                .cornerRadius(16)
        }
}

struct DeleteTimerView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DeletePopup()
//    DeleteTimerView()
}
