//
//  fiveicons.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct fiveicons: View {
    var body: some View {
        HStack(spacing:10){
            VTextIcon(imageIconTop:"Artboard 11",text:"Categories",iconTopSize:48, isFullSize: false, font: Font.textsmall)
            VTextIcon(imageIconTop:"Artboard 12",text:"Instant Helper",iconTopSize:48, isFullSize: false, font: Font.textsmall)
            VTextIcon(imageIconTop:"Artboard 13",text:"Bid Tokens",iconTopSize:48, isFullSize: false, font: Font.textsmall)
            VTextIcon(imageIconTop:"Artboard 14",text:"Membership",iconTopSize:48, isFullSize: false, font: Font.textsmall)
            VTextIcon(imageIconTop:"Artboard 15",text:"Referrals",iconTopSize:48, isFullSize: false, font: Font.textsmall)
        }.frame(height:90).background(Color.white).padding()
    }
}

struct fiveicons_Previews: PreviewProvider {
    static var previews: some View {
        fiveicons()
    }
}
