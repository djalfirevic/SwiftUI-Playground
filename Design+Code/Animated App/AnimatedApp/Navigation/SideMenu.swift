//
//  SideMenu.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-20.
//

import SwiftUI
import RiveRuntime

struct SideMenu: View {
    @State var isDarkMode = false
    @AppStorage("selectedMenu") var selectedMenu: SelectedMenu = .home
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "person")
                    .padding(12)
                    .background(.white.opacity(0.2))
                    .mask(Circle())
                VStack(alignment: .leading, spacing: 2) {
                    Text("Meng To")
                    Text("UI Designer")
                        .font(.subheadline)
                        .opacity(0.7)
                }
                Spacer()
            }
            .padding()
            
            Text("BROWSE")
                .font(.subheadline).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)
            
            browse
            
            Text("HISTORY")
                .font(.subheadline).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 40)
                .opacity(0.7)
            
            history
            
            Spacer()
            
            HStack(spacing: 14) {
                menuItems3[0].icon.view()
                    .frame(width: 32, height: 32)
                    .opacity(0.6)
                    .onChange(of: isDarkMode) { newValue in
                        if newValue {
                            try? menuItems3[0].icon.setInput("active", value: true)
                        } else {
                            try? menuItems3[0].icon.setInput("active", value: false)
                        }
                    }
                Text(menuItems3[0].text)
                
                Toggle("", isOn: $isDarkMode)
            }
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(8)
        }
        .foregroundColor(.white)
        .frame(maxWidth: 288, maxHeight: .infinity)
        .background(Color(hex: "17203A"))
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color(hex: "17203A").opacity(0.3), radius: 40, x: 0, y: 20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var browse: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(menuItems) { item in
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
                    .padding(.horizontal, 16)
                
                HStack(spacing: 14) {
                    item.icon.view()
                        .frame(width: 32, height: 32)
                        .opacity(0.6)
                    Text(item.text)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue)
                        .frame(maxWidth: selectedMenu == item.menu ? .infinity : 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .background(Color("Background 2"))
                .onTapGesture {
                    withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) {
                        selectedMenu = item.menu
                    }
                    try? item.icon.setInput("active", value: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        try? item.icon.setInput("active", value: false)
                    }
                }
            }
        }
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
    }
    
    var history: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(menuItems2) { item in
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
                    .padding(.horizontal, 16)
                
                HStack(spacing: 14) {
                    item.icon.view()
                        .frame(width: 32, height: 32)
                        .opacity(0.6)
                    Text(item.text)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue)
                        .frame(maxWidth: selectedMenu == item.menu ? .infinity : 0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                )
                .background(Color("Background 2"))
                .onTapGesture {
                    withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) {
                        selectedMenu = item.menu
                    }
                    try? item.icon.setInput("active", value: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        try? item.icon.setInput("active", value: false)
                    }
                }
            }
        }
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}

struct MenuItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: RiveViewModel
    var menu: SelectedMenu
}

var menuItems = [
    MenuItem(text: "Home", icon: RiveViewModel(fileName: "icons", stateMachineName: "HOME_interactivity", artboardName: "HOME"), menu: .home),
    MenuItem(text: "Search", icon: RiveViewModel(fileName: "icons", stateMachineName: "SEARCH_Interactivity", artboardName: "SEARCH"), menu: .search),
    MenuItem(text: "Favorites", icon: RiveViewModel(fileName: "icons", stateMachineName: "STAR_Interactivity", artboardName: "LIKE/STAR"), menu: .favorites),
    MenuItem(text: "Help", icon: RiveViewModel(fileName: "icons", stateMachineName: "CHAT_Interactivity", artboardName: "CHAT"), menu: .help)
]

var menuItems2 = [
    MenuItem(text: "History", icon: RiveViewModel(fileName: "icons", stateMachineName: "TIMER_Interactivity", artboardName: "TIMER"), menu: .history),
    MenuItem(text: "Notifications", icon: RiveViewModel(fileName: "icons", stateMachineName: "BELL_Interactivity", artboardName: "BELL"), menu: .notifications)
]

var menuItems3 = [
    MenuItem(text: "Dark Mode", icon: RiveViewModel(fileName: "icons", stateMachineName: "SETTINGS_Interactivity", artboardName: "SETTINGS"), menu: .darkmode)
]

enum SelectedMenu: String {
    case home
    case search
    case favorites
    case help
    case history
    case notifications
    case darkmode
}
