//
//  InsideTupleView2.swift
//  ProSwiftUI
//
//  Created by Paul Hudson on 03/09/2022.
//

import SwiftUI

extension ViewBuilder {
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9, _ c10: C10) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10)> where C0 : View, C1 : View, C2 : View, C3 : View, C4 : View, C5 : View, C6 : View, C7 : View, C8 : View, C9 : View, C10 : View {
        TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10))
    }
}

// These are commented out because they would affect the whole rest of the project, which would mean you would see different output than the book says.
//extension ViewBuilder {
//    static func buildPartialBlock<Content>(first content: Content) -> Content where Content: View {
//        content
//    }
//
//    static func buildPartialBlock<C0, C1>(accumulated: C0, next: C1) -> TupleView<(C0, C1)> where C0: View, C1: View {
//        TupleView((accumulated, next))
//    }
//}


struct InsideTupleView2: SelfCreatingView {
    var body: some View {
        Text("Line 1")
        Text("Line 2")
        Text("Line 3")
        Text("Line 4")
        Text("Line 5")
        Text("Line 6")
        Text("Line 7")
        Text("Line 8")
        Text("Line 9")
        Text("Line 10")
        Text("Line 11")
    }
}

struct InsideTupleView2_Previews: PreviewProvider {
    static var previews: some View {
        InsideTupleView2()
    }
}
