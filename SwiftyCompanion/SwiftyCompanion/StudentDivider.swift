//
//  StudentDivider.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/13/21.
//

import Foundation
import SwiftUI

struct StudentDivider: View {
    var body: some View {
        VStack { Divider().frame(height: 2).background(Color(UIColor.systemBlue)) }.padding(.horizontal, 50).padding(.vertical, 30)
    }
}
