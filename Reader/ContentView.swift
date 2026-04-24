//
//  ContentView.swift
//  Reader
//
//  Created by Alessandro Tecce on 4/23/26.
//

import Bible
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        let jesus = Bible.boxRootAndOffspringOfDavid()
        let bible = Bible.readAll()
        NavigationSplitView {
            List {
                ForEach(jesus.words(), id: \.self) { word in
                    NavigationLink {
                        Text("\(bible[word.book.name]![Int(word.chapter)-1][Int(word.verses[0])-1...Int(word.verses[1])-1])")
                    } label: {
                        Text("\(word.book.name) \(word.chapter):\(word.verses[0])-\(word.verses[1])")
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
