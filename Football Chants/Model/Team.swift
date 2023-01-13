//
//  Team.swift
//  Football Chants
//
//  Created by Alonso Alas on 5/1/23.
//

import Foundation

class Team {
    let id: TeamType
    let name, info, founded: String
    let manager: Manager
    var isPlaying: Bool
    
    internal init(id: TeamType, name: String, info: String, founded: String, manager: Manager, isPlaying: Bool = false) {
        self.id = id
        self.name = name
        self.info = info
        self.founded = founded
        self.manager = manager
        self.isPlaying = isPlaying
    }
    
}
