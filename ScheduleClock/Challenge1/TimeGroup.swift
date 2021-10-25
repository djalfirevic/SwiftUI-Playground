//
//  TimeGroup.swift
//  Challenge1
//
//  Created by Quinn McHenry on 9/14/21.
//

import SwiftUI

struct TimeGroup: View {
    let header: String
    let date: Date

    var body: some View {
        VStack {
            Text(header)
                .bold()
            Text(date, format: .dateTime.hour().minute())
                .font(.title2)
                .bold()
                .foregroundColor(Color("primary"))
            Text(todayOrTomorrow)
                .bold()
        }
        .font(.caption)
        .foregroundColor(Color("secondary"))
    }

    var todayOrTomorrow: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "Today"
        }
        if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        }
        return ""
    }
}

struct TimeGroup_Previews: PreviewProvider {
    static var previews: some View {
        TimeGroup(header: "BEDTIME", date: Date())
    }
}
