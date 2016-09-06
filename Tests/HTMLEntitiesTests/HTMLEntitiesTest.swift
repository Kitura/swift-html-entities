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

class HTMLEntitiesTests: XCTestCase {
    func testEncode() {
        let html = "<script>alert(\"abc\")</script>"
        XCTAssertEqual(html.asHTMLEntities(), "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;")
    }

    func testDecode() {
        let htmlencoded = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"
        XCTAssertEqual(htmlencoded.fromHTMLEntities(), "<script>alert(\"abc\")</script>")
    }

    func testInveribility() {
        let html = "<script>alert(\"abc\")</script>"
        XCTAssertEqual(html.asHTMLEntities().fromHTMLEntities(), html)

        let htmlencoded = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"
        XCTAssertEqual(htmlencoded.fromHTMLEntities().asHTMLEntities(), htmlencoded)
    }

    func testEdgeCases() {
        let badentity = "&undefined;"
        XCTAssertEqual(badentity.fromHTMLEntities(), badentity)

        let missingsemicolon = "some text here &quot some more text here"
        XCTAssertEqual(missingsemicolon.fromHTMLEntities(), missingsemicolon)

        let embeddedentity = "&some text here &lt;script&gt; some more text here;"
        XCTAssertEqual(embeddedentity.fromHTMLEntities(), "&some text here <script> some more text here;")
    }

    static var allTests : [(String, (HTMLEntitiesTests) -> () throws -> Void)] {
        return [
            ("testEncode", testEncode),
            ("testDecode", testDecode),
            ("testInveribility", testInveribility),
            ("testEdgeCases", testEdgeCases)
        ]
    }
}
