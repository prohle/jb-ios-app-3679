//
//  Comment.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/28/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine
struct Comment: Identifiable,Hashable, Codable {
    var id: Int =  -1
    var attach_id_1: Int? =  -1
    var attach_id_2: Int? =  -1
    var attach_id_3: Int? =  -1
    var attach_id_4: Int? =  -1
    var attach_id_5: Int? =  -1
    var attach_url_1: String? =  ""
    var attach_url_2: String? =  ""
    var attach_url_3: String? =  ""
    var attach_url_4: String? =  ""
    var attach_url_5: String? =  ""
    var comment_timestamp: String? =  ""
    var content: String? =  ""
    var down_vote: String? =  ""
    var is_deleted: Bool? = false
    var level: Int? =  -1
    var parent_id: Int? =  -1
    var path: String? =  ""
    var root_id: Int? =  -1
    var root_timestamp: String? =  ""
    var title: String? =  ""
    var topic_id: Int? =  -1
    var topic_type: Int? =  -1
    var total_vote: Int? =  -1
    var up_vote: Int? =  -1
    var user_id: Int? =  -1
}
struct CreateCommentQuery: Encodable {
    let attach_id_1: Int? =  -1
    let attach_id_2: Int? =  -1
    let attach_id_3: Int? =  -1
    let attach_id_4: Int? =  -1
    let attach_id_5: Int? =  -1
    let attach_url_1: String? =  ""
    let attach_url_2: String? =  ""
    let attach_url_3: String? =  ""
    let attach_url_4: String? =  ""
    let attach_url_5: String? =  ""
    let content: String? =  ""
    let parent_id: Int? =  -1
    let title: String? =  ""
    let topic_id: Int? =  -1
    let topic_type: Int? =  -1
}
class CommentObservable: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    @Published var  content: String? =  ""
    @Published var  parent_id: Int? =  -1
    @Published var  title: String? =  ""
    @Published var  topic_id: Int? =  -1
    @Published var  topic_type: Int? =  -1
}
