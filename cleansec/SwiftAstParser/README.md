# SwiftAstParser

Parsing tool to inspect and traverse the typed-AST generated by `swiftc -dump-ast` mode. This tool is helpful if you would like to inspect the fully typed AST tree when `swift-syntax` or `SourceKit` doesn't provide the information you need. It's important to note that the `-dump-ast` output is not stable and changes between swift versions, which means any parsing implementations written on top of this library may break between swift versions. There are some discussions that discourage parsing the `-dump-ast` output due to no guarantees around stability, and it appears that [`libSyntax` would ideally handle this role one day](https://github.com/apple/swift/tree/master/lib/Syntax), so use this tool at your own risk if you find it useful.

### API
_Note:_ API is influenced heavily by Apple's [swift-syntax](https://github.com/apple/swift-syntax)

#### SyntaxParser
Object responsible for parsing `Data` or raw `String` input from the emitted `-dump-ast` mode.
* `public static func parse(data: Data) -> [Syntax]`
* `public static func parse(text: String) -> [Syntax]`

#### SyntaxVisitor
Provide an implementation conforming to `SyntaxVisitor` to traverse any `Syntax` node and its children.

Once you create a `SyntaxVisitor` implementation, you can walk a `Syntax` node by calling `walk(_:)` on it.
