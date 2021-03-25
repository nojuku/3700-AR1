//
//  Data.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-18.
//

let tabs = [
    Page(image: "wave", title: "Welcome !", text: "This is team Orange and let us help you better understand our app in 3 easy steps!"),
    Page(image: "look", title: "Step 1: Look Around", text: "Use the rear camera to explore. Try to find people nearby."),
    Page(image: "person", title: "Step 2: Facial Recongition", text: "Once you have found a person we will scan their face and pickup details like age."),
    Page(image: "phone", title: "Step 3: Analyzation", text: "Using the person's age we can estimate how many phones the person has used."),
    Page(image: "garbage", title: "How are they Disposed of?", text: "Many of these phones are thrown away and it is becoming a problem. Let us show you why."),
]

struct Page{
    let image: String
    let title: String
    let text: String
}

