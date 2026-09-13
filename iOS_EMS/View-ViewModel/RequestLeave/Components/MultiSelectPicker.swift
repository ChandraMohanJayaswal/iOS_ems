//
//  MultiSelectPicker.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct MultiSelectPicker<Item: Identifiable>: View {
    let title: String
    let items: [Item]
    let displayName: (Item) -> String

    @Binding var selection: Set<Item.ID>
    var body: some View {
        Menu {
            ForEach(items) { item in
                Button {
                    toggle(item)
                } label: {
                    HStack {
                        Text(displayName(item))
                        Spacer()
                        if selection.contains(item.id) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text(title)
                    .font(.inter(size: 15))
                    .foregroundStyle(.black)
                Spacer()

                if selection.isEmpty {
                    Text("Select")
                        .font(.inter(size: 15))
                        .foregroundStyle(.primary)
                } else {
                    Text("\(selection.count) selected")
                        .font(.inter(size: 15))
                        .foregroundStyle(.primary)
                }

                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption)
                    .foregroundStyle(.primary)
            }
        }
    }

    private func toggle(_ item: Item) {
        if selection.contains(item.id) {
            selection.remove(item.id)
        } else {
            selection.insert(item.id)
        }
    }
}

#Preview {
    @Previewable @State var selection: Set<Int> = []
    MultiSelectPicker(
        title: "Line Manager",
        items: [
            LineManager(id: 1, fullName: "Alice Doe"),
            LineManager(id: 2, fullName: "Bob Smith"),
            LineManager(id: 3, fullName: "Charlie Brown")
        ],
        displayName: { $0.fullName ?? "NA" },
        selection: $selection
    )
    .padding()
}
