// The Swift Programming Language
// https://docs.swift.org/swift-book
import Bible
import Foundation

func arcGenealogy(daemon: ArcDaemon?) {
	var cur = daemon!.father()
	while cur != nil {
		print(cur!.names())
		cur = cur!.father()
	}
}

let יֵשׁוּ = arcMorningStar()

print("\(יֵשׁוּ)")
print("\(יֵשׁוּ.names())")
print("\(boxMorningStar())")
print("\(boxMorningStar().names())")

arcGenealogy(daemon: יֵשׁוּ)

let bible = Bible.readAll()
print("\(bible)")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
do {
	let data = try encoder.encode(bible)
	let fileManager = FileManager.default

	let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
	let fileURL = documentDirectory.appendingPathComponent("swift_word.json")

	do {
		try data.write(to: fileURL)
		print("file saved at: \(fileURL)")
	} catch {
		print("writing to file failed: \(error)")
	}
} catch {
	print("encoding failed: \(error)")
}

let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)

let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
let tags: [NSLinguisticTag] = [.personalName]

var index: [String: [UniffiSource]] = [:]

for (book, chapter_and_verse) in bible {
	for (chapter, verses) in chapter_and_verse.enumerated() {
		for (verse, text) in verses.enumerated() {

			tagger.string = text

			let range = NSRange(location: 0, length: text.utf16.count)

			tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) {
				tag, tokenRange, stop in

				if let tag = tag, tags.contains(tag) {
					let name = (text as NSString).substring(with: tokenRange)
					print("\(book)".capitalized + " \(chapter):\(verse)")
					print("\(name): \(tag)")
					let src = UniffiSource(book: Book(name: book), chapter: UInt8(chapter)+1, verses: [UInt16(verse)+1, UInt16(verse)+1])
					index[name, default: []].append(src)
				}
			}
		}
	}
}

print(index)

do {
	let data = try encoder.encode(index)
	print(data)
	let fileManager = FileManager.default

	let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
	let fileURL = documentDirectory.appendingPathComponent("swift_index.json")

	do {
		try data.write(to: fileURL)
		print("file saved at: \(fileURL)")
	} catch {
		print("writing to file failed: \(error)")
	}
} catch {
	print("encoding failed: \(error)")
}


