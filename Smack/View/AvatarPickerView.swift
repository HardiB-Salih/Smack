//
//  AvatarPickerView.swift
//  Smack
//
//  Created by HardiB.Salih on 7/16/23.
//

import SwiftUI

struct AvatarPickerView: View {
    @State private var selectedSegment = "dark"
    @Binding var avatarSelected: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selectedSegment = "dark"
                }) {
                    Text("Dark")
                        .font(.body).fontWeight(.semibold)
                        .frame(width: 90, height: 40)
                        .foregroundColor(selectedSegment == "dark" ? .white : Color(AssetsColor.secondColor.rawValue))
                        .background(selectedSegment == "dark" ? Color(AssetsColor.secondColor.rawValue) : Color.clear)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    selectedSegment = "light"
                    
                }) {
                    Text("Light")
                        .font(.body).fontWeight(.semibold)
                        .frame(width: 90, height: 40)
                        .foregroundColor(selectedSegment == "light" ? .white : Color(AssetsColor.secondColor.rawValue))
                        .background(selectedSegment == "light" ? Color(AssetsColor.secondColor.rawValue) : Color.clear)
                        .cornerRadius(8)
                    
                }
            }
            
            .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill( Color.black.opacity( 0.1)))
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(.linearGradient(colors: [Color(AssetsColor.secondColor.rawValue), Color(AssetsColor.secondColor.rawValue)], startPoint: .trailing, endPoint: .leading))
            }
            
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: 10)],
                          spacing: 10) {
                    ForEach(0 ..< 28) { item in
                        Image("\(selectedSegment)\(item)")
                            .resizable()
                            .frame(height: 80)
                            .padding(6)
                            .background(RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color(AssetsColor.secondColor.rawValue).opacity( selectedSegment == "dark" ? 0.1 : 1))
                                .animation(.timingCurve(0.2, 0.8, 0.2, 1), value: selectedSegment)
                            )
                            .overlay {
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(.linearGradient(colors: [Color(AssetsColor.secondColor.rawValue), Color(AssetsColor.secondColor.rawValue)], startPoint: .trailing, endPoint: .leading))
                            }.onTapGesture {
                                avatarSelected = "\(selectedSegment)\(item)"
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                      .padding(12)
            }
            
            
            Spacer()
            
            
            
            
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity)
        .overlay {
            Button{
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(AssetsIcon.closeButton.rawValue)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
                    .offset(y: 24)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        
    }
}

struct AvatarPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarPickerView(avatarSelected: .constant("dark0"))
    }
}


