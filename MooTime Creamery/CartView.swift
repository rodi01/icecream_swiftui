//
//  CartView.swift
//  MooTime Creamery
//
//  Created by Rodrigo Soares on 6/29/19.
//  Copyright © 2019 Rodrigo Soares. All rights reserved.
//

import SwiftUI

struct CartView : View {
    var product: Product
    @Binding var showCart: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Spacer()
                Text("Great Success!")
                    .bold()
                    .font(.largeTitle)
                    .color(self.product.fontColor())
                    .padding(.bottom, 8.0)
                    .frame(width: geometry.size.width)
                
                Text("Your order will be ready at")
                Text(self.orderTimestamp)
                    .font(.system(size: 24))
                    .bold()
                    .padding(.top, -8)
                

                Text("ORDER NUMBER")
                    .padding(.top, 24)

                Text("\(Int.random(in: 30 ..< 50))")
                    .font(.system(size: 80))
                    .fontWeight(.heavy)
                    .padding(.top, -16)
                    .padding(.bottom, 32)
                
                
                Button(action: {
                    withAnimation{
                        self.showCart.toggle()
                    }
                }){
                    Text("Done")
                        .color(self.product.fontColor())
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: geometry.size.width - 48)
                        .border(self.product.fontColor(), width: 1, cornerRadius: 30)
                    }
                    .padding(.bottom, 56)
                }
                .background(
                    BlurView(style: .light)
                        .cornerRadius(30)
                        .shadow(radius: 30)
                        .frame(width: geometry.size.width, height: geometry.size.height-80)
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY+40)
                    
                )
                .foregroundColor(.black)
                .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    private var orderTimestamp: String {
        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .minute, value: 15, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: modifiedDate)
    }
    
}

#if DEBUG
struct CartView_Previews : PreviewProvider {
    static var previews: some View {
        CartView(product: productData[1], showCart: .constant(true))
            .previewLayout(.fixed(width: 412, height: 490))
    }
}
#endif
