//
//  ChatUI.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/29/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Combine

struct ChatMessage : Hashable {
    var message: String
    var avatar: String
    var color: Color
    // isMe will be true if We sent the message
    var isMe: Bool = false
}
class ChatController : ObservableObject {
    // didChange will let the SwiftUI know that some changes have happened in this object
    // and we need to rebuild all the views related to that object
    var didChange = PassthroughSubject<Void, Never>()
    
    // We've relocated the messages from the main SwiftUI View. Now, if you wish, you can handle the networking part here and populate this array with any data from your database. If you do so, please share your code and let's build the first global open-source chat app in SwiftUI together
    @Published var messages = [
        ChatMessage(message: "Hello world", avatar: "A", color: .red),
        ChatMessage(message: "Hi", avatar: "B", color: .blue)
    ]
    
    // this function will be accessible from SwiftUI main view
    // here you can add the necessary code to send your messages not only to the SwiftUI view, but also to the database so that other users of the app would be able to see it
    func sendMessage(_ chatMessage: ChatMessage) {
        // here we populate the messages array
        messages.append(chatMessage)
        // here we let the SwiftUI know that we need to rebuild the views
        didChange.send(())
    }
    
}
struct ChatUI : View {
    
     // @State here is necessary to make the composedMessage variable accessible from different views
    @EnvironmentObject var viewRouter: ViewRouter
    @State var composedMessage: String = ""
    @ObservedObject var chatController: ChatController = ChatController()
    @State var inputOffset: CGFloat = 0
    @State var keyboardAnimationDuration: TimeInterval = 0
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
               // ScrollView([.vertical],showsIndicators: false) {
                    // the VStack is a vertical stack where we place all our substacks like the List and the TextField
                    VStack {
                        // I've removed the text line from here and replaced it with a list
                        // List is the way you should create any list in SwiftUI
                        List {
                            // we have several messages so we use the For Loop
                            ForEach(self.chatController.messages, id: \.self) { msg in
                                ChatRow(chatMessage: msg)
                            }
                        }
                        Spacer()
                        // TextField are aligned with the Send Button in the same line so we put them in HStack
                        HStack {
                            // this textField generates the value for the composedMessage @State var
                            TextField("Message...", text: self.$composedMessage).frame(minHeight: CGFloat(30)).onTapGesture {
                                print("Typing")
                            }
                            // the button triggers the sendMessage() function written in the end of current View
                            Button(action: self.sendMessage) {
                                BasicButton(btnText:"Send",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody)
                            }.frame(height:32)
                            Spacer()
                        }.frame(minHeight: CGFloat(50))
                            .padding([.bottom], self.inputOffset)
                            .animation(.easeOut(duration: self.keyboardAnimationDuration))
                        .onReceive(
                          NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                            .receive(on: RunLoop.main),
                          perform: self.updateKeyboardHeight
                        )
                    }
                //}.frame(width: geometry.size.width, height:  geometry.size.height)
            }.onTapGesture {
                self.endEditing()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: MainTopTabbar())
        }
    }
    private func updateKeyboardHeight(_ notification: Notification) {
      guard let info = notification.userInfo else { return }
      // Get the duration of the keyboard animation
      keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25

      guard let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
      // If the top of the frame is at the bottom of the screen, set the height to 0.
      if keyboardFrame.origin.y == UIScreen.main.bounds.height {
        inputOffset = 0
      } else {
        // IMPORTANT: This height will _include_ the SafeAreaInset height.
        inputOffset = keyboardFrame.height
      }
    }
    func sendMessage() {
        chatController.sendMessage(ChatMessage(message: composedMessage, avatar: "C", color: .green, isMe: true))
        composedMessage = ""
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
}

// ChatRow will be a view similar to a Cell in standard Swift
struct ChatRow : View {
    // we will need to access and represent the chatMessages here
    var chatMessage: ChatMessage
    // body - is the body of the view, just like the body of the first view we created when opened the project
    var body: some View {
        // HStack - is a horizontal stack. We let the SwiftUI know that we need to place
        // all the following contents horizontally one after another
        Group {
            if !chatMessage.isMe {
                HStack {
                    Group {
                        Text(chatMessage.avatar)
                        Text(chatMessage.message)
                            .bold()
                            .padding(10)
                            .foregroundColor(Color.white)
                            .background(chatMessage.color)
                            .cornerRadius(10)
                    }
                }
            } else {
                HStack {
                    Group {
                        Spacer()
                        Text(chatMessage.message)
                            .bold()
                            .foregroundColor(Color.white)
                            .padding(10)
                            .background(chatMessage.color)
                        .cornerRadius(10)
                        Text(chatMessage.avatar)
                    }
                }
            }
        }

    }
}
