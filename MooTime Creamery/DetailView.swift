//
//  ContentView.swift
//  MooTime Creamery
//
//  Created by Rodrigo Soares on 6/27/19.
//  Copyright © 2019 Rodrigo Soares. All rights reserved.
//

import SwiftUI

struct DetailView : View {
    var product: Product
    @Binding var dismissFlag: Bool
    @Binding var off: Length
    @State var showCart = false
    
    var transition: AnyTransition {
        let insertion = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        let removal = AnyTransition.scale()
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 24) {
                
                ZStack(alignment: .topLeading) {
                    Button(action: {
                        withAnimation {
                            self.dismissFlag.toggle()
                            self.off = 130
                        }
                    }) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                        }
                        .opacity(self.showCart ? 0 : 1)
                        .padding()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                
                Spacer(minLength: 350)
                
                VStack(alignment: .leading, spacing: -4) {
                    Text(product.subname)
                        .font(.system(.footnote, design: .serif))
                        .fontWeight(.semibold)
                    Text(product.name)
                        .font(Font.system(size: 56, design: .serif))
                        .fontWeight(.semibold)
                    }
                    .opacity(self.off == 0 ? 1 : 0)
                    .animation(Animation.basic().delay(1.2))
                
                
                
                StarsView(rating: product.ratings, reviewCount: product.reviewsCount, color: product.fontColor())
                    .padding(.top, -8)
                    .opacity(self.off == 0 ? 1 : 0)
                    .animation(Animation.basic().delay(1.4))
                
                Text(product.description)
                    .font(.system(.subheadline, design: .serif))
                    .baselineOffset(1)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .lineSpacing(5)
                    .opacity(self.off == 0 ? 1 : 0)
                    .animation(Animation.basic().delay(1.6))
                    .padding(.horizontal, 24.0)
                    .padding(.bottom, 48)
                
                Spacer()
                }
                .frame(minHeight: 0, maxHeight: .infinity)
            
            Button(action: {
                withAnimation {
                    self.showCart.toggle()
                }
            }) {
                Text("Order Now")
                    .color(.white)
                    .fontWeight(.bold)
                    .frame(minWidth: 300, maxWidth: .infinity)
                    .frame(height: 56)
                    .background(product.fontColor())
                    .cornerRadius(28)
                }
                .padding(.horizontal, 32.0)
                .shadow(color: product.fontColor(), radius: 5, x: 0, y: 1)
                .padding(.bottom, 48)
                .offset(x: 0.0, y: off)
            
            
                CartView(product: product, showCart: $showCart)
                    .frame(width: UIScreen.main.bounds.width, height: 700)
                    .offset(x: 0, y: self.showCart ? 20 : 810)
                    .zIndex(5)
                    .animation(.basic(duration: 0.5, curve: .custom(0.4, 0.52, 0.4, 1.15)))
            
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: self.showCart ? 300 : 350)
                .shadow(color: product.shadowColor(opacity: 0.5), radius: 20, x: 0, y: 1.0)
                .opacity(self.off == 0 ? 1 : 0)
                .position(x: UIScreen.main.bounds.midX, y: self.showCart ?  280 : 250)
                .zIndex(10)
                .animation(.basic(duration: 0.3, curve: .custom(0.4, 0.52, 0.4, 1.20)))
            
            }
            .background(product.backgroundGradient(), cornerRadius: 0)
            .foregroundColor(product.fontColor())
            .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        DetailView(product: productData[0], dismissFlag: .constant(true), off: .constant(0))
    }
}
#endif
