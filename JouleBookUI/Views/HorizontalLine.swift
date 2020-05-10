//
//  HorizontalLine.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/17/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct HorizontalLineShape: Shape {

    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 1, height: 1))

        return path
    }
}
struct HorizontalLine: View {
    private var color: Color? = nil
    private var height: CGFloat = 1.0

    init(color: Color, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
}
struct VerticalLine: View {
    private var color: Color? = nil
    private var width: CGFloat = 1.0

    init(color: Color, width: CGFloat = 1.0) {
        self.color = color
        self.width = width
    }

    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: width, maxWidth: width, minHeight: 0, maxHeight: .infinity)
    }
}
struct HorizontalLine_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalLine(color: .red)
    }
}
