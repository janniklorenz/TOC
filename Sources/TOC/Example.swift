//
//  SwiftUIView.swift
//  
//
//  Created by Jannik Lorenz on 19.06.21.
//

import SwiftUI

struct DemoModel: TOCContent {
    var id = UUID()
    var title: String
    
    var tocTitle: String { return title }
}

struct DemoDataStore: TOCEntryConvertible {
    var data = [
        "Liam", "Olivia", "Noah", "Emma",
        "Oliver", "Ava", "Elijah", "Charlotte",
        "William", "Sophia", "James", "Amelia",
        "Benjamin", "Isabella", "Lucas", "Mia",
        "Henry", "Evelyn", "Alexander", "Harper"
    ]
    .sorted()
    .map { DemoModel(title: $0) }
    
    func asEntry() -> [TOC.Entry] {
        return TOC.ItemGroup(data: data).asEntry()
    }
}

struct SwiftUIView: View {
    var store = DemoDataStore()
    var position = TOC.Position.leading
    
    var body: some View {
        List {
            Section {
                Text("Header").id("Header")
            }
            Section {
                ForEach(store.data) { d in
                    Text(d.title).id(d.id)
                }
                
            }
        }
        .listStyle(GroupedListStyle())
        .toc(position: position) {
            TOC.Item(.symbol("checkmark.circle"), id: "Header")
            TOC.Placeholder
            store
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
        SwiftUIView(position: .trailing)
    }
}
