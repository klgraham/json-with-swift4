// Swift 4
import Foundation

struct Car: Codable {
    var make: String
    var model: String
}

let taurus = Car(make: "Ford", model: "Taurus")

// encode the struct as JSON
var json: String?
let encoder = JSONEncoder()

if let encoded = try? encoder.encode(taurus) {
    if let jsonString = String(data: encoded, encoding: .utf8) {
        print(jsonString)
        json = jsonString
    }
}

// decode the JSON
let decoder = JSONDecoder()
if let jsonString = json {
    let jsonData = jsonString.data(using: .utf8)!
    if let decoded = try? decoder.decode(Car.self, from: jsonData) {
        print("Make: \(decoded.make)")
        print("Model: \(decoded.model)\n")
    }
}
