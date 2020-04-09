//
//  Schedule.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/24/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct Event: Hashable, Identifiable {
    var id: Int = -1
    var title: String = ""
    var subTitle: String = ""
    var address: String = ""
    var startTime: Date = Date()
    var endTime: Date = Date()
    func getHeightLine()-> Int{
        return self.endTime.hours(from: self.startTime) * 15
    }
}

struct Schedule: View {
    @State var singleIsPresented = true
    @State var selectedDate:Date = Date()
    @State var monthIndex: Int = 0
    @ObservedObject var rkManager: RKManager = RKManager(calendar: Calendar.current, minimumDate: Date().addingTimeInterval(-60*60*24*365), maximumDate: Date().addingTimeInterval(60*60*24*365),  mode: 0, isCancleable: false)
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack{
                    RKViewController(isPresented: self.$singleIsPresented, rkManager: self.rkManager,monthIndex: self.$monthIndex)
                    ScheduleEvents(selectedDate: self.$rkManager.selectedDate,eventObjs: [Event(id: 1, title: "Test Event", subTitle: "Provided by Huong Le",address: "Dong Son, Thuy Nguyen, Hai Phong",startTime: Date(), endTime: Date().addingTimeInterval(60*60*9)),Event(id: 2, title: "Test Event 3", subTitle: "Provided by Huong Le",address: "Dong Son, Thuy Nguyen, Hai Phong",startTime: Date(), endTime: Date().addingTimeInterval(60*60*6))])
                }.padding([.vertical],CGFloat.stVpadding)
            }
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("", displayMode: .inline)
           .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
}
struct ScheduleEvents: View {
    @Binding var selectedDate: Date
    var eventObjs: [Event]
    var body: some View {
        ForEach(eventObjs) { eventObj in
            ScheduleEventItem(eventObj: eventObj)
            HorizontalLine(color: .border)
        }
        //TextBody(text: self.getTextFromDate(date: self.selectedDate,format: "dd-MMMM"))
    }
}
struct ScheduleEventItem: View {
    //@Binding var selectedDate: Date
    var eventObj: Event
    var body: some View {
        VStack{
            HStack(alignment: .top,spacing: 15){
                VStack{
                    HStack(alignment: .top,spacing: 15){
                        TextBold(text: self.getTextFromDate(date: eventObj.startTime,format: "dd-MMMM"))
                        VStack(alignment: .leading){
                            TextBold(text: eventObj.title, color: Color.textlink)
                            TextBody(text: eventObj.subTitle, color: Color.subtext)
                        }
                        Spacer()
                    }
                    HStack(alignment: .top,spacing: 15){
                        VStack{
                            TextBody(text: "8:00", color: .main)
                            Spacer()
                            TextBody(text: "10:00", color: .maintext)
                        }
                        VeticleLine(color: .main, width: 2).overlay(Text("")
                            .frame(width: 14, height: 14)
                            .background(Color.main)
                            .cornerRadius(7),alignment: .bottom).overlay(Text("")
                            .frame(width: 14, height: 14)
                            .background(Color.main)
                            .cornerRadius(7),alignment: .top)
                        IconText(imageIconLeft:"Artboard 20",text:"Dong Son, Thuy Nguyen, Hai Phong",iconLeftSize:20)
                        Spacer()
                    }.frame(height: CGFloat(eventObj.getHeightLine()))
                }
                Spacer()
                NormalButton(btnText: "Contact",fontSize: .textbody, textColor: Color.maintext, borderColor: Color.border, paddingH: CGFloat(5.00),paddingV: CGFloat(5.00),radius: CGFloat(5.00))
            }
        }.padding(CGFloat.stVpadding).background(Color.white).cornerRadius(20)
    }
}
struct VeticleLineShape: Shape {

    func path(in rect: CGRect) -> Path {

        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 1, height: 1))

        return path
    }
}
struct VeticleLine: View {
    private var color: Color? = nil
    private var width: CGFloat = 1.0
    private var height: CGFloat?
    init(color: Color, width: CGFloat = 4.0) {
        self.color = color
        self.width = width
    }
    init(color: Color, width: CGFloat = 4.0, height: CGFloat?) {
        self.color = color
        self.width = width
        self.height = height
    }
    var body: some View {
        VeticleLineShape().fill(self.color!).frame(minWidth: self.width, maxWidth: self.width, minHeight: 0, maxHeight: (self.height != nil) ? self.height : .infinity)
    }
}
struct Schedule_Previews: PreviewProvider {
    static var previews: some View {
        Schedule()
        //ScheduleEventItem( eventObj: Event(id: 1, title: "Test Event", subTitle: "Provided by Huong Le",address: "Dong Son, Thuy Nguyen, Hai Phong",startTime: Date(), endTime: Date().addingTimeInterval(60*60*9)))
        //VeticleLine(color: .main, width: 5)
    }
}
