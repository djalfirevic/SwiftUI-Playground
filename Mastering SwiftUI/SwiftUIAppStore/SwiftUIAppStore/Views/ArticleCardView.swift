//
//  ArticleCardView.swift
//  SwiftUIAppStore
//
//  Created by Djuro Alfirevic on 5/21/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct ArticleCardView: View {
    let category: String
    let headline: String
    let subHeadline: String
    let image: UIImage
    var content = ""

    @Binding var isShowContent: Bool
    @State private var dragOffset = CGSize.zero

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: self.isShowContent ? geometry.size.height * 0.7 : min(self.image.size.height/3, 500))
                            .border(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), width: self.isShowContent ? 0 : 1)
                            .cornerRadius(self.isShowContent ? 0 + self.dragOffset.height * 0.1 : 15)
                            .overlay(
                                ArticleExcerptView(category: self.category, headline: self.headline, subHeadline: self.subHeadline, isShowContent: self.$isShowContent)
                                    .cornerRadius(self.isShowContent ? 0 : 15)
                            )

                        // Content
                        if self.isShowContent {
                            Text(self.content)
                                .foregroundColor(Color(.darkGray))
                                .font(.system(.body, design: .rounded))
                                .padding(.horizontal)
                                .padding(.bottom, 50)
                                .transition(.move(edge: .top))
                                .animation(.linear)
                        }
                    }
                }
                .shadow(color: Color(.sRGB, red: 64/255, green: 64/255, blue: 64/255, opacity: 0.3), radius: self.isShowContent ? 0 : 15)
                .gesture(
                    self.isShowContent ?

                    DragGesture()
                        .onChanged({ (value) in
                            if case 30...100 = value.translation.height {
                                self.dragOffset = value.translation
                            }

                            if value.translation.height > 200 {
                                self.isShowContent = false
                                self.dragOffset = .zero
                            }

                        })
                        .onEnded({ (value) in
                            self.dragOffset = .zero
                        })

                    : nil
                )
                
                if self.isShowContent {
                    HStack {
                        Spacer()

                        Button(action: {
                            self.isShowContent = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                    }
                    .padding(.top, 50)
                    .padding(.trailing)
                }
            }
        }
        .scaleEffect(1 - self.dragOffset.height * 0.0018)
    }
}

struct ArticleCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ArticleCardView(category: sampleArticles[0].category, headline: sampleArticles[0].headline, subHeadline: sampleArticles[0].subHeadline, image: sampleArticles[0].image, content: sampleArticles[0].content, isShowContent: .constant(false))

            ArticleCardView(category: sampleArticles[0].category, headline: sampleArticles[0].headline, subHeadline: sampleArticles[0].subHeadline, image: sampleArticles[0].image, content: sampleArticles[0].content, isShowContent: .constant(true))
        }
    }
}
