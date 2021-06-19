//
//  View+TOC.swift
//  
//
//  Created by Jannik Lorenz on 19.06.21.
//

import SwiftUI

extension View {
    public func toc(_ entry: TOCEntryConvertible) -> some View {
        self.toc {
            entry
        }
    }
    
    public func toc(@TOC.Builder _ content: @escaping () -> [TOC.Entry]) -> some View {
        ScrollViewReader { proxy in
            self.toc(proxy: proxy, content)
        }
    }
    
    public func toc(proxy: ScrollViewProxy, @TOC.Builder _ content: @escaping () -> [TOC.Entry]) -> some View {
        self.overlay(
            ItemSliderView(proxy: proxy, toc: TOC(content))
        )
    }
}
