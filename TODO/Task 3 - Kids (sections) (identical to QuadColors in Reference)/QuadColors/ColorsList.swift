//
//  ColorsList.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

struct ColorsList<Content: View>: View {
    let easyMode: Bool
    let content: Content

    init(easyMode: Bool = false, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.easyMode = easyMode
    }

    func sectionContent(_ section: SectionConfiguration) -> some View {
        VStack {
            ForEach(subviews: section.content) { subview in
                subview.frame(width: 60, height: 60)
            }
        }
    }

    var body: some View {
        HStack {
            ForEach(sections: content) { section in
                sectionContent(section)
            }
        }
    }
}
