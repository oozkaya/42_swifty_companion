//
//  StudentProjects.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/13/21.
//

import Foundation
import SwiftUI

struct StudentProjects: View {
    
    var projects: [Project]
    
    var body: some View {
        Text("Projects").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).underline()
        List(projects) { project in
            HStack {
                VStack(alignment: .leading) {
                    let mark = project.isValidated == -1 ? "In progess" : String(project.finalMark) + "%"
                    Text(project.name).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title2)
                    Text(mark)
                }
                Spacer()
                switch project.isValidated {
                    case 1:
                        Image("Check_Icon")
                    case 0:
                        Image("Failed_Icon")
                    case -1:
                        Image("In_Progress_Icon")
                    default:
                        Image("In_Progress_Icon")
                }
            }.padding(.vertical, 5)
        }.padding(.horizontal, 50).frame(height: 400)
    }
}
