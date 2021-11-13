//
//  View+Extention.swift
//  SwiftyCompanion
//
//  Created by Onur OZKAYA on 11/11/21.
//

import SwiftUI

extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else {
                // Return empty image if URL is invalid
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage()
        } catch  {
            
        }
        
        return UIImage()
    }
}
