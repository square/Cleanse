//
//  PetHeader.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct PetHeader: View {
    var body: some View {
        HStack {
            
            Image("illustration-cat").resizable().scaledToFill().frame(width: 186, height: 186).padding(.bottom, 16)
            Spacer()
            VStack(alignment: .leading) {
                Text("Find").font(.largeTitle).fontWeight(.bold)
                Text("Some descriptions about pets.\nThis description would look good\nin 2 lines or more").font(.caption).fontWeight(.medium).foregroundColor(.gray).multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct PetHeader_Previews: PreviewProvider {
    static var previews: some View {
        PetHeader()
    }
}
