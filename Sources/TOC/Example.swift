//
//  SwiftUIView.swift
//  
//
//  Created by Jannik Lorenz on 19.06.21.
//

import SwiftUI

struct DemoModel: TOCContent, Identifiable {
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
    
    var body: some View {
        List {
            Section {
                Text("Header").id("Header")
            }
            Section {
                ForEach(store.data) { d in
                    Text(d.title)
                }
            }
        }.listStyle(GroupedListStyle())
        .toc {
            TOC.Item(.symbol("checkmark.circle"), id: "Header")
            TOC.Placeholder
            store
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
