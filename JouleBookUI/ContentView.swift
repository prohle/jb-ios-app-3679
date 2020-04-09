//
//  ContentView.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello Work")
        /*VStack{
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom,-130)
            
            VStack(alignment: .leading) {
                        Text("Turtle Rock")
                            .font(.headline)
                            .foregroundColor(.green)
                            HStack(alignment: .top){
                                Text("Joshua Tree National Park")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("California")
                            }
                        
                    }.padding([.horizontal],20)
        }*/
        
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
