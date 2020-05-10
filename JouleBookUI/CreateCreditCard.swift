//
//  CreateCreditCard.swift
//  JouleBookUI
//
//  Created by Nguyen thi Chang on 5/6/20.
//  Copyright © 2020 Pham Van Mong. All rights reserved.
//

import SwiftUI
import Stripe
import KeychainAccess
//cardSetups
/*class CropingImg:NSObject, CropViewControllerDelegate{
    @Binding var uiImageInCroping: UIImage
    init(uiimage: Binding<UIImage>) {
        _uiImageInCroping = uiimage
    }
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        uiImageInCroping = cropped
    }
}
enum ActiveSheet {
   case selectimg, cutimg
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
}**/
class AuthenticationContextDelegate:NSObject, STPAuthenticationContext{
    var uiContext: UIViewController
    init(context: UIViewController) {
        self.uiContext = context
    }
    func authenticationPresentingViewController() -> UIViewController {
        return self.uiContext
    }
}
class PaymentCardTextFieldDelegate:NSObject,STPPaymentCardTextFieldDelegate{
    @Binding var paymentMethodCardParams: STPPaymentMethodCardParams
    init(params: Binding<STPPaymentMethodCardParams>) {
       _paymentMethodCardParams = params
    }
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField){
        debugPrint("cardParams changed",textField.cardParams)
        paymentMethodCardParams = textField.cardParams
    }
}
struct UIPaymentCardTextField: UIViewRepresentable {
    @Binding var paymentMethodCardParams: STPPaymentMethodCardParams
    func makeCoordinator() -> PaymentCardTextFieldDelegate {
        return PaymentCardTextFieldDelegate(params: self.$paymentMethodCardParams)
    }
    func makeUIView(context: Context) -> STPPaymentCardTextField{
        let cardTextField = STPPaymentCardTextField.init()
        cardTextField.delegate = context.coordinator
        return cardTextField
    }
    func updateUIView(_ mapView: STPPaymentCardTextField, context: Context){
        
    }
}
struct CreditCardTopSaveTabbar: View {
    @EnvironmentObject var cardObservable: CardObservable
    var body: some View {
        HStack{
            Button(action: {
                self.cardObservable.submitCard()
            }) {
                Image( "Artboard 8")
                    .resizable()
                    .imageScale(.small)
                    .frame(width:20,height:20)
                    .accentColor(Color.main)
            }
        }
    }
}
struct CreateCreditCard: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @ObservedObject var cardObservable = CardObservable()
    @State var paymentMethodCardParams: STPPaymentMethodCardParams = STPPaymentMethodCardParams()
    var body: some View {
        NavigationView {
            Form{
                Section{
                    VStack{
                        UIPaymentCardTextField(paymentMethodCardParams: self.$paymentMethodCardParams)
                        Spacer()
                        Button(action: {}){
                            BasicButton(btnText:"Pay",imageName: nil,iconWidth:18, iconHeight:18,isActive: true,paddingH: CGFloat(5.00),paddingV:CGFloat(5.00),fontSize: .footnote)
                        }.onTapGesture {
                            self.pay()
                        }
                    }
                }
            }.onTapGesture {
                self.endEditing()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: HomeLeftTopTabbar(), trailing: CreditCardTopSaveTabbar().environmentObject(self.cardObservable))
        }
    }
    func endEditing(){
        UIApplication.shared.endEditing()
    }
    /*
    func makeCoordinator() -> AuthenticationContextDelegate {
        return AuthenticationContextDelegate()
    }*/
    func pay(){
        let keychain = Keychain(service: "ISOWEB.JouleBookUI")
        if self.cardObservable.cardSetupsObj.data.client_secret.isEmpty {
            print("client_secret empty")
        }
        let billingDetails = STPPaymentMethodBillingDetails()
        let userEmail = try! keychain.getString("user_email") ?? ""
        billingDetails.email = userEmail
        let paymentMethodParams = STPPaymentMethodParams(card: self.paymentMethodCardParams, billingDetails: billingDetails, metadata: nil)
        let setupIntentParams = STPSetupIntentConfirmParams(clientSecret: self.cardObservable.cardSetupsObj.data.client_secret)
        setupIntentParams.paymentMethodParams = paymentMethodParams
        // Complete the setup
        let paymentHandler = STPPaymentHandler.shared()
        let controller = UIHostingController(rootView: self)
        paymentHandler.confirmSetupIntent(withParams: setupIntentParams, authenticationContext: AuthenticationContextDelegate(context: controller)) { status, setupIntent, error in
            switch (status) {
            case .failed:
                debugPrint("Setup failed",error?.localizedDescription ?? "")
                break
            case .canceled:
                debugPrint("Setup canceled",error?.localizedDescription ?? "")
                break
            case .succeeded:
                debugPrint("Setup succeeded",status,"---------",setupIntent)
                self.cardObservable.stripeID = setupIntent?.stripeID ?? ""
                break
            @unknown default:
                fatalError()
                break
            }
        }
    }
}
struct CreateCreditCard_Previews: PreviewProvider {
    static var previews: some View {
        CreateCreditCard()
    }
}
