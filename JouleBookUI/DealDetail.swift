//
//  DealDetail.swift
//  JouleBookUI
//
//  Created by Pham Van Mong on 2/8/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import CoreLocation
import Combine
struct DealDetail: View {
    var dealObj: Deal
    var body: some View {
            VStack {
                /*
                MapView(coordinate: CLLocationCoordinate2D{
                    CLLocationCoordinate2D(
                        latitude: Double(dealObj.latitude),
                        longitude: Double(dealObj.longitude)
                    )
                })
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 300)*/
                /*CircleImage(imageUrl: deal.getImgUrl(),size:250)
                    .offset(y: -130)
                    .padding(.bottom, -130)*/

                VStack(alignment: .leading) {
                    Text(dealObj.name)
                        .font(.title)

                }
                .padding()

                Spacer()
        }
    }
}
/*
#if DEBUG
struct DealDetail_Previews: PreviewProvider {
    static var previews: some View {
        DealDetail(deal: dealDatas[0])
    }
}
#endif*/
