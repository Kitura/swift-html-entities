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

import XCTest
@testable import HTMLEntities

let replacementCharacterAsString = "\u{FFFD}"

/// HTML snippet
let str1Unescaped = "<script>alert(\"abc\")</script>"
let str1Escaped = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

/// Extended grapheme clusters with combined unicode scalars
let str2Unescaped = "한, 한, ế, ế, 🇺🇸"
let str2Escaped = "&#x1112;&#x1161;&#x11AB;, &#xD55C;, &#x1EBF;, e&#x302;&#x301;, &#x1F1FA;&#x1F1F8;"

/// Text with non-ASCII characters
let str3Unescaped = "Jako efektivnější se nám jeví pořádání tzv. Road Show prostřednictvím našich autorizovaných dealerů v Čechách a na Moravě, které proběhnou v průběhu září a října."
let str3Escaped = "Jako efektivn&ecaron;j&scaron;&iacute; se n&aacute;m jev&iacute; po&rcaron;&aacute;d&aacute;n&iacute; tzv. Road Show prost&rcaron;ednictv&iacute;m na&scaron;ich autorizovan&yacute;ch dealer&uring; v &Ccaron;ech&aacute;ch a na Morav&ecaron;, kter&eacute; prob&ecaron;hnou v pr&uring;b&ecaron;hu z&aacute;&rcaron;&iacute; a &rcaron;&iacute;jna."

class HTMLEntitiesTests: XCTestCase {
    func testNamedCharacterReferences() {

        XCTAssertEqual(specialNamedCharactersDecodeMap.count, 2)
        XCTAssertEqual(legacyNamedCharactersDecodeMap.count, 106)
        XCTAssertEqual(namedCharactersDecodeMap.count, 2123)
        XCTAssertEqual(legacyNamedCharactersLengthRange, 2...6)

        // make sure regular named character references can be escaped/unescaped
        for (character, reference) in namedCharactersEncodeMap {
            let unescaped = String(character)
            let escaped = "&" + reference

            XCTAssertEqual(try escaped.htmlUnescape(strict: true), unescaped)
        }

        // make sure legacy named character references can be unescaped in nonstrict mode,
        // and that the correct ParseError is thrown in strict mode
        for (reference, character) in legacyNamedCharactersDecodeMap {
            let unescaped = String(character)
            let escaped = "&" + reference

            XCTAssertEqual(escaped.htmlUnescape(), unescaped)

            do {
                _ = try escaped.htmlUnescape(strict: true)
                XCTFail("Did not throw error")
            }
            catch ParseError.MissingSemicolon {
                XCTAssert(true)
            }
            catch {
                XCTFail("Wrong error thrown")
            }
        }

        // make sure the two special named character references can be unescaped
        for (reference, string) in specialNamedCharactersDecodeMap {
            let unescaped = string
            let escaped = "&" + reference

            XCTAssertEqual(try escaped.htmlUnescape(strict: true), unescaped)
        }
    }

    func testNumericCharacterReferences() {
        XCTAssertEqual(deprecatedNumericDecodeMap.count, 28)
        XCTAssertEqual(disallowedNumericReferences.count, 94)

        // make sure the deprecated numeric references can be correctly unescaped in
        // nonstrict mode, and that the correct ParseError is thrown in strict mode
        for (left, right) in deprecatedNumericDecodeMap {
            let unescaped = String(UnicodeScalar(right)!)
            var decEscaped = "&#" + String(left)
            var hexEscaped = "&#x" + String(left, radix: 16)

            XCTAssertEqual(decEscaped.htmlUnescape(), unescaped)
            XCTAssertEqual(hexEscaped.htmlUnescape(), unescaped)

            decEscaped += ";"
            hexEscaped += ";"

            do {
                _ = try decEscaped.htmlUnescape(strict: true)
                XCTFail("Did not throw error")
            }
            catch ParseError.DeprecatedNumericReference {
                XCTAssert(true)
            }
            catch {
                XCTFail("Wrong error thrown")
            }

            do {
                _ = try hexEscaped.htmlUnescape(strict: true)
                XCTAssert(false)
            }
            catch ParseError.DeprecatedNumericReference {
                XCTAssert(true)
            }
            catch {
                XCTFail("Wrong error thrown")
            }
        }

        // make sure invalid ranges of unicode characters can be correctly unescaped
        // into U+FFFD in nonstrict mode, and that the correct ParseError is thrown
        // in strict mode
        func testReplacementCharacter(_ code: UInt64) {
            var decEscaped = "&#" + String(code)
            var hexEscaped = "&#x" + String(code, radix: 16)

            XCTAssertEqual(decEscaped.htmlUnescape(), replacementCharacterAsString)
            XCTAssertEqual(hexEscaped.htmlUnescape(), replacementCharacterAsString)

            decEscaped += ";"
            hexEscaped += ";"

            do {
                _ = try decEscaped.htmlUnescape(strict: true)
                XCTFail("Did not throw error")
            }
            catch ParseError.OutsideValidUnicodeRange {
                XCTAssert(true)
            }
            catch {
                XCTFail("Wrong error thrown")
            }

            do {
                _ = try hexEscaped.htmlUnescape(strict: true)
                XCTFail("Did not throw error")
            }
            catch ParseError.OutsideValidUnicodeRange {
                XCTAssert(true)
            }
            catch {
                XCTFail("Wrong error thrown")
            }
        }

        testReplacementCharacter(0xD800)
        testReplacementCharacter(0xDDDD)
        testReplacementCharacter(0xDFFF)
        testReplacementCharacter(0x10FFFF + 1)
        testReplacementCharacter(0xDDDDDD)
        testReplacementCharacter(UInt64(UInt32.max))
        testReplacementCharacter(0xDDDDDDDDDD)

        // make sure the disallowed numeric references can be correctly unescaped in
        // nonstrict mode, and that the correct ParseError is thrown in strict mode
        for unicode in disallowedNumericReferences {
            let unescaped = String(UnicodeScalar(unicode)!)
            var decEscaped = "&#" + String(unicode)
            var hexEscaped = "&#x" + String(unicode, radix: 16)

            XCTAssertEqual(decEscaped.htmlUnescape(), unescaped)
            XCTAssertEqual(hexEscaped.htmlUnescape(), unescaped)

            decEscaped += ";"
            hexEscaped += ";"

            do {
                _ = try decEscaped.htmlUnescape(strict: true)
                XCTFail("Did not throw error")
            }
            catch ParseError.DisallowedNumericReference {
                XCTAssert(true)
            }
            catch {
                XCTFail("Wrong error thrown")
            }

            do {
                _ = try hexEscaped.htmlUnescape(strict: true)
                XCTFail("Did not throw error")
            }
            catch ParseError.DisallowedNumericReference {
                XCTAssert(true)
            }
            catch {
                XCTFail("Wrong error thrown")
            }
        }
    }

