import SwiftyJSON

public struct User {
    public let id: String?
    public let name: String
    public let age: Double?

    public init(id: String?, name: String, age: Double?) {
        self.id = id
        self.name = name
        self.age = age
    }

    public init(json: JSON) throws {
        // Required properties
        guard json["name"].exists() else {
            throw ModelError.requiredPropertyMissing(name: "name")
        }
        guard let name = json["name"].string else {
            throw ModelError.propertyTypeMismatch(name: "name", type: "string", value: json["name"].description, valueType: String(describing: json["name"].type))
        }
        self.name = name

        // Optional properties
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        self.id = json["id"].string
        if json["age"].exists() &&
           json["age"].type != .number {
            throw ModelError.propertyTypeMismatch(name: "age", type: "number", value: json["age"].description, valueType: String(describing: json["age"].type))
        }
        self.age = json["age"].number.map { Double($0) }

        // Check for extraneous properties
        if let jsonProperties = json.dictionary?.keys {
            let properties: [String] = ["id", "name", "age"]
            for jsonPropertyName in jsonProperties {
                if !properties.contains(where: { $0 == jsonPropertyName }) {
                    throw ModelError.extraneousProperty(name: jsonPropertyName)
                }
            }
        }
    }

    public func settingID(_ newId: String?) -> User {
      return User(id: newId, name: name, age: age)
    }

    public func updatingWith(json: JSON) throws -> User {
        if json["id"].exists() &&
           json["id"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "id", type: "string", value: json["id"].description, valueType: String(describing: json["id"].type))
        }
        let id = json["id"].string ?? self.id

        if json["name"].exists() &&
           json["name"].type != .string {
            throw ModelError.propertyTypeMismatch(name: "name", type: "string", value: json["name"].description, valueType: String(describing: json["name"].type))
        }
        let name = json["name"].string ?? self.name

        if json["age"].exists() &&
           json["age"].type != .number {
            throw ModelError.propertyTypeMismatch(name: "age", type: "number", value: json["age"].description, valueType: String(describing: json["age"].type))
        }
        let age = json["age"].number.map { Double($0) } ?? self.age

        return User(id: id, name: name, age: age)
    }

    public func toJSON() -> JSON {
        var result = JSON([:])
        result["name"] = JSON(name)
        if let id = id {
            result["id"] = JSON(id)
        }
        if let age = age {
            result["age"] = JSON(age)
        }

        return result
    }
}
