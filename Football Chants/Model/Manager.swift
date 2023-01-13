//
//  Manager.swift
//  Football Chants
//
//  Created by Alonso Alas on 5/1/23.
//

import Foundation
 
enum JobType: String{
    case manager = "Manager"
    case headCoach = "Head Coach"
}

struct Manager {
    let name: String
    let job: JobType
}
