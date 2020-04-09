//
//  Texts.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/20/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct TextBody: View {
    var text: String
    var align: TextAlignment?
    var color: Color?
    var font: Font?
    var body: some View {
        Text(text)
            .font((font != nil ) ? font : Font.textbody)
        .foregroundColor((color != nil ) ? color! : Color.maintext)
        .multilineTextAlignment((align != nil ) ? align! : .leading)
        .foregroundColor(Color.maintext)
    }
}
struct TextBold: View {
    var text: String
    var align: TextAlignment?
    var color: Color?
    var font: Font?
    var body: some View {
        Text(text)
        .bold()
        .font((font != nil ) ? font : Font.textbody)
        .foregroundColor((color != nil ) ? color! : Color.maintext)
        .multilineTextAlignment((align != nil ) ? align! : .leading)
        .foregroundColor(Color.maintext)
    }
}
struct TextObjectTitle: View {
    var text:String
    var body: some View {
        Text(text)
        
        .bold()
        .font(Font.textbody)
        .lineLimit(2)
        .foregroundColor(Color.maintext)
    }
}
struct TextLink: View {
    var text:String
    var body: some View {
        Text(text).font(.body).foregroundColor(Color.textlink)
    }
}
struct ReadMoreTexts: View {
    var text: String = ""
    var fullText: String = ""
    @State var isFull: Bool = false
    var body: some View {
            Button(action:{
                self.isFull.toggle()
            }){
                
                /*Text(self.splitTexts())
                .font(Font.textbody)
                .foregroundColor(Color.maintext)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.maintext)
                .lineLimit(nil)*/
                
                Text(text).font(.textbody).foregroundColor(Color.maintext) + Text("...more").font(.textbody).foregroundColor(Color.textlink)
                //TextBody(text: text)
        }.sheet(isPresented: self.$isFull, content: {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing:15){
                    ZStack(alignment: .topTrailing){
                        Button(action:{
                            self.isFull = false
                        }){
                            Image("Artboard 84").resizable().frame(width:20,height:20).accentColor(.main)
                        }
                        TextBody(text: self.fullText).padding([.top], 30)
                        Spacer()
                    }
                    
                }.padding([.horizontal],CGFloat.stHpadding)
                .padding([.vertical],CGFloat.stVpadding)
            }
        })
    }
    /*func splitTexts()->String{
        if(self.text.count <= self.wordLimits){
            return self.text
        }
        let index = self.text.index(self.text.startIndex, offsetBy: self.wordLimits)
        let mySubstring = self.text.prefix(upTo: index)
        var returnStr: String = ""
        if(self.wordLimits == 40){
            returnStr = [String(mySubstring) ,"... more"].joined(separator: " ")
        }else{
            returnStr = [String(mySubstring) ,"... less"].joined(separator: " ")
        }
        //let mySubstring = self.text.suffix(from: index)
        return returnStr
    }*/
}

struct Texts_Previews: PreviewProvider {
    static var previews: some View {
        ReadMoreTexts()
    }
}
