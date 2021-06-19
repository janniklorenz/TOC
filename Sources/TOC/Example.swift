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
    
    func toItem() -> (id: AnyHashable, title: String) {
        return (id, title)
    }
}

struct SwiftUIView: View {
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
    
    var body: some View {
        List {
            ForEach(data) { d in
                Text(d.title)
            }
        }
//        .toc(TOC.ItemGroup(data: data))
        .toc { data }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}


//extension Array: TOCEntryConvertible where Element: TOCContent {
//    func asEntry() -> [TOC.Entry] {
//        TOC.ItemGroup(data: self).asEntry()
//    }
//}
