//
//  CardView.swift
//  MooTime Creamery
//
//  Created by Rodrigo Soares on 6/29/19.
//  Copyright © 2019 Rodrigo Soares. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static func fadeAndScale() -> AnyTransition {
        AnyTransition.scale().combined(with: .opacity)
    }
}

struct CardView : View {
    @State var animateIn = false
    var product: Product
    var delay: Double
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: -4) {
                Text(product.subname)
                    .font(.system(.footnote, design: .serif))
                    .fontWeight(.semibold)
                Text(product.name)
                    .font(Font.system(size: 32, design: .serif))
                    .fontWeight(.semibold)
                }
                .foregroundColor(product.fontColor())
            ZStack{
                Image(product.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 170, height: 150)
                    .shadow(color: product.shadowColor(opacity: 0.5), radius: 20, x: 0, y: 1.0)
                    .offset(x: 0, y: 140)
            }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(product.backgroundGradient(), cornerRadius: 0)
            .cornerRadius(40)
            .clipped()
            .opacity(self.animateIn ? 1 : 0)
            .scaleEffect(self.animateIn ? 1 : 0.9)
            .animation(Animation.spring().delay(self.delay))
            .onAppear() {
                    withAnimation {
                        self.animateIn = true
                }
            }
    }
        
}

#if DEBUG
struct CardView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CardView(product: productData[0], delay: 0.5)
            CardView(product: productData[1], delay: 0.8)
            }
            .previewLayout(.fixed(width: 300, height: 300))
    }
    
    
}
#endif
