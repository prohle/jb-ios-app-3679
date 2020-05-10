//
//  TagListViewOnly.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/27/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct TimeSlotTag{
    var title: String
    var val: DealDetailTimeOption
}
struct DealDetailTimeSlotTags: View {
    @Binding var allTags: [DealDetailTimeOption]
    @Binding var selectedDate: Date?
    @Binding var selectedTimeSlots: [DealDetailTimeOption]
    var parentWidth: CGFloat
    var clickAble: Bool = false
    private var orderedTags: [DealDetailTimeOption] {
        var results = [DealDetailTimeOption] ()
        for tag in self.allTags {
            let tagDate = tag.deal_date?.utcDateStrToDate() ?? Date()
            if(self.selectedDate?.years(from: tagDate) == 0 && self.selectedDate?.months(from: tagDate) == 0 && self.selectedDate?.days(from: tagDate) == 0){
                results.append(tag)
            }
        }
        return results
    }
    private func rowCounts() -> [Int] {
        DealDetailTimeSlotTags.rowCounts(tags: self.orderedTags, padding: 5, parentWidth: parentWidth, selectedDate: self.selectedDate ?? Date())
    }
    private func tag(rowCounts: [Int], rowIndex: Int, itemIndex: Int) -> TimeSlotTag {
        let sumOfPreviousRows = rowCounts.enumerated().reduce(0) { total, next in
            if next.offset < rowIndex {
                return total + next.element
            } else {
                return total
            }
        }
        let orderedTagsIndex = sumOfPreviousRows + itemIndex
        guard orderedTags.count > orderedTagsIndex else { return TimeSlotTag(title: "Unknown", val: DealDetailTimeOption()) }
        let start_time = orderedTags[orderedTagsIndex].start_time ?? ""
        let deal_date = orderedTags[orderedTagsIndex].deal_date ?? ""
        //return "\(deal_date) \(start_time)"
        
        if !deal_date.isEmpty && deal_date != "" && !start_time.isEmpty  && start_time != ""{
            let fullDateTimeStr = "\(deal_date)T\(start_time)Z"
            if fullDateTimeStr != " "{
                let realDate = fullDateTimeStr.utcDateTimeStrToDate()
                let localTime = realDate.toLocalTimeStr()
                return TimeSlotTag(title: localTime, val: orderedTags[orderedTagsIndex])
            }
        }
        return TimeSlotTag(title: "Unknown", val: DealDetailTimeOption())
        //return allTags[orderedTagsIndex].start_time ?? ""
    }
    var body: some View {
        VStack(alignment:  .leading) {
            //GeometryReader { geometry in
                VStack(alignment:  .leading) {
                    ForEach(0 ..< self.rowCounts().count, id: \.self) { rowIndex in
                        HStack {
                            ForEach(0 ..< self.rowCounts()[rowIndex], id: \.self) { itemIndex in
                                TagViewButton(title: self.tag(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex).title, val: self.tag(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex).val, selectedTimeSlots: self.$selectedTimeSlots,clickAble: self.clickAble)
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
extension DealDetailTimeSlotTags {
    static func rowCounts(tags: [DealDetailTimeOption], padding: CGFloat, parentWidth: CGFloat, selectedDate: Date) -> [Int] {
        debugPrint("-----------SELECTED DATE----------",selectedDate)
        var currentLineTotal: CGFloat = 0
        var currentRowCount: Int = 0
        var result: [Int] = []

        for _ in tags {
            //let tagDate = tag.deal_date?.utcDateStrToDate() ?? Date()
            //debugPrint("-----------COMPAIRE DATE----------Year: ",selectedDate.years(from: tagDate)," - Month: ",selectedDate.months(from: tagDate)," - Days: ",selectedDate.days(from: tagDate))
            //if(selectedDate.years(from: tagDate) == 0 && selectedDate.months(from: tagDate) == 0 && selectedDate.days(from: tagDate) == 0){
                let effectiveWidth = 65 + (2 * padding)
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
          // }
        }
        print(result)
        return result
    }
}
struct TagViewButton: View {
    let title: String
    let val: DealDetailTimeOption
    private let vPad: CGFloat = 5
    private let hPad: CGFloat = 10
    private let radius: CGFloat = 5
    @Binding var selectedTimeSlots: [DealDetailTimeOption]
    @State var is_selected = false
    var clickAble: Bool = false
    var body: some View {
        VStack{
            if self.clickAble == true {
                Button(action:{
                    debugPrint("[---->",self.selectedTimeSlots.contains(self.val),"<-----] ")
                    /*if self.selectedDateTimes.contains(self.val) {
                        let find: Date = self.val
                        let index = self.selectedDateTimes.firstIndex{$0 as AnyObject === find as AnyObject}
                        if index ?? -1 >= 0 {
                            self.selectedDateTimes.remove(at: index!)
                        }
                    }else{
                        self.selectedDateTimes.append(self.val)
                        debugPrint(self.selectedDateTimes," GOT TRUE")
                    }*/
                    if self.selectedTimeSlots.contains(self.val) {
                        //let find: DealDetailTimeOption = self.val
                        if let index = self.selectedTimeSlots.firstIndex(where: { $0.id == self.val.id }){
                            debugPrint("Found at: ",index)
                            //if index ?? -1 >= 0 {
                            self.selectedTimeSlots.remove(at: index)
                            self.is_selected = false
                            //}
                        }
                        //{$0 as AnyObject === find as AnyObject}
                        
                    }else{
                        self.selectedTimeSlots.append(self.val)
                        self.is_selected = true
                        debugPrint(self.selectedTimeSlots," GOT TRUE")
                    }
                }){
                    ZStack(alignment:.topTrailing) {
                        Text(title)
                            .font(.textbody)
                            .foregroundColor((is_selected) ? .white : .main)
                            .padding(.vertical, vPad)
                            .padding(.horizontal, hPad)
                        if is_selected {
                            Image("Artboard 84")
                            .resizable()
                            .accentColor(Color.white)
                            .frame(width:13, height:13)
                            .background(Color.main)
                            .clipShape(Circle())
                        }
                        //.offset(x: -10, y: -10)
                        
                    }
                    .foregroundColor(.maintext)
                    .background(is_selected ? Color.main : Color.white)
                    .cornerRadius(radius)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
            }else{
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
                        .stroke(Color.border, lineWidth: 1)
                )
            }
        }
    }
}
/*curl -X POST http://localhost:8000/api/login \
-H "Accept: application/json" \
-H "Content-type: application/json" \
-d "{\"email\": \"user@user.com\", \"password\": \"1234\" }"
 
 curl -X POST http://localhost:8000/api/exchanges \
 -H 'Accept: application/json' \
 -H 'Authorization: Bearer ZJip3CNSAwHX4sz5DSPGscaxz3Wt0x4ineNcyPikcUJ6fZqve0' \
 -H 'Content-type: application/json' \
 -d '{"exchange_rate\": "123456"}'
 
curl -X POST http://localhost:8000/api/exchanges \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ZJip3CNSAwHX4sz5DSPGscaxz3Wt0x4ineNcyPikcUJ6fZqve0" \
 -H "Content-type: application/json" \
 -d "{\"exchange_rate\": 123456 }"
 
 curl -X POST http://localhost:8000/api/subscribers \
 -H "Accept: application/json" \
 -H "Authorization: Bearer ZJip3CNSAwHX4sz5DSPGscaxz3Wt0x4ineNcyPikcUJ6fZqve0" \
 -H "Content-type: application/json" \
 -d "{\"name\":\"Testtest\",\"email_address\": \"user@user.com\", \"state\": \"active\" }"
 **/
