//
//  Ice.swift
//  MooTime Creamery
//
//  Created by Rodrigo Soares on 6/29/19.
//  Copyright © 2019 Rodrigo Soares. All rights reserved.
//

import SwiftUI

struct ProductList : View {
    @State var dismissFlag = false
    @State var product: Product = productData[0]
    @State var off: Length = 130
    var products: [Product]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(self.products.identified(by: \.name)) { item in
                        
                        CardView(product: item, delay: self.cardDelay(ic: item))
                            .frame(height: 300)
                            .shadow(color: .init(.sRGB, white: 0, opacity: 0.2), radius: 20, x: 0, y: 1)
                            .padding([.leading, .bottom, .trailing], 32.0)
                            .tapAction({
                                self.product = item
                                withAnimation {
                                    self.dismissFlag.toggle()
                                    self.off = 0
                                }
                                
                            })
                        }
                        .frame(width: UIScreen.main.bounds.size.width)
                    
                    }
                    .padding(.top, 32.0)
                }
                .navigationBarTitle(Text("Flavors"))
                .presentation(self.dismissFlag ? self.modal(product: self.product) : nil)
            
        }
    }
    
    private func cardDelay(ic: Product) -> Double {
        guard let index = self.products.firstIndex(of: ic) else { return 0 }
        return Double(index) * 0.3
    }
    
    private func modal(product: Product) -> Modal {
        let m = Modal(DetailView(product: product, dismissFlag: $dismissFlag, off: $off)) {
            self.dismissFlag = false
        }
        return m
        
    }
    
    
    
}

#if DEBUG
struct Ice_Previews : PreviewProvider {
    static var previews: some View {
        ProductList(products: productData)
    }
}
#endif
