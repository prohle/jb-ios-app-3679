//
//  AddImageBtn.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 3/11/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//
import UIKit
import SwiftUI
import Mantis
class CropingImg:NSObject, CropViewControllerDelegate{
    @Binding var uiImageInCroping: UIImage
    init(uiimage: Binding<UIImage>) {
        _uiImageInCroping = uiimage
    }
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        uiImageInCroping = cropped
    }
    
    
}
struct CropingImageView {
    @Binding var uiimage: UIImage
    func makeCoordinator() -> CropingImg {
        return CropingImg(uiimage: $uiimage)
    }
}
extension CropingImageView: UIViewControllerRepresentable {
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<CropingImageView>) -> CropViewController {
    var config = Mantis.Config()
    config.ratioOptions = [.custom]
    let cropViewController = Mantis.cropViewController(image: uiimage, config: config)
    cropViewController.delegate = context.coordinator
    /// Default is images gallery. Un-comment the next line of code if you would like to test camera
    //picker.sourceType = .camera
    return cropViewController
  }
  
  func updateUIViewController(_ uiViewController: CropViewController,
                              context: UIViewControllerRepresentableContext<CropingImageView>) {
    
  }
}
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    //@Binding var imageInCoordinator: [Image]
    @Binding var uiImageInCoordinator: [UIImage]
    var maxImg: Int?
    init(isShown: Binding<Bool>, uiimages: Binding<[UIImage]>, maxImg: Int?) {
        _isCoordinatorShown = isShown
        //_imageInCoordinator = images
        _uiImageInCoordinator = uiimages
        self.maxImg = maxImg
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        if(self.maxImg ?? -1 > 0){
            if(uiImageInCoordinator.count < self.maxImg!){
                uiImageInCoordinator.append(unwrapImage)
                //imageInCoordinator.append(Image(uiImage: unwrapImage))
            }
        }else{
            uiImageInCoordinator.append(unwrapImage)
            //imageInCoordinator.append(Image(uiImage: unwrapImage))
        }
        //isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
struct CaptureImageView {
  @Binding var isShown: Bool
  //@Binding var images: [Image]
  @Binding var uiimages: [UIImage]
  var maxImg: Int?
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown,  uiimages: $uiimages, maxImg: self.maxImg)
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    /// Default is images gallery. Un-comment the next line of code if you would like to test camera
    //picker.sourceType = .camera
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<CaptureImageView>) {
    
  }
}

