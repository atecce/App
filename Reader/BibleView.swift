//
//  BibleView.swift
//  Reader
//
//  Created by Alessandro Tecce on 4/24/26.
//

import Library
import SwiftUI

struct BibleView: View {
    let word = Library.getWord()
    @State var book: Name
    @State var chapter: Int
    @State var verse_start: Int
    @State var verse_end: Int
    var text: Array<String>.SubSequence {
        word[book]![chapter-1][verse_start-1...verse_end-1]
    }
    var body: some View {
        VStack {
            Text("\(text)")
            Text("\(Library.boxDefenderOfMen().names())")
        }
    }
}

#Preview {
    BibleView(book: Name.revelation, chapter: 22, verse_start: 15, verse_end: 16)
}
