/*
 * Copyright IBM Corporation 2016, 2017
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

extension Dictionary {
    /// Union of two dictionaries
    /// Note: The <key, value> in the argument will override
    /// the current dictionary's <key, value> if the keys match
    func updating(_ dict: [Key: Value]) -> [Key: Value] {
        var newDict = self

        for (key, value) in dict {
            newDict[key] = value
        }

        return newDict
    }
}

extension Dictionary where Value: Hashable {
    /// Invert a dictionary: <Key, Value> -> <Value, Key>
    /// Note: Does not check for uniqueness among values
    func inverting(_ pick: (Key, Key) -> Key = { existingValue, newValue in
        return newValue
        }) -> [Value: Key] {
        var inverseDict: [Value: Key] = [:]

        for (key, value) in self {
            if let existing = inverseDict[value] {
                inverseDict[value] = pick(existing, key)
            }
            else {
                inverseDict[value] = key
            }
        }

        return inverseDict
    }
}

extension UInt32 {
    var isAlphaNumeric: Bool {
        // unicode values of [0-9], [A-Z], and [a-z]
        return self.isNumeral || 0x41...0x5A ~= self || 0x61...0x7A ~= self
    }

    var isAmpersand: Bool {
        // unicode value of &
        return self == 0x26
    }

    var isASCII: Bool {
        // Less than 0x80
        return self < 0x80
    }

    /// https://www.w3.org/International/questions/qa-escapes#use
    var isAttributeSyntax: Bool {
        // unicode values of [", ']
        return self == 0x22 || self == 0x27
    }

    var isDisallowedReference: Bool {
        // unicode values of [0x1-0x8], [0xD-0x1F], [0x7F-0x9F], [0xFDD0-0xFDEF],
        // 0xB, 0xFFFE, 0xFFFF, 0x1FFFE, 0x1FFFF, 0x2FFFE, 0x2FFFF, 0x3FFFE, 0x3FFFF,
        // 0x4FFFE, 0x4FFFF, 0x5FFFE, 0x5FFFF, 0x6FFFE, 0x6FFFF, 0x7FFFE, 0x7FFFF,
        // 0x8FFFE, 0x8FFFF, 0x9FFFE, 0x9FFFF, 0xAFFFE, 0xAFFFF, 0xBFFFE, 0xBFFFF,
        // 0xCFFFE, 0xCFFFF, 0xDFFFE, 0xDFFFF, 0xEFFFE, 0xEFFFF, 0xFFFFE, 0xFFFFF,
        // 0x10FFFE, and 0x10FFFF
        return disallowedNumericReferences.contains(self)
    }

    var isHash: Bool {
        // unicode value of #
        return self == 0x23
    }

    var isHexNumeral: Bool {
        // unicode values of [0-9], [A-F], and [a-f]
        return isNumeral || 0x41...0x46 ~= self || 0x61...0x66 ~= self
    }

    var isNumeral: Bool {
        // unicode values of [0-9]
        return 0x30...0x39 ~= self
    }

    /// https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
    var isReplacementCharacterEquivalent: Bool {
        // UInt32 values of [0xD800-0xDFFF], (0x10FFFF-∞]
        return 0xD800...0xDFFF ~= self || 0x10FFFF < self
    }

    var isSafeASCII: Bool {
        return self.isASCII && !self.isAttributeSyntax && !self.isTagSyntax
    }

    var isSemicolon: Bool {
        // unicode value of ;
        return self == 0x3B
    }

    /// https://www.w3.org/International/questions/qa-escapes#use
    var isTagSyntax: Bool {
        // unicode values of [&, < , >]
        return self.isAmpersand || self == 0x3C || self == 0x3E
    }

    var isX: Bool {
        // unicode values of X and x
        return self == 0x58 || self == 0x78
    }
}
