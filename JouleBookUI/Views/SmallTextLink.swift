//
//  SmallTextLink.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct SmallTextLink: View {
    var text:String
    var body: some View {
        Text(text).font(.textsmall).foregroundColor(Color.textlink)
    }
}

struct SmallTextLink_Previews: PreviewProvider {
    static var previews: some View {
        SmallTextLink(text:"test")
    }
}
