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
        DemoModel(title: "Aaaa"),
        DemoModel(title: "Aaaa"),
        DemoModel(title: "Aaaa"),
        DemoModel(title: "Aaaa"),
        DemoModel(title: "Aaaa"),
        DemoModel(title: "Bbbb"),
        DemoModel(title: "Bbbb"),
        DemoModel(title: "Bbbb"),
        DemoModel(title: "Bbbb"),
        DemoModel(title: "Bbbb"),
        DemoModel(title: "Cccc"),
        DemoModel(title: "Cccc"),
        DemoModel(title: "Cccc"),
        DemoModel(title: "Cccc"),
        DemoModel(title: "Cccc"),
        DemoModel(title: "Dddd"),
        DemoModel(title: "Dddd"),
        DemoModel(title: "Dddd"),
        DemoModel(title: "Dddd"),
        DemoModel(title: "Dddd"),
        DemoModel(title: "Eeee"),
        DemoModel(title: "Ffff"),
        DemoModel(title: "Ffff"),
        DemoModel(title: "Ffff"),
        DemoModel(title: "Ffff"),
    ]
    
    func asEntry() -> [TOC.Entry] {
        return TOC.ItemGroup(data: data).asEntry()
    }
}

struct SwiftUIView: View {
    var store = DemoDataStore()
    
    var body: some View {
        List {
            Section {
                Text("Demo").id("demo")
            }
            Section {
                ForEach(store.data) { d in
                    Text(d.title)
                }
            }
        }.listStyle(GroupedListStyle())
        .toc {
            TOC.Item(.symbol("checkmark.circle"), id: "demo")
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
