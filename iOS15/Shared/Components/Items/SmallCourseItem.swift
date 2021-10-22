//
//  SmallCourseItem.swift
//  SmallCourseItem
//
//  Created by Meng To on 2021-08-13.
//

import SwiftUI

struct SmallCourseItem: View {
    var course: Course
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black.opacity(0.1))
                .overlay(Image(course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 105))
            Text(course.subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Text(course.title)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(width: 160, height: sizeCategory > .large ? 240 : 200)
        .background(.ultraThinMaterial)
        .backgroundStyle(cornerRadius: 30)
    }
}

struct CourseItem_Previews: PreviewProvider {
    static var previews: some View {
        SmallCourseItem(course: courses[0])
    }
}
