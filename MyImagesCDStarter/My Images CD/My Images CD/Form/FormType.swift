//
//  FormType.swift
//  My Images CD
//
//  Created by Obde Willy on 04/01/23.
//

import SwiftUI

enum FormType: Identifiable, View {
    case new(UIImage), update(MyImage)
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new(let uiImage):
            return ImageFormView(viewModel: FormViewModel(uiImage))
        case .update(let myImage):
            return ImageFormView(viewModel: FormViewModel(myImage))
        }
    }
}
