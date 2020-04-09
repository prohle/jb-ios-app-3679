//
//  TagList.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/7/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import UIKit
import SwiftUI
import Combine

struct TagList: View {
    @Binding var allTags: Set<String>
    @State var selectedTags: Set<String>
    @State private var stringTag: String = ""
    var editable: Bool = true
    var parentWidth: CGFloat
    var placeHolder: String?
    private var orderedTags: [String] { allTags.sorted() }
    //@Binding var teststate: CGFloat
    private func rowCounts() -> [Int] {
        TagList.rowCounts(tags: orderedTags, padding: 5, parentWidth: parentWidth)
    }
    private func tag(rowCounts: [Int], rowIndex: Int, itemIndex: Int) -> String {
        let sumOfPreviousRows = rowCounts.enumerated().reduce(0) { total, next in
            if next.offset < rowIndex {
                return total + next.element
            } else {
                return total
            }
        }
        let orderedTagsIndex = sumOfPreviousRows + itemIndex
        guard orderedTags.count > orderedTagsIndex else { return "[Unknown]" }
        return orderedTags[orderedTagsIndex]
    }

    var body: some View {
                VStack(alignment:  .leading) {
                    if(self.editable == true){
                        HStack{
                            TextField(self.placeHolder ?? "Insert your tags",text: self.$stringTag)
                            Spacer()
                            Button(
                                action:{
                                    if self.allTags.contains(self.stringTag) {
                                        self.allTags.remove(self.stringTag)
                                    } else {
                                        self.allTags.insert(self.stringTag)
                                    }
                                    self.stringTag = ""
                                    
                            },
                                label:{
                                    Image("Artboard 91")
                                        .resizable()
                                        .accentColor(Color.main)
                                        .frame(width: 20,height: 20)
                            })
                        }
                    }
                    //GeometryReader { geometry in
                        VStack(alignment:  .leading) {
                            ForEach(0 ..< self.rowCounts().count, id: \.self) { rowIndex in
                                HStack {
                                    ForEach(0 ..< self.rowCounts()[rowIndex], id: \.self) { itemIndex in
                                        TagButton(title: self.tag(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex), selectedTags: self.$selectedTags, allTags: self.$allTags, editable: self.editable)
                                    }
                                    Spacer()
                                }.padding(.vertical, 4)
                            }
                        }
                    //}
                    //.frame(height: self.viewHeight)
                }
        
    }
}
/*
struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        TagList(allTags: Set<String>(), selectedTags: Set<String>())//.constant(["two"])
    }
}*/

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

extension TagList {
    static func rowCounts(tags: [String], padding: CGFloat, parentWidth: CGFloat) -> [Int] {
        let tagWidths = tags.map{$0.widthOfString(usingFont: UIFont.preferredFont(forTextStyle: .footnote))}

        var currentLineTotal: CGFloat = 0
        var currentRowCount: Int = 0
        var result: [Int] = []

        for tagWidth in tagWidths {
            let effectiveWidth = tagWidth + (2 * padding)
            if currentLineTotal + effectiveWidth <= parentWidth {
                currentLineTotal += effectiveWidth
                currentRowCount += 1
                guard result.count != 0 else { result.append(1); continue }
                result[result.count - 1] = currentRowCount
            } else {
                currentLineTotal = effectiveWidth
                currentRowCount = 1
                result.append(1)
            }
        }
        
        //self.viewHeight = 200
        return result
    }
}
struct TagButton: View {
    let title: String
    @Binding var selectedTags: Set<String>
    @Binding var allTags: Set<String>
    private let vPad: CGFloat = 5
    private let hPad: CGFloat = 10
    private let radius: CGFloat = 5
    var editable: Bool = true
    var body: some View {
        Button(action: {
            if self.selectedTags.contains(self.title) {
                self.selectedTags.remove(self.title)
                self.allTags.remove(self.title)
            } else {
                self.selectedTags.insert(self.title)
            }
        }) {
            if self.editable == true && self.selectedTags.contains(self.title) {
                ZStack(alignment:.topTrailing) {
                    Text(title)
                        .font(.textbody)
                        .padding(.vertical, vPad)
                        .padding(.horizontal, hPad)
                    Image("Artboard 84")
                    .resizable()
                    .accentColor(Color.main)
                    .frame(width:13, height:13)
                    .background(Color.main)
                    .clipShape(Circle())
                    //.offset(x: -10, y: -10)
                    
                }
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(radius)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color(UIColor.systemBackground), lineWidth: 1)
                )
            } else {
                ZStack {
                    Text(title)
                        .font(.textbody)
                        .fontWeight(.light)
                }
                .padding(.vertical, vPad)
                .padding(.horizontal, hPad)
                .foregroundColor(.gray)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
    }
}
