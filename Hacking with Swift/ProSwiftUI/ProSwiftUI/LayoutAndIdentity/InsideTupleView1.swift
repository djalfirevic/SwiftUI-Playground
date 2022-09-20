//
//  InsideTupleView1.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

struct InsideTupleView1: SelfCreatingView {
    var body: some View {
        VStack {
            Text("Hello")
            Text("World")
        }
        .onTapGesture {
            print(type(of: self.body))
        }
    }
}

struct InsideTupleView1_Previews: PreviewProvider {
    static var previews: some View {
        InsideTupleView1()
    }
}
