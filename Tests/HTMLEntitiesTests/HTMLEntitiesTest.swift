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

/// Generated from the list of HTML4 entities here:
/// https://www.w3.org/TR/html4/sgml/entities.html

import XCTest
@testable import HTMLEntities

/// HTML snippet
let str1Unescaped = "<script>alert(\"abc\")</script>"
let str1Escaped = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

/// Extended grapheme clusters with combined unicode scalars
let str2Unescaped = "한, 한, é, é, 🇺🇸"
let str2Escaped = "&#x1112;&#x1161;&#x11AB;, &#xD55C;, e&#x301;, &eacute;, &#x1F1FA;&#x1F1F8;"

/// Text with non-ASCII characters
let str3Unescaped = "Jako efektivnější se nám jeví pořádání tzv. Road Show prostřednictvím našich autorizovaných dealerů v Čechách a na Moravě, které proběhnou v průběhu září a října."
let str3Escaped = "Jako efektivn&#x11B;j&#x161;&#xED; se n&#xE1;m jev&#xED; po&#x159;&#xE1;d&#xE1;n&#xED; tzv. Road Show prost&#x159;ednictv&#xED;m na&#x161;ich autorizovan&#xFD;ch dealer&#x16F; v &#x10C;ech&#xE1;ch a na Morav&#x11B;, kter&#xE9; prob&#x11B;hnou v pr&#x16F;b&#x11B;hu z&#xE1;&#x159;&#xED; a &#x159;&#xED;jna."

class HTMLEntitiesTests: XCTestCase {
    func testEncode() {
        XCTAssertEqual(str1Unescaped.htmlEscape(), str1Escaped)
        XCTAssertEqual(str2Unescaped.htmlEscape(), str2Escaped)
        XCTAssertEqual(str3Unescaped.htmlEscape(useNamedReferences: false), str3Escaped)
    }

    func testDecode() {
        XCTAssertEqual(str1Escaped.htmlUnescape(), str1Unescaped)
        XCTAssertEqual(str2Escaped.htmlUnescape(), str2Unescaped)
        XCTAssertEqual(str3Escaped.htmlUnescape(), str3Unescaped)
    }

    func testInvertibility() {
        XCTAssertEqual(str1Unescaped.htmlEscape().htmlUnescape(), str1Unescaped)
        XCTAssertEqual(str1Unescaped.htmlEscape(useNamedReferences: false).htmlUnescape(), str1Unescaped)
        XCTAssertEqual(str1Unescaped.htmlEscape(decimal: true, useNamedReferences: false).htmlUnescape(), str1Unescaped)

        XCTAssertEqual(str2Unescaped.htmlEscape().htmlUnescape(), str2Unescaped)
        XCTAssertEqual(str2Unescaped.htmlEscape(useNamedReferences: false).htmlUnescape(), str2Unescaped)
        XCTAssertEqual(str2Unescaped.htmlEscape(decimal: true, useNamedReferences: false).htmlUnescape(), str2Unescaped)

        XCTAssertEqual(str2Unescaped.htmlEscape().htmlUnescape(), str2Unescaped)
        XCTAssertEqual(str3Unescaped.htmlEscape(useNamedReferences: false).htmlUnescape(), str3Unescaped)
        XCTAssertEqual(str3Unescaped.htmlEscape(decimal: true, useNamedReferences: false).htmlUnescape(), str3Unescaped)
    }

    func testEdgeCases() {
        let emptyString = ""
        XCTAssertEqual(emptyString.htmlEscape(), emptyString)
        XCTAssertEqual(emptyString.htmlUnescape(), emptyString)

        let noSemicolonEnding = "&#4370&#4449&#4523"
        XCTAssertEqual(noSemicolonEnding.htmlUnescape(), noSemicolonEnding)
        XCTAssertEqual(noSemicolonEnding.htmlUnescape(strict: false), "한")

        let mixedEnding = "&#4370&#4449;&#4523"
        XCTAssertEqual(mixedEnding.htmlUnescape(), "&#4370ᅡ&#4523")
        XCTAssertEqual(mixedEnding.htmlUnescape(strict: false), "한")

        let undefinedNameReference = "&undefined;"
        XCTAssertEqual(undefinedNameReference.htmlUnescape(), undefinedNameReference)

        let missingsemicolon = "some text here &quot some more text here"
        XCTAssertEqual(missingsemicolon.htmlUnescape(), missingsemicolon)

        let embeddedentity = "&some &text; here &lt;script&gt; some more; text here;"
        XCTAssertEqual(embeddedentity.htmlUnescape(), "&some &text; here <script> some more; text here;")

        let simpleString = "abcdefghijklmnopqrstuvwxyz1234567890"
        XCTAssertEqual(simpleString.htmlEscape(), simpleString)
        XCTAssertEqual(simpleString.htmlUnescape(), simpleString)

        let fakeIt1 = "&&#x223E;&#x333;"
        XCTAssertEqual(fakeIt1.htmlUnescape(), "&∾̳")

        let fakeIt2 = "&#&#x223E;&#x333;"
        XCTAssertEqual(fakeIt2.htmlUnescape(), "&#∾̳")

        let fakeIt3 = "&lt&#x223E;&#x333;"
        XCTAssertEqual(fakeIt3.htmlUnescape(), "&lt∾̳")

        let fakeIt4 = "&#123&#x223E;&#x333;"
        XCTAssertEqual(fakeIt4.htmlUnescape(), "&#123∾̳")
        XCTAssertEqual(fakeIt4.htmlUnescape(strict: false), "{∾̳")

        let fakeIt5 = "&#xABC&#x223E;&#x333;"
        XCTAssertEqual(fakeIt5.htmlUnescape(), "&#xABC∾̳")
        XCTAssertEqual(fakeIt5.htmlUnescape(strict: false), "઼∾̳")
    }

    static var allTests : [(String, (HTMLEntitiesTests) -> () throws -> Void)] {
        return [
            ("testEncode", testEncode),
            ("testDecode", testDecode),
            ("testInvertibility", testInvertibility),
            ("testEdgeCases", testEdgeCases)
        ]
    }
}