    func testEncode() {
        XCTAssertEqual(str1Unescaped.htmlEscape(useNamedReferences: true), str1Escaped)
        XCTAssertEqual(str2Unescaped.htmlEscape(useNamedReferences: true), str2Escaped)
        XCTAssertEqual(str3Unescaped.htmlEscape(useNamedReferences: true), str3Escaped)
    }

    func testDecode() {
        XCTAssertEqual(try str1Escaped.htmlUnescape(strict: true), str1Unescaped)
        XCTAssertEqual(try str2Escaped.htmlUnescape(strict: true), str2Unescaped)
        XCTAssertEqual(try str3Escaped.htmlUnescape(strict: true), str3Unescaped)
    }

    func testInvertibility() {
        XCTAssertEqual(try str1Unescaped.htmlEscape().htmlUnescape(strict: true), str1Unescaped)
        XCTAssertEqual(try str1Unescaped.htmlEscape(useNamedReferences: true).htmlUnescape(strict: true), str1Unescaped)
        XCTAssertEqual(try str1Unescaped.htmlEscape(decimal: true).htmlUnescape(strict: true), str1Unescaped)

        XCTAssertEqual(try str2Unescaped.htmlEscape().htmlUnescape(strict: true), str2Unescaped)
        XCTAssertEqual(try str2Unescaped.htmlEscape(useNamedReferences: true).htmlUnescape(strict: true), str2Unescaped)
        XCTAssertEqual(try str2Unescaped.htmlEscape(decimal: true).htmlUnescape(strict: true), str2Unescaped)

        XCTAssertEqual(try str3Unescaped.htmlEscape().htmlUnescape(strict: true), str3Unescaped)
        XCTAssertEqual(try str3Unescaped.htmlEscape(useNamedReferences: true).htmlUnescape(strict: true), str3Unescaped)
        XCTAssertEqual(try str3Unescaped.htmlEscape(decimal: true).htmlUnescape(strict: true), str3Unescaped)
    }

