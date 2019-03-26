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

/// This String extension provides utility functions to convert strings to their
/// HTML escaped equivalents and vice versa.
public extension String {
    /// Global HTML escape options
    struct HTMLEscapeOptions {
        /// Specifies if all ASCII characters should be skipped when escaping text
        public static var allowUnsafeSymbols = false

        /// Specifies if decimal escapes should be used instead of hexadecimal escapes
        public static var decimal = false

        /// Specifies if all characters should be escaped, even if some are safe characters
        public static var encodeEverything = false

        /// Specifies if named character references should be used whenever possible
        public static var useNamedReferences = false
    }

    // Private enum used by the parser state machine
    private enum EntityParseState {
        case Dec
        case Hex
        case Invalid
        case Named
        case Number
        case Unknown
    }

    /// Return string as HTML escaped by replacing non-ASCII and unsafe characters
    /// with their numeric character escapes, or if such exists, their HTML named
    /// character reference equivalents. For example, this function turns
    ///
    /// `"<script>alert("abc")</script>"`
    ///
    /// into
    ///
    /// `"&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"`
    ///
    /// You can view/change default option values globally via `String.HTMLEscapeOptions`.
    ///
    /// - Parameter allowUnsafeSymbols: Specifies if all ASCII characters should be skipped
    /// when escaping text. *Optional*
    /// - Parameter decimal: Specifies if decimal escapes should be used instead of
    /// hexadecimal escapes. *Optional*
    /// - Parameter encodeEverything: Specifies if all characters should be escaped, even if
    /// some are safe characters. *Optional*
    /// - Parameter useNamedReferences: Specifies if named character references
    /// should be used whenever possible. *Optional*
    func htmlEscape(allowUnsafeSymbols: Bool = HTMLEscapeOptions.allowUnsafeSymbols,
                           decimal: Bool = HTMLEscapeOptions.decimal,
                           encodeEverything: Bool = HTMLEscapeOptions.encodeEverything,
                           useNamedReferences: Bool = HTMLEscapeOptions.useNamedReferences)
        -> String {
            // result buffer
            var str: String = ""

            #if swift(>=3.2)
                let characters = self
            #else
                let characters = self.characters
            #endif

            for c in characters {
                let unicodes = String(c).unicodeScalars

                if !encodeEverything,
                    unicodes.count == 1,
                    let unicode = unicodes.first?.value,
                    unicode.isASCII && allowUnsafeSymbols || unicode.isSafeASCII {
                    // character consists of only one unicode,
                    // and is a safe ASCII character,
                    // or allowUnsafeSymbols is true
                    str += String(c)
                }
                else if useNamedReferences,
                    let entity = namedCharactersEncodeMap[c] {
                    // character has a named character reference equivalent
                    str += "&" + entity
                }
                else {
                    // all other cases:
                    // deconstruct character into unicodes,
                    // then escape each unicode individually
                    for scalar in unicodes {
                        let unicode = scalar.value

                        if !encodeEverything && unicode.isSafeASCII {
                            str += String(scalar)
                        }
                        else {
                            let codeStr = decimal ? String(unicode, radix: 10) :
                                "x" + String(unicode, radix: 16, uppercase: true)

                            str += "&#" + codeStr + ";"
                        }
                    }
                }
            }

            return str
    }

