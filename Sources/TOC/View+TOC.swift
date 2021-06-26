//
//  View+TOC.swift
//  
//
//  Created by Jannik Lorenz on 19.06.21.
//

import SwiftUI

extension View {
    public func toc(_ entry: TOCEntryConvertible, position: TOC.Position = .trailing) -> some View {
        self.toc(position: position) {
            entry
        }
    }
    
    public func toc(position: TOC.Position = .trailing, @TOC.Builder _ content: @escaping () -> [TOC.Entry]) -> some View {
        ScrollViewReader { proxy in
            self.toc(proxy: proxy, position: position, content)
        }
    }
    
    public func toc(proxy: ScrollViewProxy, position: TOC.Position = .trailing, @TOC.Builder _ content: @escaping () -> [TOC.Entry]) -> some View {
        self.overlay(ItemSliderView(proxy: proxy, toc: TOC(content), position: position))
    }
}
