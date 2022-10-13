//
//  ToolbarBack.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 11/10/22.
//

import SwiftUI

struct ToolbarBack: View {
    var titleView = "Insert title"
    var isBackEnabled = false
    var isMoreActive = false
    var isCustomBackAction = false // customize back action
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left").foregroundColor(Color.black).font(.system(size: 24))
                            .frame(width: 40.0, height: 40.0)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(titleView).titleToolbar().lineLimit(1).padding([.trailing], 30)
                    }
                    Spacer()
                }
            }
            }.background(Color.pinkApp)
        }
}

struct ToolbarBack_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarBack()
    }
}