    /// Return string as HTML unescaped by replacing HTML character references with their
    /// unicode character equivalents. For example, this function turns
    ///
    /// `"&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"`
    ///
    /// into
    ///
    /// `"<script>alert(\"abc\")</script>"`
    ///
    /// - Parameter strict: Specifies if escapes MUST always end with `;`.
    /// - Throws: (Only if `strict == true`) The first `ParseError` encountered during parsing.
    func htmlUnescape(strict: Bool) throws -> String {
        // result buffer
        var str = ""

        // entity buffers
        var entityPrefix = ""
        var entity = ""

        // current parse state
        var state = EntityParseState.Invalid

        for u in self.unicodeScalars {
            let unicodeAsString = String(u)
            let unicode = u.value

            // nondeterminstic finite automaton for parsing entity
            switch state {
            case .Invalid:
                if unicode.isAmpersand {
                    // start of a possible character reference
                    state = .Unknown
                    entityPrefix = unicodeAsString
                }
                else {
                    // move unicode to result buffer
                    str += unicodeAsString
                }
            case .Unknown:
                // previously parsed &
                // need to determine type of character reference
                if unicode.isAmpersand {
                    // parsed & again
                    // move previous & to result buffer
                    str += unicodeAsString
                }
                else if unicode.isHash {
                    // numeric character reference
                    state = .Number
                    entityPrefix += unicodeAsString
                }
                else if unicode.isAlphaNumeric {
                    // named character reference
                    state = .Named

                    // move current unicode to entity buffer
                    entity += unicodeAsString
                }
                else {
                    // false alarm, not a character reference
                    // move back to invalid state
                    state = .Invalid

                    // move the consumed & and current unicode to result buffer
                    str += entityPrefix + unicodeAsString

                    // clear entityPrefix buffer
                    entityPrefix = ""
                }
            case .Number:
                // previously parsed &#
                // need to determine dec or hex
                if unicode.isAmpersand {
                    // parsed & again
                    if strict {
                        // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                        // "If no characters match the range, then don't consume any characters
                        // (and unconsume the U+0023 NUMBER SIGN character and, if appropriate,
                        // the X character). This is a parse error; nothing is returned."
                        throw ParseError.MalformedNumericReference(entityPrefix + unicodeAsString)
                    }

                    // move the consume &# to result buffer
                    str += entityPrefix

                    // move to unknown state
                    state = .Unknown
                    entityPrefix = unicodeAsString
                }
                else if unicode.isX {
                    // hexadecimal numeric character reference
                    state = .Hex
                    entityPrefix += unicodeAsString
                }
                else if unicode.isNumeral {
                    // decimal numeric character reference
                    state = .Dec
                    entity += unicodeAsString
                }
                else {
                    // false alarm, not a character reference
                    if strict {
                        // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                        // "If no characters match the range, then don't consume any characters
                        // (and unconsume the U+0023 NUMBER SIGN character and, if appropriate,
                        // the X character). This is a parse error; nothing is returned."
                        throw ParseError.MalformedNumericReference(entityPrefix + unicodeAsString)
                    }

                    // move the consumed &# and current unicode to result buffer
                    str += entityPrefix + unicodeAsString

                    // move to invalid state
                    state = .Invalid
                    entityPrefix = ""
                    entity = ""
                }
            case .Dec, .Hex:
                // previously parsed &#[0-9]+ or &#[xX][0-9A-Fa-f]*
                if state == .Dec && unicode.isNumeral || state == .Hex && unicode.isHexNumeral {
                    // greedy matching
                    // consume as many valid characters as possible before unescaping
                    entity += unicodeAsString
                }
                else {
                    // current character is not in matching range
                    if strict {
                        if entity == "" {
                            // no characters matching range was parsed
                            // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                            // "If no characters match the range, then don't consume any characters
                            // (and unconsume the U+0023 NUMBER SIGN character and, if appropriate,
                            // the X character). This is a parse error; nothing is returned."
                            throw ParseError.MalformedNumericReference(entityPrefix + unicodeAsString)
                        }

                        if !unicode.isSemicolon {
                            // entity did not end with ;
                            // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                            // "[I]f the next character is a U+003B SEMICOLON, consume that too.
                            // If it isn't, there is a parse error."
                            throw ParseError.MissingSemicolon(entityPrefix + entity)
                        }
                    }

                    let unescaped = try decode(entity: entity, entityPrefix: entityPrefix, strict: strict)

                    // append unescaped numeric reference to result buffer
                    str += unescaped

                    if unicode.isAmpersand {
                        // parsed & again
                        // move to unknown state
                        state = .Unknown
                        entityPrefix = unicodeAsString
                        entity = ""
                    }
                    else {
                        if !unicode.isSemicolon {
                            // move current unicode to result buffer
                            str += unicodeAsString
                        }

                        // move back to invalid state
                        state = .Invalid
                        entityPrefix = ""
                        entity = ""
                    }
                }
            case .Named:
                // previously parsed &[0-9A-Za-z]+
                if unicode.isAlphaNumeric {
                    // keep consuming alphanumeric unicodes
                    // only try to decode it when we encounter a nonalphanumeric unicode
                    entity += unicodeAsString
                }
                else {
                    if unicode.isSemicolon {
                        entity += unicodeAsString
                    }

                    // try to decode parsed chunk of alphanumeric unicodes
                    let unescaped = try decode(entity: entity, entityPrefix: entityPrefix, strict: strict)

                    str += unescaped

                    if unicode.isAmpersand {
                        // parsed & again
                        // move to unknown state
                        state = .Unknown
                        entityPrefix = unicodeAsString
                        entity = ""

                        break
                    }
                    else if !unicode.isSemicolon {
                        // move current unicode to result buffer
                        str += unicodeAsString
                    }

                    // move back to invalid state
                    state = .Invalid
                    entityPrefix = ""
                    entity = ""
                }
            }
        }

        // one more round of finite automaton to catch the edge case where the original string
        // ends with a character reference that isn't terminated by ;
        switch state {
        case .Dec, .Hex:
            // parsed a partial numeric character reference
            if strict {
                if entity == "" {
                    // no characters matching range was parsed
                    // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                    // "If no characters match the range, then don't consume any characters
                    // (and unconsume the U+0023 NUMBER SIGN character and, if appropriate,
                    // the X character). This is a parse error; nothing is returned."
                    throw ParseError.MalformedNumericReference(entityPrefix)
                }

                // by this point in code, entity is not empty and did not end with ;
                // if it did, the numeric character reference would've been unescaped inside the loop
                // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                // "[I]f the next character is a U+003B SEMICOLON, consume that too.
                // If it isn't, there is a parse error."
                throw ParseError.MissingSemicolon(entityPrefix + entity)
            }

            fallthrough
        case .Named:
            // parsed a partial character reference
            // unescape what we have left
            str += try decode(entity: entity, entityPrefix: entityPrefix, strict: strict)
        default:
            // all other states
            // dump partial buffers into result string
            str += entityPrefix + entity
        }

        return str
    }

