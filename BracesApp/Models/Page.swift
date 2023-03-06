//
//  Page.swift
//  BracesApp
//
//  Created by Seun Olalekan on 2023-02-12.
//

import Foundation

struct Page : Identifiable {
    let id = UUID()
    let image : String
    let text : String
    let tag : Int
    
    static var pages : [Page] = [Page(image: "Selfie", text: "Welcome to Smile Tracker! \nThis is a fun app used to visually track the progress of your tooth alignment.", tag: 0),
                                 Page(image: "Clean", text: "Smile Tracker lets you keep your camera roll clutter free by localizing all your progress pictures to one app.", tag: 1),
                                 Page(image: "Video", text: "The spotlight is yours! \nStitch all your progress photos into a single movie for you to share with your friends, family, or dentist!", tag: 2),
                                 Page(image: "Notification", text: "Never miss another Invisalign set change or appointment with your dentist with helpful reminders linked to your calendar app.", tag: 3)
                             ]
}





