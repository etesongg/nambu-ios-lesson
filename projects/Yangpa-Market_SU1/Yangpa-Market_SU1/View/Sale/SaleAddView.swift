//
//  SaleAddView.swift
//  Yangpa-Market_SU1
//
//  Created by 정송희 on 11/19/24.
//

import SwiftUI
import SVProgressHUD
struct SaleAddView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var saleVM:SaleViewModel
    @State var productName:String=""
    @State var description:String=""
    @State var price:String=""
    @State var image:UIImage?
    @State var isPresented: Bool = false
    
    var body: some View {
        GeometryReader{ reader in // reader는 차지 할 수 있는 영역을 말함
            VStack {
                VStack(spacing:10) {
                    CustomTextField(icon: "", placeholder: "상품명을 입력하시오.", text: $productName)
                    
                    CustomTextField(icon: "", placeholder: "상품설명을 입력하시오.", text: $description)
                    CustomTextField(icon: "", placeholder: "가격을 입력하시오.", text: $price)
                }
                Group{
                    if let image {
                        Image(uiImage: image).resizable().frame(width: reader.size.width/5*4, height: reader.size.height/3)
                            .aspectRatio(contentMode: .fit)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: reader.size.width/5*4, height: reader.size.height/3)
                            .aspectRatio(contentMode: .fit)
                            
                    }
                }.padding()
                
                VStack {
                    WideImageButton(icon: "camera", title: "사진선택", backgroundColor: .orange) {
                        isPresented.toggle()
                    }.sheet(isPresented: $isPresented) {
                        ImagePicker(image: $image)
                    }
                    WideImageButton(icon: "plus.bubble", title: "판매등록", backgroundColor: .blue) {
                        saleVM.addSale(image: image, productName: productName, description: description, price: price)
                    }.alert("상품등록", isPresented: $saleVM.isAddShowing) {
                        Button("확인") {
                            saleVM.fetchSales()
                            dismiss()
                        }
                    } message: {
                        Text(saleVM.message)
                    }

                }.padding()
                
            }
        }
    }
}

#Preview {
    let sale = SaleViewModel()
    SaleAddView().environmentObject(sale)
}
