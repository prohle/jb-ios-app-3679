//
//  RatingBar.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/26/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct RatingBar: View {
    @State var selected = -1
    var body: some View {
        HStack(spacing:2){
            ForEach(0..<5) { i in
                Image(systemName:"star.fill").resizable().frame(width:10, height: 10).foregroundColor(self.selected >= i ? .yellow :.gray).onTapGesture {
                    self.selected = i
                }
            }
            
        }
    }
}

struct RatingBar_Previews: PreviewProvider {
    static var previews: some View {
        RatingBar()
    }
}
