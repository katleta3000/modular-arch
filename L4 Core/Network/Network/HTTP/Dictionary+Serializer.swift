//
//  File.swift
//  
//
//  Created by Evgenii Rtischev on 27/05/2023.
//

import Foundation

public extension Dictionary where Key == String, Value == Any {
    var asSerializedData: Data {
        (try? JSONSerialization.data(withJSONObject: self)) ?? Data()
    }
}
