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

func writeJSONFile<T: Encodable>(encoder: JSONEncoder, obj: T, name: String) {
	do {
		let data = try encoder.encode(obj)
		let fileManager = FileManager.default

		let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
		let fileURL = documentDirectory.appendingPathComponent(name+".json")

		do {
			try data.write(to: fileURL)
			print("file saved at: \(fileURL)")
		} catch {
			print("writing to file failed: \(error)")
		}
	} catch {
		print("encoding failed: \(error)")
	}
}

let יֵשׁוּ = arcMorningStar()

print("\(יֵשׁוּ)")
print("\(יֵשׁוּ.names())")
print("\(boxMorningStar())")
print("\(boxMorningStar().names())")

arcGenealogy(daemon: יֵשׁוּ)

let word = Bible.getWord()
print("\(word)")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
writeJSONFile(encoder: encoder, obj: Dictionary(uniqueKeysWithValues: word.map { (k, v) in
	("\(k)".capitalized, v)
}), name: "swift_word")

let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)

let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
let tags: [NSLinguisticTag] = [.personalName]

var index: [String: [UniffiSource]] = [:]

for (book, chapter_and_verse) in word {
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
					let src = UniffiSource(book: UniffiBook(name: "\(book)".capitalized), chapter: UInt8(chapter)+1, verses: [UInt16(verse)+1, UInt16(verse)+1])
					index[name, default: []].append(src)
				}
			}
		}
	}
}

print(index)

writeJSONFile(encoder: encoder, obj: index, name: "swift_index")
