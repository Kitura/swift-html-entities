# HTMLEntities

[![Build Status - Master](https://api.travis-ci.org/IBM-Swift/swift-html-entities.svg?branch=master)](https://travis-ci.org/IBM-Swift/swift-html-entities)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)
[![codecov](https://codecov.io/gh/IBM-Swift/swift-html-entities/branch/master/graph/badge.svg)](https://codecov.io/gh/IBM-Swift/swift-html-entities)

## Summary
Pure Swift HTML encode/decode utility tool for Swift 3.

Now includes support for HTML5 named character references. You can find the list of all 2231 HTML5 named character references [here](https://www.w3.org/TR/html5/syntax.html#named-character-references).

`HTMLEntities` can escape ALL non-ASCII characters as well as the characters `<`, `>`, `&`, `"`, `’`, as these five characters are part of the HTML tag and HTML attribute syntaxes.

In addition, `HTMLEntities` can unescape encoded HTML text that contains decimal, hexadecimal, or HTML5 named character references.

## Features

* Supports HTML5 named character references (`NegativeMediumSpace;` etc.)
* HTML5 spec-compliant; strict parse mode recognizes [parse errors](https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references)
* Supports decimal and hexadecimal escapes for all characters
* Simple to use as functions are added by way of extending the default `String` class
* Minimal dependencies; implementation is completely self-contained

## Version Info

HTMLEntities 3.0 runs on Swift 3, on both macOS and Ubuntu Linux.

## Usage

### Install via Swift Package Manager (SPM)

Add `HTMLEntities` to your `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "<package-name>",
  dependencies: [
    .Package(url: "https://github.com/IBM-Swift/swift-html-entities.git", majorVersion: 3, minor: 0)
  ]
)
```

### In code

```swift
import HTMLEntities

// encode example
let html = "<script>alert(\"abc\")</script>"

print(html.htmlEscape())
// Prints "&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;"

// decode example
let htmlencoded = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

print(htmlencoded.htmlUnescape())
// Prints "<script>alert(\"abc\")</script>"
```

## Advanced Options

`HTMLEntities` supports various options when escaping and unescaping HTML characters.

### Escape Options

#### `allowUnsafeSymbols`

Defaults to `false`. Specifies if unsafe ASCII characters should be skipped or not.

```swift
import HTMLEntities

let html = "<p>\"café\"</p>"

print(html.htmlEscape())
// Prints "&#x3C;p&#x3E;&#x22;caf&#xE9;&#x22;&#x3C;/p&#x3E;"

print(html.htmlEscape(allowUnsafeSymbols: true))
// Prints "<p>\"caf&#xE9;\"</p>"

```

#### `decimal`

Defaults to `false`. Specifies if decimal character escapes should be used instead of hexadecimal character escapes whenever numeric character escape is used (i.e., does not affect named character references escapes). The use of hexadecimal character escapes is recommended.

```swift
import HTMLEntities

let text = "한, 한, ế, ế, 🇺🇸"

print(text.htmlEscape())
// Prints "&#x1112;&#x1161;&#x11AB;, &#xD55C;, &#x1EBF;, e&#x302;&#x301;, &#x1F1FA;&#x1F1F8;"

print(text.htmlEscape(decimal: true))
// Prints "&#4370;&#4449;&#4523;, &#54620;, &#7871;, e&#770;&#769;, &#127482;&#127480;"
```

#### `encodeEverything`

Defaults to `false`. Specifies if all characters should be escaped, even if some characters are safe. If `true`, overrides the setting for `allowUnsafeSymbols`.

```swift
import HTMLEntities

let text = "A quick brown fox jumps over the lazy dog"

print(text.htmlEscape())
// Prints "A quick brown fox jumps over the lazy dog"

print(text.htmlEscape(encodeEverything: true))
// Prints "&#x41;&#x20;&#x71;&#x75;&#x69;&#x63;&#x6B;&#x20;&#x62;&#x72;&#x6F;&#x77;&#x6E;&#x20;&#x66;&#x6F;&#x78;&#x20;&#x6A;&#x75;&#x6D;&#x70;&#x73;&#x20;&#x6F;&#x76;&#x65;&#x72;&#x20;&#x74;&#x68;&#x65;&#x20;&#x6C;&#x61;&#x7A;&#x79;&#x20;&#x64;&#x6F;&#x67;"

// `encodeEverything` overrides `allowUnsafeSymbols`
print(text.htmlEscape(allowUnsafeSymbols: true, encodeEverything: true))
// Prints "&#x41;&#x20;&#x71;&#x75;&#x69;&#x63;&#x6B;&#x20;&#x62;&#x72;&#x6F;&#x77;&#x6E;&#x20;&#x66;&#x6F;&#x78;&#x20;&#x6A;&#x75;&#x6D;&#x70;&#x73;&#x20;&#x6F;&#x76;&#x65;&#x72;&#x20;&#x74;&#x68;&#x65;&#x20;&#x6C;&#x61;&#x7A;&#x79;&#x20;&#x64;&#x6F;&#x67;"
```

#### `useNamedReferences`

Defaults to `false`. Specifies if named character references should be used whenever possible. Set to `false` to always use numeric character references, i.e., for compatibility with older browsers that do not recognize named character references.

```swift
import HTMLEntities

let html = "<script>alert(\"abc\")</script>"

print(html.htmlEscape())
// Prints “&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;”

print(html.htmlEscape(useNamedReferences: true))
// Prints “&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;”
```

#### Set escape options globally

HTML escape options can be set globally so that you don't have to set them everytime you want to escape a string. The options are managed in the `String.HTMLEscapeOptions` struct.

```swift
import HTMLEntities

// set `useNamedReferences` to `true` globally
String.HTMLEscapeOptions.useNamedReferences = true

let html = "<script>alert(\"abc\")</script>"

// Now, the default behavior of `htmlEscape()` is to use named character references
print(html.htmlEscape())
// Prints “&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;”

// And you can still go back to using numeric character references only
print(html.htmlEscape(useNamedReferences: false))
// Prints "&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;"
```

### Unescape Options

#### `strict`

Defaults to `false`. Specifies if HTML5 parse errors should be thrown or simply passed over.

**Note**: `htmlUnescape()` is a throwing function if `strict` is used in call argument (no matter if it is set to `true` or `false`); `htmlUnescape()` is NOT a throwing function if no argument is provided.

```swift
import HTMLEntities

let text = "&#4370&#4449&#4523"

print(text.htmlUnescape())
// Prints "한"

print(try text.htmlUnescape(strict: true))
// Throws a `ParseError.MissingSemicolon` instance

// a throwing function because `strict` is passed in argument
// but no error is thrown because `strict: false`
print(try text.htmlUnescape(strict: false))
// Prints "한"
```

## Acknowledgments

`HTMLEntities` was designed to support some of the same options as [`he`](https://github.com/mathiasbynens/he), a popular Javascript HTML encoder/decoder.

## License

Apache 2.0
