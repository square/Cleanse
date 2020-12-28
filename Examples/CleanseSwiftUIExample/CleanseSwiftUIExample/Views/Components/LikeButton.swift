//
//  LikeButton.swift
//  Exam1
//
//  Created by Abdul Chathil on 6/8/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI

struct LikeButton: View {
    let isLiked: Bool
    var body: some View {
        Image(systemName: isLiked ? "heart.fill" : "heart").resizable().scaledToFill().frame(width: 24, height: 24, alignment: .center).foregroundColor(.red)
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(isLiked: true)
    }
}
