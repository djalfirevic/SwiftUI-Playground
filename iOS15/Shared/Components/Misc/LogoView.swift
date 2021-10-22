//
//  LogoView.swift
//  iOS15
//
//  Created by Meng To on 2021-07-14.
//

import SwiftUI

struct LogoView: View {
    var image = courses[0].logo
    
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(8)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 18, opacity: 0.4)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
