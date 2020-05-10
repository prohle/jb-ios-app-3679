//
//  CommentUI.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 4/28/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
struct CommentMsg: Identifiable {
    var id: Int =  -1
    var username: String = ""
    var content: String = ""
}
struct Tree<A> {
    var value: A
    var children: [Tree<A>] = []
    init(_ value: A, children: [Tree<A>] = []) {
        self.value = value
        self.children = children
    }
}
extension Tree {
    func map<B>(_ transform: (A) -> B) -> Tree<B> {
        Tree<B>(transform(value), children: children.map { $0.map(transform) })
    }
    
}
struct DiagramSimple<A: Identifiable, V: View>: View {
    let tree: Tree<A>
    let node: (A) -> V

    var body: some View {
        return VStack(alignment: .center) {
            node(tree.value)
            VStack(alignment: .leading, spacing: 10) {
                ForEach(tree.children, id: \.value.id, content: { child in
                    DiagramSimple(tree: child, node: self.node)
                })
            }
        }
    }
}

struct CommentItem: View {
    //var geometry: GeometryProxy
    var commentMsg: CommentMsg
    var treePos: Int = -1
    @Binding var presentForm: Bool
    @Binding var repUsername: String
    @Binding var repPos: Int
    var body: some View {
        HStack(alignment: .top){
            Image("Artboard3")
            .resizable()
            .frame(width:36,height:36)
            .clipShape(Circle())
            VStack(alignment: .leading){
                TextBold(text: commentMsg.username)
                TextBody(text: commentMsg.content)
                Button(action:{
                    self.presentForm.toggle()
                    self.repUsername = self.commentMsg.username
                    self.repPos = self.treePos
                }){
                    TextBody(text: "Reply", color: Color.textlink)
                }
                }.padding(10).background(Color.mainback)
            .cornerRadius(10)
        }
    }
}

struct CommentUI: View {
    @State var cmmTrees = [Tree<CommentMsg>(CommentMsg(id: 1,username: "Pham Van Mong",content: "test comment parent"), children: [
        Tree(CommentMsg(id: 2,username: "Vu duc hoa",content: "ok ok ok")),
        Tree(CommentMsg(id: 3,username: "PHam",content: "ok ok ok"))]
    ),Tree<CommentMsg>(CommentMsg(id: 4,username: "Pham Van Mong",content: "test comment parent"), children: [
        Tree(CommentMsg(id: 5,username: "Son pv",content: "ok ok ok")),
        Tree(CommentMsg(id: 6,username: "Khanh kpp",content: "ok ok ok"))]
    ),Tree<CommentMsg>(CommentMsg(id: 7,username: "Pham Van Mong",content: "test comment parent"), children: [
        Tree(CommentMsg(id: 8,username: "Huong hp",content: "ok ok ok")),
        Tree(CommentMsg(id: 9,username: "Phu pc",content: "ok ok ok"))]
        )]
    
    @Binding var presentForm: Bool
    @Binding var typingMessage: String
    @State var repUsername: String = ""
    @State var repPos: Int = -1
    @State var inputOffset: CGFloat = 0
    @State var keyboardAnimationDuration: TimeInterval = 0
    func getParentPos(valId: Int) -> Int {
        var count: Int = 0
        for tree in self.cmmTrees {
            if tree.value.id == valId {
                return count
            }else{
                for ctree in tree.children {
                    if ctree.value.id == valId {
                        return count
                    }
                }
            }
            count+=1
        }
        return -1
    }
    var body: some View {
        VStack(alignment: .leading,spacing: 10){
            /*ForEach(0..<self.cmmTrees.count) { index in
                DiagramSimple(tree: self.cmmTrees[index], node: { value in
                    CommentItem(commentMsg: value, treePos: index, presentForm: self.$presentForm, repUsername: self.$repUsername, repPos: self.$repPos)
                })
            }*/
            /*ForEach(self.cmmTrees, id: \.value.id, content: { tree in
                DiagramSimple(tree: tree, node: { value in
                    CommentItem(commentMsg: value, presentForm: self.$presentForm, repUsername: self.$repUsername)
                })
            })*/
            ForEach(self.cmmTrees, id: \.value.id){ tree in
                DiagramSimple(tree: tree, node: { value in
                    CommentItem(commentMsg: value, treePos:self.getParentPos(valId: value.id), presentForm: self.$presentForm, repUsername: self.$repUsername, repPos: self.$repPos)
                })
            }
            Spacer()
            Button(action:{
                self.repPos = -1
                self.presentForm.toggle()
            }){
                HStack{
                    Spacer()
                    TextBody(text:"Type Message...", color: Color.placeholder).padding(10).frame(width:250).background(Color.mainback).cornerRadius(5)
                }
            }
            /*if(self.presentForm == true){
                BottomSheetView(
                    isOpen: self.$presentForm,
                    maxHeight: 150 + self.inputOffset
                ) {
                    VStack{
                        HStack{
                            TextBody(text: "Relly to: ", color: .maintext)
                            TextBody(text: self.repUsername, color: .main)
                        }
                        HStack {
                            TextField("Message...", text: $typingMessage)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(minHeight: CGFloat(30))
                            Button(action: sendMessage) {
                                BasicButton(btnText:"Send",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .textbody)
                            }.frame(height:32)
                        }.frame(minHeight: CGFloat(50)).padding()
                            
                    }
                }.animation(.easeOut(duration: self.keyboardAnimationDuration))
                .onReceive(
                  NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
                    .receive(on: RunLoop.main),
                  perform: self.updateKeyboardHeight
                )
            }*/
        }
    }
    /*
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
    }*/
    func sendMessage() {
        debugPrint("----------Reply Post-: --------", self.repPos)
        if(self.repPos >= 0){
            //var treeA = self.cmmTrees[self.repPos]
            //debugPrint("----------Tree replying:---------- ", treeA)
            self.cmmTrees[self.repPos].children.append(Tree(CommentMsg(id: -1,username: self.cmmTrees[self.repPos].value.username,content: typingMessage)))
            //debugPrint("----------After replying:--------- ", treeA)
        }else{
            //debugPrint("----------Befor replying:---------- ", self.cmmTrees)
            self.cmmTrees.append(Tree(CommentMsg(id: -1,username: "current username",content: typingMessage),children: []))
            //debugPrint("----------After replying:---------- ", self.cmmTrees)
        }
        self.presentForm.toggle()
        
        //chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.secondUser))
        typingMessage = ""
    }
}
/*
struct CommentUI_Previews: PreviewProvider {
    static var previews: some View {
        CommentUI()
    }
}*/
