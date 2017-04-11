/*
 * Copyright IBM Corporation 2017
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

// An extra test case to ensure that all other test cases include all of their
// tests in their respective `allTests` variable. This is to ensure that the
// same number of unit tests are executed on Linux as there are on OSX.
//
// Code adapted from https://oleb.net/blog/2017/03/keeping-xctest-in-sync/

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    import XCTest

    class LinuxSafeguardTest: XCTestCase {
        func testLinuxTestSuiteIncludesAllTests() {
            var linuxCount: Int
            var darwinCount: Int

            // HTMLEntitiesTests
            linuxCount = HTMLEntitiesTests.allTests.count
            darwinCount = Int(HTMLEntitiesTests.defaultTestSuite().testCaseCount)
            XCTAssertEqual(linuxCount, darwinCount, "\(darwinCount - linuxCount) tests are missing from HTMLEntitiesTests.allTests")
        }
    }
#endif
