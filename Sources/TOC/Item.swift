//
//  Item.swift
//  
//
//  Created by Jannik Lorenz on 19.06.21.
//

import SwiftUI

extension TOC {
    public struct Item: Hashable {
        internal var uuid = UUID()
        var id: AnyHashable?
        var value: Kind
        
        public init(_ kind: Kind, id: AnyHashable? = nil) {
            self.id = id
            self.value = kind
        }
        
        public enum Kind: Hashable {
            case letter(_ string: String)
            case symbol(_ name: String)
            case placeholder
        }
        
        var toView: AnyView {
            switch value {
            case .letter(let string):
                return AnyView(Text(string))
            case .symbol(let name):
                return AnyView(Image(systemName: name))
            case .placeholder:
                return AnyView(Text(""))
            }
        }
    }

    public static var Placeholder = TOC.Item.Kind.placeholder
}



extension TOC {
    public struct ItemGroup {
        var items: [TOC.Item]

        init(items: [TOC.Item]) {
            self.items = items
        }

        static let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        public init<T>(data: [T], convert: (T) -> (id: AnyHashable, title: String) ) {
            let tocCandidates = data.map(convert)
            self.items = Self.alphabet.compactMap { letter in
                tocCandidates.first { $0.title.uppercased().hasPrefix(letter) }
            }.map { TOC.Item(.letter(String($0.title.uppercased().prefix(1))), id: $0.id)}
        }
        
        public init<T: TOCContent>(data: [T]) {
            self.init(data: data, convert: { $0.toItem() })
        }
    }
}
