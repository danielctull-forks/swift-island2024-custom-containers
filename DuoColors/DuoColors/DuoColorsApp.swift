//
//  DuoColorsApp.swift
//  DuoColors
//
//  Created by Aviel Gross on 01.08.2024.
//

import SwiftUI

@main
struct DuoColorsApp: App {
    struct ColorModel: EmptyIdentifiable, Equatable {
        let id: Int
        let color: Color
        var hint: Bool

        static var emptyId: Int { 0 }
    }

    static let initialColors = {
        var result = [ColorModel]()
        for i in 1...10 {
            result.append(
                ColorModel(
                    id: i,
                    color: Color.red.mix(with: .blue, by: 1/Double(i)),
                    hint: false
                )
            )
        }
        return result
    }()

    @State private var colors: [ColorModel] = Self.initialColors

    @State private var didWin = false

    @AppStorage("swift.island.easyMode") private var easyMode = false

    func updateColors(isEasyMode: Bool) {
        if isEasyMode {
            var mutableColors = Self.initialColors.dropLast().dropFirst().shuffled()
            for i in 0..<mutableColors.count {
                mutableColors[i].hint = Int.random(in: 1...3) == 3
            }
            colors = mutableColors
        } else {
            colors = Self.initialColors.shuffled()
        }
    }

    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            VStack {
                content
                HStack {
                    Toggle("Easy Mode", isOn: $easyMode)
                }
                .padding(.horizontal)
            }
            _VariadicView.Tree(_VStackLayout(alignment: .center)) {
                Text("")
            }
        }
    }

    func isCorrect(_ item: ColorModel) -> Bool {
        return colors.firstIndex(of: item)! + 1 + (easyMode ? 1 : 0) == item.id
    }

    var content: some View {
        ColorsList(easyMode: easyMode) {

            if easyMode {
                let item = Self.initialColors.first!
                item.color
                    .colorHint(item.id)
                    .isCorrect(true)
            }

            ReorderableForEach(items: colors, itemHeight: 60) { item in
                item.color
                    .colorHint(item.hint ? item.id : nil)
                    .isCorrect(isCorrect(item))
            } moveAction: { from, to in
                colors.move(fromOffsets: .init(integer: from), toOffset: to)
            }

            if easyMode {
                let item = Self.initialColors.last!
                item.color
                    .colorHint(item.id)
                    .isCorrect(true)
            }

        }
        .onChange(of: easyMode) { oldValue, newValue in
            guard oldValue != newValue else { return }
            updateColors(isEasyMode: newValue)
        }
        .onChange(of: colors) { oldValue, newValue in
            guard oldValue != newValue else { return }

            let result = if easyMode {
                [Self.initialColors.first!] + colors + [Self.initialColors.last!]
            } else {
                colors
            }

            let initialIDs = Self.initialColors.map { $0.id }
            let resultIDs = result.map { $0.id }
            let inOrder = initialIDs == resultIDs
            let reverseOrder = initialIDs.reversed() == resultIDs
            didWin = inOrder || reverseOrder
        }
        .onChange(of: didWin) { oldValue, newValue in
            guard oldValue != newValue else { return }
            if !newValue {
                updateColors(isEasyMode: easyMode)
            }
        }
        .onAppear {
            updateColors(isEasyMode: easyMode)
        }
        .sheet(isPresented: $didWin) {
            Text("Amazing! 🎉")
                .font(.largeTitle)
            Button {
                didWin = false
            } label: {
                Text("Play Again")
                    .bold()
                    .foregroundStyle(Color.white)
                    .padding()
                    .background {
                        Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 4))
                    }
            }
        }
    }
}