struct AddImageBtn: View {
    var text: String?
    var maxImg: Int?
    //@State var images: [Image] = []
    @State var uiimages: [UIImage] = []
    //@State var edituiimage: UIImage?
    @State var editimagepos: Int?
    @State var showCaptureImageView: Bool = false
    @State var presentForm: Bool = false
    var parentWidth: CGFloat
    private func rowCounts() -> [Int] {
        AddImageBtn.rowCounts(total: self.uiimages.count, parentWidth: parentWidth)
    }
    private func imagepos(rowCounts: [Int], rowIndex: Int, itemIndex: Int) -> Int {
        let sumOfPreviousRows = rowCounts.enumerated().reduce(0) { total, next in
            if next.offset < rowIndex {
                return total + next.element
            } else {
                return total
            }
        }
        let orderedTagsIndex = sumOfPreviousRows + itemIndex
        guard uiimages.count > orderedTagsIndex else { return -1 }
        return orderedTagsIndex
    }
    var body: some View {
        VStack{
            if(self.uiimages.count > 0){
                ForEach(0 ..< self.rowCounts().count, id: \.self) { rowIndex in
                    HStack {
                        ForEach(0 ..< self.rowCounts()[rowIndex], id: \.self) { itemIndex in
                            ZStack(alignment:.topTrailing) {
                                Image(uiImage: self.uiimages[self.imagepos(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex)])
                                .resizable()
                                .frame(width: 90, height: 90)
                                .clipShape(Rectangle())
                                .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 3)
                                Button(action: {
                                    //self.edituiimage = self.uiimages[self.imagepos(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex)]
                                    
                                    //let cropViewController = Mantis.cropViewController(image: self.uiimages[self.imagepos(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex)])
                                    //let cropingImg = CropingImg()
                                    //cropViewController.delegate = cropingImg
                                    //cropingImg.present(cropViewController, animated: true)
                                    
                                }, label: {
                                    Image("Artboard 84")
                                    .resizable()
                                    .accentColor(Color.white)
                                    .frame(width:16, height:16)
                                    .background(Color.main)
                                    .clipShape(Circle())
                                    //.offset(x: -10, y: -10)
                                }).onTapGesture {
                                    self.uiimages.remove(at: self.imagepos(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex))
                                }
                                Button(action: {}, label: {
                                    Image(systemName: "crop.rotate")
                                    .resizable()
                                    .accentColor(Color.white)
                                    .frame(width:16, height:16)
                                    .background(Color.main)
                                    .clipShape(Circle())
                                    //.offset(x: -10, y: -10)
                                }).onTapGesture {
                                    self.editimagepos = self.imagepos(rowCounts: self.rowCounts(), rowIndex: rowIndex, itemIndex: itemIndex)
                                    self.presentForm.toggle()
                                }
                                    .offset(x: 0, y: 70)
                            }
                            
                        }
                        Spacer()
                        //floor(self.parentWidth/94)
                        if(CGFloat(self.rowCounts()[rowIndex]) < 4){
                            Button(action: { }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "plus")
                                    Text(self.text ?? "Add item")
                                }
                            }.onTapGesture {
                                self.showCaptureImageView.toggle()
                            }
                            .foregroundColor(.maintext)
                            .font(.textsmall)
                            .padding(5)
                            .frame(width:90, height:90)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .strokeBorder(
                                        style: StrokeStyle(
                                            lineWidth: 2,
                                            dash: [15]
                                        )
                                    )
                                    .foregroundColor(.border)
                            )
                        }
                    }.padding(.vertical, 4)
                }
                /*ForEach(0 ..< self.images.count, id: \.self) { rowIndex in
                    self.images[rowIndex].resizable()
                    .frame(width: 90, height: 90)
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 3)
                }*/
            }
            if(self.uiimages.count == 0 || (self.uiimages.count > 0 && self.uiimages.count % 4 == 0)){
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Image(systemName: "plus")
                        Text(text ?? "Add item")
                    }
                }.onTapGesture {
                    self.showCaptureImageView.toggle()
                }
                .foregroundColor(.maintext)
                .font(.textsmall)
                .padding(5)
                .frame(width:90, height:90)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .strokeBorder(
                            style: StrokeStyle(
                                lineWidth: 2,
                                dash: [15]
                            )
                        )
                        .foregroundColor(.border)
                )
            }
            if (showCaptureImageView) {
                CaptureImageView(isShown: $showCaptureImageView, uiimages: $uiimages, maxImg: self.maxImg)
            }
        }.sheet(isPresented: $presentForm) {
            CropImageForm(uiimage: self.$uiimages[self.editimagepos!])
        }
    }
}

struct CropImageForm: View {
    @Binding var uiimage: UIImage
    var body: some View {
        //ScrollView(showsIndicators: false) {
            VStack{
                CropingImageView(uiimage: $uiimage)
                Spacer()
            }
        //}
    }
}
extension AddImageBtn {
    static func rowCounts(total: Int, parentWidth: CGFloat) -> [Int] {
        let tagWidth: CGFloat = 94
        var currentLineTotal: CGFloat = 0
        var currentRowCount: Int = 0
        var result: [Int] = []
        
        for _ in (0...total - 1) {
            let effectiveWidth = tagWidth
                //* CGFloat(index + 1)
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
        //print(result)
        return result
    }
}
struct AddImageBtn_Previews: PreviewProvider {
    static var previews: some View {
        AddImageBtn(text: "Add scan Licenses",parentWidth: 320)
    }
}
