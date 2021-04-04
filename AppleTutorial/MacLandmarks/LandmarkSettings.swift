/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The settings view for the app.
*/

import SwiftUI

struct LandmarkSettings: View {
    @AppStorage("MapView.zoom")
    private var zoom: MapView.Zoom = .medium

    var body: some View {
        Form {
            Picker("Map Zoom:", selection: $zoom) {
                ForEach(MapView.Zoom.allCases) { level in
                    Text(level.rawValue)
                }
            }
            .pickerStyle(InlinePickerStyle())
        }
        .frame(width: 300)
        .navigationTitle("Landmark Settings")
        .padding(80)
    }
}

struct LandmarkSettings_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkSettings()
    }
}
