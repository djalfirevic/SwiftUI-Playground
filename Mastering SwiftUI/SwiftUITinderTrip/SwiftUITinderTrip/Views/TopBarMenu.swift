//
//  TopBarMenu.swift
//  SwiftUITinderTrip
//
//  Created by Djuro Alfirevic on 4/30/20.
//  Copyright © 2020 Djuro Alfirevic. All rights reserved.
//

import SwiftUI

struct TopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            Spacer()
            Image(systemName: "mappin.and.ellipse")
            .font(.system(size: 35))
            Spacer()
            Image(systemName: "heart.circle.fill")
            .font(.system(size: 30))
        }
        .padding()
    }
}

struct TopBarMenu_Previews: PreviewProvider {
    static var previews: some View {
        TopBarMenu()
    }
}
