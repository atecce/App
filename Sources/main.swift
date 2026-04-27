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

let text = "John baptizes with water and Jesus baptizes with fire"
let tagger = NSLinguisticTagger(tagSchemes: [.nameType], options: 0)
tagger.string = text
let range = NSRange(location: 0, length: text.utf16.count)
let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
let tags: [NSLinguisticTag] = [.personalName]
tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) {
	tag, tokenRange, stop in

	if let tag = tag, tags.contains(tag) {
		let name = (text as NSString).substring(with: tokenRange)
		print("\(name): \(tag)")
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

for (name, chapter_and_verse) in bible {
	print("\(name)")
	for (chapter, verses) in chapter_and_verse.enumerated() {
		print("\(chapter) \(verses)")
	}
}

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
do {
	let data = try encoder.encode(bible)
	let fileManager = FileManager.default

	var documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
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
