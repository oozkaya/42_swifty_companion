//
//  StudentView.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/11/21.
//

import Foundation
import SwiftUI
import OAuth2

struct StudentView: View {
    
    var user: User
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Image(colorScheme == .light ? "Footer_Logo_Light" : "Footer_Logo_Dark").resizable()
                    .scaledToFit()
                    .frame(width: 200).rotationEffect(.degrees(180)).padding(.bottom, 30)
                HStack {
                    VStack {
                        Image(uiImage: user.imageUrl.load()).resizable().aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100).clipShape(Circle()).padding(.bottom, 5)
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(colorScheme == .light ? Color.black : Color.white, lineWidth: 5))
                        Text(user.location).padding(.bottom, 5)
                    }.padding(.trailing, 20)
                    VStack {
                        Text(user.displayName).font(.title).padding(.bottom, 5)
                        Text("(\(user.login))").font(.title2).padding(.bottom, 5)
                        Text(user.grade as! String).font(.title3).padding(.bottom, 5)
                        Text(user.email).padding(.bottom, 5)
                        Text("Wallet: " + String(user.wallet) + " ₳").padding(.bottom, 5)
                    }
                }

                ZStack(alignment: .leading) {
                    let width = CGFloat(300)
                    let height = CGFloat(30)
                    let level = user.level as! Double
                    let levelWidth = CGFloat(level / 21 * Double(width))
                    Rectangle().frame(width: width , height: height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Rectangle().frame(width: levelWidth, height: height)
                        .foregroundColor(Color(UIColor.systemBlue))
                    Text("Level " + String(user.level as! Double)).fontWeight(.bold).foregroundColor(Color.white).frame(width: width, alignment: .center)
                }.cornerRadius(45.0).padding(.top, 20)
      
                StudentDivider()
                StudentProjects(projects: user.projects)
                StudentDivider()
                StudentSkills(skills: user.skills)
                Image(colorScheme == .light ? "Footer_Logo_Light" : "Footer_Logo_Dark").resizable()
                    .scaledToFit()
                    .frame(width: 200).padding(.top, 50)
            }
        }
    }
}
