// The Swift Programming Language
// https://docs.swift.org/swift-book
import Bible

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
