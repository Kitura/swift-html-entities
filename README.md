# swift-html-entities
HTML entities utility tool for Swift. Currently supports HTML4 entities. You can find the list of HTML4 entities [here](https://www.w3.org/TR/html4/sgml/entities.html).

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