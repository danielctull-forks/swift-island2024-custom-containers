//
//  ColorModel.swift
//  QuadColors
//
//  Created by Aviel Gross on 10.08.2024.
//

import SwiftUI

struct ColorModel: EmptyIdentifiable, Equatable {
    var id: Int { column * 10 + order }
    let column: Int
    let order: Int
    let color: Color

    static var emptyId: Int { 0 }
}

extension [[ColorModel]] {

    static func random() -> Self {
        var result = [[ColorModel]]()

        let steps = 5
        let stepSize = 1.0 / Double(steps - 1)

        for i in 0..<steps {
            let top = Color.red.mix(with: .blue, by: Double(i) * stepSize)
            let bottom = Color.green.mix(with: .yellow, by: Double(i) * stepSize)

            var row = [ColorModel]()
            for j in 0..<steps {
                row.append(
                    ColorModel(
                        column: i,
                        order: j,
                        color: top.mix(with: bottom, by: Double(j) * stepSize )
                    )
                )
            }
            result.append(row)
        }
        return result
    }
}
