//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/11/21.
//

import Foundation
import SwiftUI
import OAuth2

struct ContentView: View {
    @State var login: String = ""
    @State var user: User = User()
    @State var willMoveToStudentView = false
    @State var showAlert = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var intraApi = Intra42Api()
    
    func callback(dict: OAuth2JSON?, error: Error?) -> Void {
        if let json = dict {
            if json.isEmpty {
                showAlert = true
            } else {
//                for (key, value) in json {
//                    print("'\(key)': \(value)")
//                }
                user = User(json: json)
                willMoveToStudentView = true
            }
        } else {
            showAlert = true
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image(colorScheme == .light ? "Header_Logo_Light" : "Header_Logo_Dark").resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                
                TextField("Student login", text: $login)
                    .frame(width: 200, height: 50).multilineTextAlignment(.center).background(Color.gray.opacity(0.11)).cornerRadius(10).padding(.top, 20)
                
                Button(action: {
                    if (login != "") {
                        intraApi.request(login.lowercased(), callback: callback(dict:error:))
                    }
                }) {
                    Text("Go to profile").fontWeight(.bold).foregroundColor(Color.white).frame(width: 200, height: 50, alignment: .center).background(Color.blue).cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Error to get user !"), dismissButton: .cancel())
                }
                
                Image(colorScheme == .light ? "Footer_Logo_Light" : "Footer_Logo_Dark").resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 250)
                
                NavigationLink(destination: StudentView(user: user), isActive: $willMoveToStudentView) {
                        EmptyView()
                    }
            }.padding(.bottom, 50)
        }
    }
}
