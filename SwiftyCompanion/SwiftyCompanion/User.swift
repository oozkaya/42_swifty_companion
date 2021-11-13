//
//  User.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/13/21.
//

import Foundation
import OAuth2

struct Project: Identifiable {
    var id: ObjectIdentifier
    
    var name: String
    var finalMark: Int
    var isValidated: Int
}

struct Skill: Identifiable {
    var id: ObjectIdentifier
    
    var name: String
    var level: Any?
}

struct  User {
    
    var login: String
    var displayName: String
    var email: String
    var level: Any?
    var location: String
    var grade: Any?
    var imageUrl: String
    var skills: [Skill]
    var projects: [Project]
    var wallet: Int
    
    init() {
        self.login = "No login"
        self.displayName = "No name"
        self.email = "No mail"
        self.level = "0"
        self.location = "Unavailable"
        self.grade = ""
        self.imageUrl = ""
        self.skills = [Skill]()
        self.projects = [Project]()
        self.wallet = 0
    }
    
    init(json: OAuth2JSON) {
        self.login = json["login"] as! String
        self.displayName = json["displayname"] as! String
        self.email = json["email"] as! String
        self.imageUrl = json["image_url"] as! String
        self.wallet = json["wallet"] as! Int
        
        var location: String = "Unavailable"
        if let locationVal = json["location"] {
            if locationVal is String {
                location = locationVal as! String
            }
        }
        self.location = location
        
        var grade: String = ""
        var level: Double = 0.0
        var skills = [Skill]()
        let cursus_users = json["cursus_users"] as! [OAuth2JSON]
        for cursus in cursus_users {
            let cursusId = cursus["cursus_id"] as! Int
            if cursusId == 21 {
                grade = cursus["grade"] is NSNull || cursus["grade"] == nil ? "Student" : cursus["grade"] as! String
                level = cursus["level"] is NSNull || cursus["level"] == nil ? 0.0: cursus["level"] as! Double
                let sks = cursus["skills"] as! NSArray
                for skVal in sks {
                    let sk = skVal as! NSDictionary
                    let name = sk["name"] as! String
                    let level = sk["level"] as! Double
                    skills.append(Skill(id: ObjectIdentifier(sk), name: name, level: level))
                }
            }
        }
        self.grade = grade
        self.level = level
        self.skills = skills
        
        var projects = [Project]()
        let projects_users = json["projects_users"] as! [OAuth2JSON]
        for project in projects_users {
            let cursusIds = project["cursus_ids"] as! [Int]
            if cursusIds.contains(21) {
                let proj = project["project"] as! NSDictionary
                let parent = proj["parent_id"]
                if parent is NSNull {
                    let name = proj["name"] as! String
                    let final_mark = project["final_mark"] is Int ? project["final_mark"] as! Int : 0
                    let validated = project["validated?"] is Int ? project["validated?"] as! Int : -1
                    projects.append(Project(id: ObjectIdentifier(proj), name: name, finalMark: final_mark, isValidated: validated))
                }
            }
        }
        self.projects = projects
    }
}
