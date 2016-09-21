/*
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/// Invert a dictionary: <Key, Value> -> <Value, Key>
/// Note: Does not check for uniqueness among values
func invert<K, V: Hashable>(_ dict: [K: V]) -> [V: K] {
    var inverseDict: [V: K] = [:]

    for (key, value) in dict {
        inverseDict[value] = key
    }

    return inverseDict
}

extension UInt32 {
    var isAlpha: Bool {
        // ASCII values of [A-Z] and [a-z]
        return 65...90 ~= self || 97...122 ~= self
    }

    var isAmpersand: Bool {
        // ASCII value of &
        return self == 38
    }

    var isASCII: Bool {
        // Less than 2^7
        return self < 128
    }

    /// https://www.w3.org/International/questions/qa-escapes#use
    var isAttributeSyntax: Bool {
        // ASCII values of [", ']
        return self == 34 || self == 39
    }

    var isHash: Bool {
        // ASCII value of #
        return self == 35
    }

    var isHexNumeral: Bool {
        // ASCII values of [0-9], [A-F], and [a-f]
        return isNumeral || 65...70 ~= self || 97...102 ~= self
    }

    var isNumeral: Bool {
        // ASCII values of [0-9]
        return 48...57 ~= self
    }

    var isSemicolon: Bool {
        // ASCII value of ;
        return self == 59
    }

    /// https://www.w3.org/International/questions/qa-escapes#use
    var isTagSyntax: Bool {
        // ASCII values of [&, < , >]
        return self == 38 || self == 60 || self == 62
    }

    var isX: Bool {
        // ASCII values of X and x
        return self == 88 || self == 120
    }

    func isValidEntityUnicode(for state: EntityParseState) -> Bool {
        switch state {
        case .Dec:
            return self.isNumeral
        case .Hex:
            return self.isHexNumeral
        case .Named:
            return self.isAlpha
        default:
            return false
        }
    }
}

enum EntityParseState {
    case Dec
    case Hex
    case Invalid
    case Named
    case Number
    case Unknown
}