    func testEdgeCases() {
        // empty string
        XCTAssertEqual("".htmlEscape(), "")
        XCTAssertEqual(try "".htmlUnescape(strict: true), "")

        // alphanumeric only
        let simpleString = "abcdefghijklmnopqrstuvwxyz1234567890"
        XCTAssertEqual(simpleString.htmlEscape(), simpleString)
        XCTAssertEqual(try simpleString.htmlUnescape(strict: true), simpleString)

        // extended grapheme cluster
        XCTAssertEqual("&#4370&#4449;&#4523".htmlUnescape(), "한")

        do {
            _ = try "&#4370&#4449;&#4523".htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.MissingSemicolon {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        // some undefined named character references
        let badEntity = "&some &text; here &lt;script&gt; some more; text here;"
        XCTAssertEqual(badEntity.htmlUnescape(), "&some &text; here <script> some more; text here;")

        do {
            _ = try badEntity.htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.InvalidNamedReference {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        // example from section "Anything Else" in
        // https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
        let legacyEmbedded = "I'm &notit; I tell you"
        XCTAssertEqual(legacyEmbedded.htmlUnescape(), "I'm ¬it; I tell you")

        do {
            _ = try legacyEmbedded.htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.MissingSemicolon {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        // unit test for fix to https://github.com/Kitura/swift-html-entities/issues/29
        XCTAssertEqual("&+&#4370&#4449;&#4523".htmlUnescape(), "&+한")

        // test various parse errors
        XCTAssertEqual(try "&&#x223E;&#x333;".htmlUnescape(strict: true), "&∾̳")
        XCTAssertEqual("&#&#x223E;&#x333;".htmlUnescape(), "&#∾̳")

        do {
            _ = try "&#&#x223E;&#x333;".htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.MalformedNumericReference {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        do {
            _ = try "&#abc".htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.MalformedNumericReference {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        do {
            _ = try "&#x".htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.MalformedNumericReference {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        XCTAssertEqual("&#123&#x223E;&#x333;".htmlUnescape(), "{∾̳")

        do {
            _ = try "&#123&#x223E;&#x333;".htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.MissingSemicolon {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        XCTAssertEqual("&#xABC&#x223E;&#x333;".htmlUnescape(), "઼∾̳")
    }

    func testREADMEExamples() {
        // escape example
        var html = "<script>alert(\"abc\")</script>"

        XCTAssertEqual(html.htmlEscape(), "&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;")

        // unescape examples
        let htmlencoded = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

        XCTAssertEqual(htmlencoded.htmlUnescape(), "<script>alert(\"abc\")</script>")

        // allowUnsafeSymbols
        html = "<p>\"café\"</p>"

        XCTAssertEqual(html.htmlEscape(), "&#x3C;p&#x3E;&#x22;caf&#xE9;&#x22;&#x3C;/p&#x3E;")
        XCTAssertEqual(html.htmlEscape(allowUnsafeSymbols: true), "<p>\"caf&#xE9;\"</p>")

        // decimal
        var text = "한, 한, ế, ế, 🇺🇸"

        XCTAssertEqual(text.htmlEscape(), "&#x1112;&#x1161;&#x11AB;, &#xD55C;, &#x1EBF;, e&#x302;&#x301;, &#x1F1FA;&#x1F1F8;")
        XCTAssertEqual(text.htmlEscape(decimal: true), "&#4370;&#4449;&#4523;, &#54620;, &#7871;, e&#770;&#769;, &#127482;&#127480;")

        // encodeEverything
        text = "A quick brown fox jumps over the lazy dog"

        XCTAssertEqual(text.htmlEscape(), "A quick brown fox jumps over the lazy dog")
        XCTAssertEqual(text.htmlEscape(encodeEverything: true), "&#x41;&#x20;&#x71;&#x75;&#x69;&#x63;&#x6B;&#x20;&#x62;&#x72;&#x6F;&#x77;&#x6E;&#x20;&#x66;&#x6F;&#x78;&#x20;&#x6A;&#x75;&#x6D;&#x70;&#x73;&#x20;&#x6F;&#x76;&#x65;&#x72;&#x20;&#x74;&#x68;&#x65;&#x20;&#x6C;&#x61;&#x7A;&#x79;&#x20;&#x64;&#x6F;&#x67;")
        XCTAssertEqual(text.htmlEscape(allowUnsafeSymbols: true, encodeEverything: true), "&#x41;&#x20;&#x71;&#x75;&#x69;&#x63;&#x6B;&#x20;&#x62;&#x72;&#x6F;&#x77;&#x6E;&#x20;&#x66;&#x6F;&#x78;&#x20;&#x6A;&#x75;&#x6D;&#x70;&#x73;&#x20;&#x6F;&#x76;&#x65;&#x72;&#x20;&#x74;&#x68;&#x65;&#x20;&#x6C;&#x61;&#x7A;&#x79;&#x20;&#x64;&#x6F;&#x67;")

        // useNamedReferences
        html = "<script>alert(\"abc\")</script>"

        XCTAssertEqual(html.htmlEscape(), "&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;")
        XCTAssertEqual(html.htmlEscape(useNamedReferences: true), "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;")

        // escape options
        let currentSetting = String.HTMLEscapeOptions.useNamedReferences
        String.HTMLEscapeOptions.useNamedReferences = true

        XCTAssertEqual(html.htmlEscape(), "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;")
        XCTAssertEqual(html.htmlEscape(useNamedReferences: false), "&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;")

        String.HTMLEscapeOptions.useNamedReferences = currentSetting

        // strict
        text = "&#4370&#4449&#4523"

        XCTAssertEqual(text.htmlUnescape(), "한")

        do {
            _ = try text.htmlUnescape(strict: true)
            XCTFail("Did not throw error")
        }
        catch ParseError.MissingSemicolon {
            XCTAssert(true)
        }
        catch {
            XCTFail("Wrong error thrown")
        }

        XCTAssertEqual(try text.htmlUnescape(strict: false), "한")
    }

    static var allTests : [(String, (HTMLEntitiesTests) -> () throws -> Void)] {
        return [
            ("testNamedCharacterReferences", testNamedCharacterReferences),
            ("testNumericCharacterReferences", testNumericCharacterReferences),
            ("testEncode", testEncode),
            ("testDecode", testDecode),
            ("testInvertibility", testInvertibility),
            ("testEdgeCases", testEdgeCases),
            ("testREADMEExamples", testREADMEExamples)
        ]
    }
}
