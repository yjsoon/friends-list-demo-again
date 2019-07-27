//
//  Friend.swift
//  Friends List Version 2
//
//  Created by Soon Yin Jie on 6/7/19.
//  Copyright © 2019 Tinkercademy. All rights reserved.
//

import Foundation

class Friend: Codable {
    
    var name: String
    var school: String
    var imageFileName: String
    
    var age: Int
    var website: String
    
    var attack: Float
    var defence: Float
    var stamina: Float
    
    init(name: String, school: String, imageFileName: String, age: Int, website: String, attack: Float, defence: Float, stamina: Float) {
        self.name = name
        self.school = school
        self.imageFileName = imageFileName
        self.age = age
        self.website = website
        self.attack = attack
        self.defence = defence
        self.stamina = stamina
    }
    
    init(name: String, school: String, imageFileName: String, age: Int, website: String) {
        self.name = name
        self.school = school
        self.imageFileName = imageFileName
        self.age = age
        self.website = website

        attack = Float.random(in: 0...15)
        defence = Float.random(in: 0...15)
        stamina = Float.random(in: 0..<15)
    }
    
    static func loadSampleData() -> [Friend] {
        return [
            Friend(name: "YJ", school: "Tinkercademy", imageFileName: "hugface", age: 40, website: "htps://instagram.com/yjsoon", attack: 10, defence: 15, stamina: 5),
            Friend(name: "Fengrun", school: "Tinkercademy", imageFileName: "nerdface", age: 30, website: "https://instagram.com/windspeeds", attack: 6, defence: 5, stamina: 15),
            Friend(name: "Bhargav", school: "NTU", imageFileName: "rolleyes", age: 20, website: "https://instagram.com/photogavphy", attack: 15, defence: 9, stamina: 2),
            Friend(name: "Qin Guan", school: "SST", imageFileName: "sunglasses", age: 10, website: "https://instagram.com/qinguan2004", attack: 12, defence: 5, stamina: 1),
            Friend(name: "James", school: "NYP", imageFileName: "nerdface", age: 0, website: "https://instagram.com")
        ]

    }
    
    static func getArchiveURL() -> URL {
        let plistName = "friends"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
    }
    
    static func saveToFile(friends: [Friend]) {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedFriends = try? propertyListEncoder.encode(friends)
        try? encodedFriends?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Friend]? {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        guard let retrievedFriendsData = try? Data(contentsOf: archiveURL) else { return nil }
        guard let decodedFriends = try? propertyListDecoder.decode(Array<Friend>.self, from: retrievedFriendsData) else { return nil }
        return decodedFriends
    }
    
}
