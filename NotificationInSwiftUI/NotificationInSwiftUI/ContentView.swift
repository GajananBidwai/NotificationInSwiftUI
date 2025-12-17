//
//  ContentView.swift
//  NotificationInSwiftUI
//
//  Created by Neosoft on 16/12/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(ApplicationData.self) private var appData
    @State private var inputMassage: String = ""
    @State private var isButtonDisabeld: Bool = false
    
    var body: some View {
        @Bindable var appData = appData
        
        VStack(spacing: 12){
            HStack {
                Text("Message")
                TextField("Inser Message", text: $inputMassage)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Spacer()
                Button("Post Notification") {
                    Task(priority: .background) {
                        let message = inputMassage.trimmingCharacters(in: .whitespaces)
                        if !message.isEmpty {
                            inputMassage = ""
//                            await appData.groupPostNotification(messeage: message)
//                            await appData.postNotification(messeage: message)
                            await appData.actionPostNotification(messeage: message)
                            
                        }
                    }
                }.disabled(isButtonDisabeld)
            }
            Spacer()
        }.padding()
            .task(priority: .background) {
                let authorization = await appData.askAuthorization()
                isButtonDisabeld = !authorization
            }
    }
}

#Preview {
    ContentView()
        .environment(ApplicationData.shared)
}
