//
//  DecimalUtil.swift
//  Bankey
//
//  Created by Mahammad Afandiyev on 10.02.23.
//

import Foundation

extension Decimal {
    var doubleValue : Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
