import JSONValue
import Testing

@Suite struct ParseTests {
    @Test func parseInteger() {
        let v = JSONValue.parse(#"{"min": 1}"#)!
        guard case let .object(obj) = v,
              case let .number(n) = obj["min"]! else {
            #expect(Bool(false), "min should be number, got \(v)")
            return
        }
        #expect(n == 1.0)
    }

    @Test func parseBool() {
        let v = JSONValue.parse(#"{"flag": true}"#)!
        guard case let .object(obj) = v,
              case let .bool(b) = obj["flag"]! else {
            #expect(Bool(false), "flag should be bool, got \(v)")
            return
        }
        #expect(b == true)
    }

    @Test func parseIntegerZero() {
        let v = JSONValue.parse(#"{"val": 0}"#)!
        guard case let .object(obj) = v,
              case let .number(n) = obj["val"]! else {
            #expect(Bool(false), "val should be number, got \(v)")
            return
        }
        #expect(n == 0.0)
    }

    @Test func jsonStringRoundtrip() {
        let original = JSONValue.parse(#"{"min":1,"max":100}"#)!
        let str = original.jsonString(sortedKeys: true)
        let roundtripped = JSONValue.parse(str)!
        #expect(original == roundtripped)
    }

    @Test func jsonStringSorted() {
        let v = JSONValue.parse(#"{"b":2,"a":1}"#)!
        let str = v.jsonString(sortedKeys: true)
        #expect(str == #"{"a":1,"b":2}"#)
    }
}

extension ParseTests {
    @Test func intValueFromNumber() {
        let v = JSONValue.parse(#"{"n": 42}"#)!
        guard case let .object(obj) = v else { return }
        #expect(obj["n"]?.intValue == 42)
    }

    @Test func intValueFromFractional() {
        let v = JSONValue.parse(#"{"n": 3.14}"#)!
        guard case let .object(obj) = v else { return }
        #expect(obj["n"]?.intValue == nil)
    }

    @Test func intValueFromBool() {
        #expect(JSONValue.bool(true).intValue == nil)
    }

    @Test func intValueFromString() {
        #expect(JSONValue.string("42").intValue == nil)
    }
}
