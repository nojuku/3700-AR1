//
//  Data.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-18.
//

let tabs = [
    Page(image: "wave", title: "Welcome !", text: "This is team Orange and let us help you better understand our app in 3 easy steps!"),
    Page(image: "look", title: "Step 1: Look Around", text: "Use the rear camera to explore. Try to find people nearby."),
    Page(image: "person", title: "Step 2: Facial Recongition", text: "Point your camera at a person! We will scan their face and estimate  details like age."),
    Page(image: "phone", title: "Step 3: Analytics", text: "Using the person's age we will calculate how many smarphones the person has used by now. Look out for the visualization and total count as you scan more people!"),
    Page(image: "garbage", title: "Recycled?", text: "Many of these phones are thrown away and it is becoming a problem. Let us tell you why."),
]

struct Page{
    let image: String
    let title: String
    let text: String
}

