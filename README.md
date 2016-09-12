# swift-html-entities
HTML entities utility tool for Swift. Currently supports HTML4 entities. You can find the list of HTML4 entities [here](https://www.w3.org/TR/html4/sgml/entities.html).

**Note:** There is a known bug on Linux Swift toolchain that prevents the unicode characters

```swift
"\u{2003}":"&emsp;",
"\u{2009}":"&thinsp;",
"\u{200C}":"&zwnj;",
"\u{200D}":"&zwj;",
"\u{200E}":"&lrm;",
"\u{200F}":"&rlm;"
```
from being matched uniquely; i.e., `"\u{00AD}”, “\u{200C}”, "\u{200D}”, "\u{200E}”, "\u{200F}”` are all considered logically equivalent on Linux Swift toolchain. As such, all of these five unicode characters currently map to `"&shy;”` on Linux due to their co-equivalence.

## Usage

```swift
import HTMLEntities

// encode example
let html = "<script>alert(\"abc\")</script>"

html.asHTML4Entities() // "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

// decode example
let htmlencoded = "&lt;script&gt;alert(&quot;abc&quot;)&lt;/script&gt;"

htmlencoded.fromHTML4Entities() // "<script>alert(\"abc\")</script>"

```

## License

Apache 2.0