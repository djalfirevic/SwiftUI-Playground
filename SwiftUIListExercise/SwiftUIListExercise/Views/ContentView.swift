//
//  ContentView.swift
//  SwiftUIListExercise
//
//  Created by Djuro Alfirevic on 4/20/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct Article: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var rating: Int
    var excerpt: String
    var image: String
}

struct ArticleRow: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(article.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(5)
            
            Text(article.title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .lineLimit(3)
                .padding(.bottom, 0)
            
            Text("By \(article.author)".uppercased())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 0)
            
            HStack(spacing: 3) {
                ForEach(1...(article.rating), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                }
            }
            
            Text(article.excerpt)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
        }
    }
}

struct ContentView: View {
    var articles = [
        Article(title: "The Comprehensive Guide to the State Management in iOS", author: "Alexey Naumov", rating: 4, excerpt: "There are many challenges in the software development, but there is one beast that tends to screw things up much more often than the others: the problem of app’s state management and data propagation.", image: "state-management"),
        Article(title: "Using Swift Protocols to Manage App Configuration", author: "Gabriel Theodoropoulos", rating: 4, excerpt: "Hello and welcome to a new tutorial! One of the most common concepts met and used in Swift by all developers is protocols, and I don’t think there’s even one developer who doesn’t know about them.", image: "protocols"),
        Article(title: "Drawing a Border with Rounded Corners", author: "Simon Ng", rating: 4, excerpt: "With SwiftUI, you can easily draw a border around a button or text (and it actually works for all views) using the border modifier.", image: "swiftui-button"),
        Article(title: "Building a Simple Text Editing App", author: "Gabriel Theodoropoulos", rating: 5, excerpt: "Today we are going to focus on a commonly used family of controls which are vital to every application. Their primary purpose is to gather user input as well as to display certain message types to users. We are going to talk about text controls.", image: "macos-programming"),
        Article(title: "Building a Flutter App with Complex UI", author: "Lawrence Tan", rating: 4, excerpt: "Hello there! Welcome to the second tutorial of our Flutter series. In the last tutorial, you learned the basics of building a Flutter app. So if you have not gone through it, please take a pit stop here, visit it first before proceeding with this tutorial.", image: "flutter-app")
    ]
    
    var body: some View {
        List(articles) { article in
            ArticleRow(article: article)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
