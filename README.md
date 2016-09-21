# HTMLEntities
HTML character escape utility tool for Swift. Currently includes support for HTML4 named character references. You can find the list of all 252 HTML4 named character references [here](https://www.w3.org/TR/html4/sgml/entities.html).

`HTMLEntities` escapes ALL non-ASCII characters, as well as the characters `<`, `>`, `&`, `”`, `’` as these five characters are part of the HTML tag and HTML attribute syntaxes.

In additional, `HTMLEntities` can unescape encoded HTML text that contains decimal, hexadecimal, or HTML4 named character reference escapes. **NOTE:** The full set of HTML5 named character references is not yet supported.

## Usage

```swift
import HTMLEntities

// encode example
let html = "<script>alert(\"abc\")</script>"

print(html.htmlEscape())
// Prints ”&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

// decode example
let htmlencoded = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

print(htmlencoded.htmlUnescape())
// Prints ”<script>alert(\"abc\")</script>"
```

## Advanced Options

`HTMLEntities` supports various options when escaping and unescaping HTML characters.

### Escape Options

#### `decimal`

Defaults to `false`. Specifies if decimal character escapes should be used instead of hexadecimal character escapes whenever numeric character escape is used (i.e., does not affect named character references escapes). Using hexadecimal character escapes is recommended.

```swift
import HTMLEntities

let text = "한, 한, é, é, 🇺🇸"

print(text.htmlEscape())
// Prints “&#x1112;&#x1161;&#x11AB;, &#xD55C;, e&#x301;, &eacute;, &#x1F1FA;&#x1F1F8;”

print(text.htmlEscape(decimal: true))
// Prints “&#4370;&#4449;&#4523;, &#54620;, e&#769;, &eacute;, &#127482;&#127480;”
```

#### `useNamedReferences`

Defaults to `true`. Specifies if named character references should be used whenever possible. Set to `false` to always use numeric character escape, i.e., for compatibility with older browsers.

```swift
import HTMLEntities

let html = "<script>alert(\"abc\")</script>"

print(html.htmlEscape())
// Prints “&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;”

print(html.htmlEscape(userNamedReferences: false))
// Prints “&#x3C;script&#x3E;alert(&#x22;abc&#x22;)&#x3C;/script&#x3E;”
```

### Unescape Options

#### `strict`

Defaults to `true`. Specifies if HTML numeric character escapes MUST always end with `;`. Some browsers allow numeric character escapes (decimal and hexadecimal) to end without `;`. Always ending character escapes with `;` is recommended; however, for compatibility reasons, `HTMLEntities` allows non-strict ending for situations that require it.

```swift
import HTMLEntities

let text = "&#4370&#4449&#4523"

print(text.htmlUnescape())
// Prints “&#4370&#4449&#4523”

print(text.htmlUnescape(strict: false))
// Prints “한”
```

## License

Apache 2.0