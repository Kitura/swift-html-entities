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

/// Enums used to delineate the different kinds of parse errors
/// that may be encountered during HTML unescaping. See
/// https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references
/// for an explanation of the different parse errors.
public enum ParseError: Error {
    /// "If that number is one of the numbers in the first column of the following
    /// table, then this is a parse error."
    case DeprecatedNumericReference(String)

    /// "[I]f the number is in the range 0x0001 to 0x0008, 0x000D to 0x001F, 0x007F
    /// to 0x009F, 0xFDD0 to 0xFDEF, or is one of 0x000B, 0xFFFE, 0xFFFF, 0x1FFFE,
    /// 0x1FFFF, 0x2FFFE, 0x2FFFF, 0x3FFFE, 0x3FFFF, 0x4FFFE, 0x4FFFF, 0x5FFFE,
    /// 0x5FFFF, 0x6FFFE, 0x6FFFF, 0x7FFFE, 0x7FFFF, 0x8FFFE, 0x8FFFF, 0x9FFFE,
    /// 0x9FFFF, 0xAFFFE, 0xAFFFF, 0xBFFFE, 0xBFFFF, 0xCFFFE, 0xCFFFF, 0xDFFFE,
    /// 0xDFFFF, 0xEFFFE, 0xEFFFF, 0xFFFFE, 0xFFFFF, 0x10FFFE, or 0x10FFFF, then
    /// this is a parse error."
    case DisallowedNumericReference(String)

    /// This should NEVER be hit in code execution. If this error is thrown, then
    /// decoder has faulty logic
    case IllegalArgument(String)

    /// "[I]f the characters after the U+0026 AMPERSAND character (&) consist of
    /// a sequence of one or more alphanumeric ASCII characters followed by a
    /// U+003B SEMICOLON character (;), then this is a parse error."
    case InvalidNamedReference(String)

    /// "If no characters match the range, then don't consume any characters
    /// (and unconsume the U+0023 NUMBER SIGN character and, if appropriate,
    /// the X character). This is a parse error; nothing is returned."
    case MalformedNumericReference(String)

    /// "[I]f the next character is a U+003B SEMICOLON, consume that too.
    /// If it isn't, there is a parse error."
    case MissingSemicolon(String)

    /// "[I]f the number is in the range 0xD800 to 0xDFFF or is greater
    /// than 0x10FFFF, then this is a parse error."
    case OutsideValidUnicodeRange(String)
}
