//
//  SubSliderView.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/22/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct SubSliderViewOne: View {
    var body: some View {
        
        VStack( spacing: 15){
            HStack {
                Spacer()
            }
            Spacer()
            Text("FINE JOB ANYTIME ANYWHERE").font(.texttitle).foregroundColor(Color.white)
            
            Text("Get paid helping people. To and for business and personal needs. Work when you want. Build your network and credential. Sell your best skills and experiences on JouleBook.").font(.textbody).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.bottom,15)
        }.padding([.horizontal],CGFloat.stHpadding).background(
                Image("Artboard1")
                .resizable()
                .aspectRatio(contentMode: .fill)
            )
    }
}
struct SubSliderViewTwo: View {
    var body: some View {
        
        VStack(spacing: 15){
            HStack {
                Spacer()
            }
            Spacer()
            Text("GET HELP WITH ANYTHING").font(.texttitle).foregroundColor(Color.white)
            
            Text("Personal help or business help. Last minute or schedule into the future. Don't limit yourself. It is FREE to post jobs looking for helpers on JouleBook").font(.textbody).foregroundColor(Color.white).multilineTextAlignment(.center).padding(.bottom,15)
            }.padding([.horizontal],CGFloat.stHpadding).background(
                Image("Artboard2")
                .resizable()
                .aspectRatio(contentMode: .fill)
            //Color.main
            /*Image(backgroundImg)
            .resizable()
            .scaledToFill()*/
            )
    }
}
struct SubSliderViewThree: View {
    var body: some View {
        
        VStack(spacing: 15){
            HStack {
                Spacer()
            }
            Spacer()
            Text("Fast response to even last minute need".uppercased()).font(.texttitle).foregroundColor(Color.white)
            
            Text("Real-time Location-based Work Searching and Listing").font(.textbody).bold().foregroundColor(Color.white).multilineTextAlignment(.center).padding(.bottom,15)
            Spacer()
            Button(action: {
                
                self.goToHome()
                
            }) {
                BasicButton(btnText:"START",imageName: nil,colorLinear: LinearGradient(gradient: Gradient(colors: [Color.white,Color.placeholder]), startPoint: .top, endPoint: .bottom), isActive: true, textColor: Color.main)
            }.frame(width:120,height:40)
            Spacer()
            }.padding([.horizontal],CGFloat.stHpadding).background(
                /*Image("Artboard3")
                .resizable()
                .aspectRatio(contentMode: .fill)*/
                
            Color.main
            /*Image(backgroundImg)
            .resizable()
            .scaledToFill()*/
            )
    }
    
    func goToHome() {
    }
}
struct SubSliderViewOne_Previews: PreviewProvider {
    static var previews: some View {
        SubSliderViewOne()
    }
}
