//
//  TOC.swift
//  TableOfContents
//
//  Created by Jannik Lorenz on 2021-05-15.
//


import SwiftUI



// MARK: Content protocol

public protocol TOCContent: Identifiable {
    var tocTitle: String { get }
}



// MARK: Mail TOC struct

public struct TOC {
    private var tocItems: [TOC.Entry] = []
    
    public init(@TOC.Builder _ content: () -> [TOC.Entry]) {
        self.tocItems = content()
    }
    
    func getItems(limit: Int) -> [TOC.Item] {
        let totalItems = tocItems.reduce(0) { $0 + $1.count }
        return tocItems.reduce([]) { result, toc in
            switch toc {
            case .item(let item):
                return result + [item]
            case .items(let items):
                if items.count == 0 {
                    return result
                }
                let limit = Int(Double(items.count) / Double(totalItems) * Double(limit))
                return result + Array(items.squeeze(limit))
            }
        }
    }
}



// MARK: Abstract Entry

extension TOC {
    public enum Entry {
        case item(item: TOC.Item)
        case items(items: [TOC.Item])
        
        var count: Int {
            switch self {
            case .item(_): return 1
            case .items(let items): return items.count
            }
        }
    }
}



extension TOC {
    public enum Position {
        case leading
        case trailing
        
        var asEdgeSet: Edge.Set {
            switch self {
            case .leading: return .leading
            case .trailing: return .trailing
            }
        }
    }
}



// MARK: Array squeeze helper

extension Array where Element == TOC.Item {
    func squeeze(_ totalItemsFittable: Int) -> [TOC.Item] {
        if totalItemsFittable >= self.count - 2 {
            return self
        }
        
        // Only accept odd numbers of items to get the correct amount of • placeholders
        let isOddNumber = totalItemsFittable % 2 == 1
        var totalItemsToShow = isOddNumber ? totalItemsFittable : totalItemsFittable - 1
        
        // Subtract two so we can fit the first and last items the user provided
        totalItemsToShow -= 2
        
        // Since it's an odd number, this will integer round down so that there is 1 less index shown than placeholders
        let totalUserItemsToShow = totalItemsToShow // / 2
        
        let showEveryNthCharacter = CGFloat(self.count-2) / CGFloat(totalUserItemsToShow)
        
        var userItemsToShow: [TOC.Item] = []
        
        // Drop the first and last index because we have them covered by the user-provided items
        for i in stride(from: CGFloat(1), to: CGFloat(self.count-1), by: showEveryNthCharacter) {
            if i == 0 {
                continue
            }
            userItemsToShow.append(self[Int(i.rounded())])
            
            if userItemsToShow.count == totalUserItemsToShow {
                // Since we're incrementing by fractional numbers ensure we don't grab one too many and go beyond our indexes
                break
            }
        }
        
        var itemsToShow: [TOC.Item] = []
        if let first = self.first {
            itemsToShow.append(first)
        }
        
        // Every second one show a placeholder
        for item in userItemsToShow {
            itemsToShow.append(item)
        }
        
        if let last = self.last {
            itemsToShow.append(last)
        }
        
        return itemsToShow
    }
}
