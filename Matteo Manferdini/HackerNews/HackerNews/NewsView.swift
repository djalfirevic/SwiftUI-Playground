//
//  NewsView.swift
//  HackerNews
//
//  Created by Matteo Manferdini on 15/10/2020.
//

import SwiftUI

struct NewsView: View {
	@StateObject private var model = NewsViewModel()
	
	var body: some View {
		List(model.stories.indices) { index in
			if let story = model.stories[index] {
				Story(position: index + 1, item: story)
			}
		}
		.navigationTitle("News")
		.onAppear(perform: model.fetchTopStories)
	}
}

// MARK: - Story
struct Story: View {
	let position: Int
	let title: String
	let footnote: String
	let score: String
	let commentCount: String
	
	var body: some View {
		HStack(alignment: .top, spacing: 16.0) {
			Position(position: position)
			VStack(alignment: .leading, spacing: 8.0) {
				Text(title)
					.font(.headline)
				Text(footnote)
					.font(.footnote)
					.foregroundColor(.secondary)
				ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
					Badge(text: score, imageName: "arrowtriangle.up.circle")
						.foregroundColor(.teal)
					Badge(text: commentCount, imageName: "ellipses.bubble")
						.padding(.leading, 96.0)
						.foregroundColor(.orange)
				}
				.font(.callout)
				.padding(.bottom)
			}
		}
		.padding(.top, 16.0)
	}
}

extension Story {
	init(position: Int, item: Item) {
		self.position = position
		title = item.title
		score = item.score.formatted
		commentCount = item.commentCount.formatted
		footnote = item.url.formatted
			+ " - \(item.date.timeAgo)"
			+ " - by \(item.author)"
	}
}

struct Badge: View {
	let text: String
	let imageName: String
	
	var body: some View {
		HStack {
			Image(systemName: imageName)
			Text(text)
		}
	}
}

struct Position: View {
	let position: Int
	
	var body: some View {
		ZStack {
			Circle()
				.frame(width: 32.0, height: 32.0)
				.foregroundColor(.teal)
			Text("\(position)")
				.font(.callout)
				.bold()
				.foregroundColor(.white)
		}
	}
}

struct NewsView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			Story(position: 1, item: TestData.story)
			Position(position: 1)
			Badge(text: "1.234", imageName: "paperplane")
		}
		.previewLayout(.sizeThatFits)
	}
}
