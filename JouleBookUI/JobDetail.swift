//
//  JobDetail.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 2/26/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI

struct JobDetail: View {
    var jobObject: Job
    var body: some View {
        VStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct JobDetail_Previews: PreviewProvider {
    static var previews: some View {
        JobDetail(jobObject: Job(id:1,name:"Test Job 1",imageName:"https://i-vnexpress.vnecdn.net/2020/02/25/db9e491c570011eaa70a88c9f79d55-8593-1641-1582636513_500x300.jpg",coordinates: Coordinates(latitude:1234, longitude:1234), category:3))
    }
}
