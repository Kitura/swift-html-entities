#**HTMLEntities**

[![Build Status - Master](https://api.travis-ci.org/IBM-Swift/swift-html-entities.svg?branch=master)](https://travis-ci.org/IBM-Swift/swift-html-entities)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

## Summary
Pure Swift HTML encode/decode utility tool for Swift 3.0.

Now includes support for HTML5 named character references. You can find the list of all 2231 HTML5 named character references [here](https://www.w3.org/TR/html5/syntax.html#named-character-references).

`HTMLEntities` can escape ALL non-ASCII characters and ASCII non-print character (i.e. NUL, ESC, DEL), as well as the characters `<`, `>`, `&`, `"`, `’` as these five characters are part of the HTML tag and HTML attribute syntaxes.

In addition, `HTMLEntities` can unescape encoded HTML text that contains decimal, hexadecimal, or HTML5 named character references.

## Features

* Supports HTML5 named character references (`NegativeMediumSpace;` etc.)
* HTML5 spec-compliant; strict parse mode recognizes [parse errors](https://www.w3.org/TR/html5/syntax.html#tokenizing-character-references)
* Supports decimal and hexadecimal escapes for non-named characters
* Simple to use as functions are added by way of extending the default `String` class
* Minimal dependencies; implementation is completely self-contained

## Version Info

HTMLEntities 2.0 runs on Swift 3.0, on both macOS and Ubuntu Linux.

## Usage

### Install via Swift Package Manager (SPM)

```swift
import PackageDescription

let package = Package(
  name: "package-name",
  dependencies: [
    .Package(url: "https://github.com/IBM-Swift/swift-html-entities.git", majorVersion: 2, minor: 0)
  ]
)
```

### In code

```swift
import HTMLEntities

// encode example
let html = "<script>alert(\"abc\")</script>"

print(html.htmlEscape())
// Prints "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

// decode example
let htmlencoded = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

print(htmlencoded.htmlUnescape())
// Prints "<script>alert(\"abc\")</script>"
```

## Advanced Options

`HTMLEntities` supports various options when escaping and unescaping HTML characters.

### Escape Options

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

#### `useNamedReferences`

Defaults to `true`. Specifies if named character references should be used whenever possible. Set to `false` to always use numeric character references, i.e., for compatibility with older browsers that do not recognize named character references.

```swift
import HTMLEntities

let html = "<script>alert(\"abc\")</script>"

print(html.htmlEscape())
// Prints “&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;”

print(html.htmlEscape(useNamedReferences: false))
// Prints “&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;”
```

### Unescape Options

#### `strict`

Defaults to `false`. Specifies if HTML5 parse errors should be thrown or simply passed over. **NOTE**: `htmlUnescape()` is a throwing function if `strict` is used in call argument (no matter if it is set to `true` or `false`); `htmlUnescape()` is NOT a throwing function if no argument is provided.

```swift
import HTMLEntities

let text = "&#4370&#4449&#4523"

print(text.htmlUnescape())
// Prints “&#4370&#4449&#4523”

print(try text.htmlUnescape(strict: true))
// Throws a `ParseError.MissingSemicolon` instance
```

## License

Apache 2.0
