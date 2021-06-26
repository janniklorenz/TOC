//
//  Builder.swift
//  
//
//  Created by Jannik Lorenz on 19.06.21.
//

import Foundation



// MARK: Builder

extension TOC {
    @resultBuilder
    public struct Builder {
        public static func buildBlock() -> [TOC.Entry] { [] }
        
        public static func buildBlock(_ values: TOCEntryConvertible...) -> [TOC.Entry] {
            values.flatMap { $0.asEntry() }
        }

        public static func buildIf(_ value: TOCEntryConvertible?) -> TOCEntryConvertible {
            value ?? []
        }

        public static func buildEither(first: TOCEntryConvertible) -> TOCEntryConvertible {
            first
        }

        public static func buildEither(second: TOCEntryConvertible) -> TOCEntryConvertible {
            second
        }
    }
}



// MARK: TOCEntryConvertible

public protocol TOCEntryConvertible {
    func asEntry() -> [TOC.Entry]
}

public extension TOCEntryConvertible {
    func asEntry() -> [TOC.Entry] {
        fatalError("TOCEntryConvertible not implemented")
    }
}

extension TOC.Item: TOCEntryConvertible {
    public func asEntry() -> [TOC.Entry] { [TOC.Entry.item(item: self)] }
}

extension TOC.ItemGroup: TOCEntryConvertible {
    public func asEntry() -> [TOC.Entry] {
        [TOC.Entry.items(items: self.items)]
    }
}

extension TOC.Item.Kind: TOCEntryConvertible {
    public func asEntry() -> [TOC.Entry] {
        TOC.Item(self).asEntry()
    }
}

extension Array where Element == TOC.Entry {
    public func asEntry() -> [TOC.Entry] { self }
}

extension Array where Element: TOCContent {
    public func asEntry() -> [TOC.Entry] {
        TOC.ItemGroup(data: self).asEntry()
    }
}

extension Array: TOCEntryConvertible {}
