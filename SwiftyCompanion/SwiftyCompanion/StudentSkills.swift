//
//  StudentSkills.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/13/21.
//

import Foundation
import SwiftUI

struct StudentSkills: View {
    
    var skills: [Skill]
    
    var body: some View {
        Text("Skills").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).underline()
        List(skills) { skill in
            VStack(alignment: .leading) {
                HStack {
                    Text(skill.name).font(.title2).fontWeight(.bold)
                    Text(" - level: " + "\(skill.level!)")
                }.padding(.vertical, 5)
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        let width = CGFloat(geometry.size.width)
                        let height = CGFloat(3)
                        let level = skill.level as! Double
                        let levelWidth = CGFloat(level / 21 * Double(width))
                        Rectangle().frame(width: width , height: height)
                            .opacity(0.3)
                            .foregroundColor(Color(UIColor.systemTeal))
                        
                        Rectangle().frame(width: levelWidth, height: height)
                            .foregroundColor(Color(UIColor.systemBlue))
                    }.cornerRadius(45.0).frame(height: 3)
                }
            }.frame(height: 80)
        }.padding(.horizontal, 50).frame(height: 400)
    }
}
