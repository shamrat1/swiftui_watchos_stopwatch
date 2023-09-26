//
//  SettingView.swift
//  stopwatch Watch App
//
//  Created by Marsa Technologies on 26/9/23.
//

import SwiftUI

struct SettingView: View {
    @State private var items: [ListItem] = [
        ListItem(title: "StopWatch Mode", isToggled: false),
        ListItem(title: "Millisecond", isToggled: false),
    ]
    var body: some View {
        VStack(alignment: .center){
            List{
                Toggle(isOn: $items[0].isToggled){
                    Text(items[0].title)
                }.padding(10)
                Toggle(isOn: $items[1].isToggled){
                    Text(items[1].title)
                }.padding(10)

            }.listStyle(.carousel)
            
            
            Text("Made with ❤️ by YSS").font(.footnote).foregroundColor(.gray)
    }
        }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct ListItem: Identifiable {
    let id = UUID()
    var title: String
    var isToggled: Bool
}
