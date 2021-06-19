//
//  ItemSliderView.swift
//  
//
//  Created by Jannik Lorenz on 19.06.21.
//

import UIKit
import SwiftUI

struct ItemSliderView: View {
    let proxy: ScrollViewProxy
    let toc: TOC
    @GestureState private var dragLocation: CGPoint = .zero
    @State var isHover = false
    @State var selectedItem: TOC.Item?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                VStack {
                    ForEach(toc.getItems(limit: Int(geometry.size.height*0.80 / 20.0)), id: \.uuid) { item in
                        item.toView
                            .opacity(item == selectedItem ? 1.0 : 0.75)
                            .foregroundColor(.accentColor)
                            .font(.footnote)
                            .frame(width: 40, height: 20)
                            .contentShape(Rectangle())
                            .background(dragObserver(item: item))
                    }
                    .frame(width: 10)
                }
                .padding(4)
                .background(Color(UIColor.tertiarySystemBackground).opacity(isHover ? 1.0 : 0))
                .cornerRadius(6)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .global)
                        .updating($dragLocation) { value, state, _ in state = value.location }
                        .onChanged({ _ in isHover = true })
                        .onEnded({ _ in isHover = false })
                )
                .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
            }
            .padding(.trailing, 8)
        }
    }

    func dragObserver(item: TOC.Item) -> some View {
        GeometryReader { geometry in
            dragObserver(geometry: geometry, item: item)
        }
    }

    func dragObserver(geometry: GeometryProxy, item: TOC.Item) -> some View {
        if geometry.frame(in: .global).contains(dragLocation) {
            DispatchQueue.main.async {
                selectedItem = item
                proxy.scrollTo(item.id, anchor: .top)
            }
        }
        return Rectangle().fill(Color.clear)
    }
}
