// The Swift Programming Language
// https://docs.swift.org/swift-book
import Bible

func arc_genealogy(daemon: ArcDaemon?) {
	var cur = daemon!.father()
	while cur != nil {
		print(cur!.names())
		cur = cur!.father()
	}
}

let יֵשׁוּ = arcRootAndOffspringOfDavid()

print("\(יֵשׁוּ)")
print("\(יֵשׁוּ.names())")
print("\(boxRootAndOffspringOfDavid())")
print("\(boxRootAndOffspringOfDavid().names())")

arc_genealogy(daemon: יֵשׁוּ)