    /// Return string as HTML unescaped by replacing HTML character references with their
    /// unicode character equivalents. For example, this function turns
    ///
    /// `"&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"`
    ///
    /// into
    ///
    /// `"<script>alert(\"abc\")</script>"`
    ///
    /// Equivalent to `htmlUnescape(strict: false)`, but does NOT throw parse error.
    func htmlUnescape() -> String {
        // non-strict mode should never throw error
        return try! self.htmlUnescape(strict: false)
    }
}

// Utility function to decode a single entity
fileprivate func decode(entity: String, entityPrefix: String, strict: Bool) throws -> String {
    switch entityPrefix {
    case "&#", "&#x", "&#X":
        // numeric character reference
        let radix = entityPrefix == "&#" ? 10 : 16

        if strict && entity == "" {
            // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
            // "If no characters match the range, then don't consume any characters
            // (and unconsume the U+0023 NUMBER SIGN character and, if appropriate,
            // the X character). This is a parse error; nothing is returned."
            throw ParseError.MalformedNumericReference(entityPrefix)
        }
        else if var code = UInt32(entity, radix: radix) {
            if code.isReplacementCharacterEquivalent {
                code = replacementCharacterAsUInt32

                if strict {
                    // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                    // "[I]f the number is in the range 0xD800 to 0xDFFF or is greater
                    // than 0x10FFFF, then this is a parse error."
                    throw ParseError.OutsideValidUnicodeRange(entityPrefix + entity)
                }
            }
            else if let c = deprecatedNumericDecodeMap[code] {
                code = c

                if strict {
                    // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                    // "If that number is one of the numbers in the first column of the
                    // following table, then this is a parse error."
                    throw ParseError.DeprecatedNumericReference(entityPrefix + entity)
                }
            }
            else if strict && code.isDisallowedReference {
                // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                // "[I]f the number is in the range 0x0001 to 0x0008, 0x000D to 0x001F, 0x007F
                // to 0x009F, 0xFDD0 to 0xFDEF, or is one of 0x000B, 0xFFFE, 0xFFFF, 0x1FFFE,
                // 0x1FFFF, 0x2FFFE, 0x2FFFF, 0x3FFFE, 0x3FFFF, 0x4FFFE, 0x4FFFF, 0x5FFFE,
                // 0x5FFFF, 0x6FFFE, 0x6FFFF, 0x7FFFE, 0x7FFFF, 0x8FFFE, 0x8FFFF, 0x9FFFE,
                // 0x9FFFF, 0xAFFFE, 0xAFFFF, 0xBFFFE, 0xBFFFF, 0xCFFFE, 0xCFFFF, 0xDFFFE,
                // 0xDFFFF, 0xEFFFE, 0xEFFFF, 0xFFFFE, 0xFFFFF, 0x10FFFE, or 0x10FFFF, then
                // this is a parse error."
                throw ParseError.DisallowedNumericReference(entityPrefix + entity)
            }

            return String(UnicodeScalar(code)!)
        }
        else {
            // Assume entity is nonempty and only contains valid characters for the given type
            // of numeric character reference. Given this assumption, at this point in the code
            // the numeric character reference must be greater than `UInt32.max`, i.e., it is
            // not representable by UInt32 (and it is, by transitivity, greater than 0x10FFFF);
            // therefore, the numeric character reference should be replaced by U+FFFD
            if strict {
                // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                // "[I]f the number is in the range 0xD800 to 0xDFFF or is greater
                // than 0x10FFFF, then this is a parse error."
                throw ParseError.OutsideValidUnicodeRange(entityPrefix + entity)
            }

            return String(UnicodeScalar(replacementCharacterAsUInt32)!)
        }
    case "&":
        // named character reference
        if entity == "" {
            return entityPrefix
        }

        if entity.hasSuffix(";") {
            // Step 1: check all other named characters first
            // Assume special case is rare, always check regular case first to minimize
            // search time cost amortization
            if let c = namedCharactersDecodeMap[entity] {
                return String(c)
            }

            // Step 2: check special named characters if entity didn't match any regular
            // named character references
            if let s = specialNamedCharactersDecodeMap[entity] {
                return s
            }
        }

        for length in legacyNamedCharactersLengthRange {
            #if swift(>=3.2)
                let count = entity.count
            #else
                let count = entity.characters.count
            #endif

            guard length <= count else {
                break
            }

            let upperIndex = entity.index(entity.startIndex, offsetBy: length)

            #if swift(>=3.2)
                let reference = String(entity[..<upperIndex])
            #else
                let reference = entity[entity.startIndex..<upperIndex]
            #endif

            if let c = legacyNamedCharactersDecodeMap[reference] {
                if strict {
                    // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
                    // "[A] character reference is parsed. If the last character matched is not a
                    // ";" (U+003B) character, there is a parse error."
                    throw ParseError.MissingSemicolon("&" + reference)
                }

                return String(c) + entity[upperIndex..<entity.endIndex]
            }
        }

        if strict && entity.hasSuffix(";") {
            // No name character reference matched; for the sake of simplicity, assume
            // entity can only contain alphanumeric characters with a semicolon at the end
            // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
            // "[I]f the characters after the U+0026 AMPERSAND character (&) consist of
            // a sequence of one or more alphanumeric ASCII characters followed by a
            // U+003B SEMICOLON character (;), then this is a parse error."
            throw ParseError.InvalidNamedReference(entityPrefix + entity)
        }
        
        return entityPrefix + entity
    default:
        // this should NEVER be hit in code execution
        // if this error is thrown, then decoder has faulty logic
        throw ParseError.IllegalArgument("Invaild entityPrefix: must be one of [\"&\", \"&#\", \"&#x\", \"&#X\"]")
    }
}
