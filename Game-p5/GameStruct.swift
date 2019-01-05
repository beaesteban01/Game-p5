//
//  GameStruct.swift
//  Game-p5
//
//  Created by Beatriz Esteban on 22/11/2018.
//  Copyright © 2018 Beatriz Esteban. All rights reserved.
//

import Foundation

struct Game: Codable {
    let quizzes: [Quiz]
    let pageno: Int
    let nextUrl: String
}
struct Quiz: Codable {
    let id: Int
    let question: String
    let author: Author?
    let attachment: Attachment?
    let favourite: Bool
    let tips: [String]
    
    struct Attachment: Codable {
        let filename: String
        let mime: String
        let url: String
    }
    struct Author: Codable {
        let id: Int
        let isAdmin: Bool?
        let username: String
    }
}

struct Ans: Codable {
    let quizId : Int
    let answer : String
    let result : Bool
    
}
