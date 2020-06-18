
# cleansec: Cleanse Compiler

**IMPORTANT**: This tool and its associated components are experimental and under active development. There are no guarantees around stability.


This doc outlines the development and components of **cleansec**, a tool used to provide graph validations at build-time. Today, all graph validations (and plugin validations) are run upon construction of a graph's root component via `ComponentFactory.of` at runtime, throwing an exception if any errors are present.

### Why are build-time validations helpful?
One way to think about build-time validations is that it provides a form of type-safety to your object graph.  Instead of building your entire app and waiting for the simulator to launch and attach before throwing an exception, we can surface errors faster and in the same environment where you write your code. The benefits might not be dramatic if you only ever construct one object graph for one application. However, when we start constructing multiple object graphs that share parts of the DAG for different applications/targets, modifying the object graph in one application might break the graph in another app. Providing build-time validations shortens the error feedback loop and provides the guarantee that all types, objects, and dependencies will exist at runtime.

## Pieces
#### Getting Started
##### Building
Development is primarily done inside `cleansec.xcworkspace` where you can build and run each of the targets. Like any other project, you can archive a release build from within this workspace; however, you can also create a zipped release file containing the `cleansec` binary and `swiftc-ast.rb` script (lives inside `script/`, more info about this script later) by calling `make release`. 

##### Adding `cleansec` to your project
Adding `cleansec` to your project requires 2 steps.
1. Changing your `SWIFT_EXEC` build settings to point to `swiftc-ast.rb`.
2. Adding a new script phase to your target's Build Phases to run the `cleansec` binary.

For the first step, changing your `SWIFT_EXEC` to point at `swiftc-ast.rb` is important because that will emit the typed abstract syntax tree that is required for `cleansec` to parse. The script acts as a proxy that will compile your swift files as it normally would, but also spawns another process to `swiftc` using the `-dump-ast` mode. Once this is configured properly, another important step is configuring where to pipe the outputted AST file. By default, it will pipe the to stdout, but later on we will need the contents from `-dump-ast`, so we should store this in a file. We can do this by adding a new preprocessor macro (`GCC_PREPROCESSOR_DEFINITIONS`) named `AST_FILE=<path>`. The path could be anywhere, we store it in derived data.

The second step involves adding a new run script phase to your Build Phases. __This needs to come after the 'Compile Sources' phase__. This should run the `cleansec` binary, which requires a few options.
```bash
Usage: cleansec [--ast-file <ast-file> ...] --module-output-path <module-output-path> [--module-search-path <module-search-path> ...] [--plugin <plugin>] --module-name <module-name> [--emit-components]
```
__`--ast-file`__- Path(s) to the outputted file from `swiftc-ast.rb` described above that will be parsed. This will likely be the same as your `AST_FILE=<path>` preprocessor definition.  
__`--module-output-path`__- Path where the outputted JSON representation for all the parsed Cleanse types (modules, components, bindings etc.) will be stored. We store this in derived data.  
__`--module-search-path`__- Path(s) for where to find other JSON representations for parsed Cleanse types. This is required in order for the resolver to find Cleanse types created in other targets.  
__`--plugin`__- [Optional] Path to a parsing plugin if you need to create one.  
__`--module-name`__-Identifier for this target's JSON representation. We use `PRODUCT_NAME` here.  
__`--emit-components`__- [Optional] Flag that will give you a verbose output of anything that was resolved.  

It's important to note that `cleansec` will not perform any resolution until it finds a target that contains a `Cleanse.RootComponent`. We can only perform resolution once we have a full picture of the dependency graph.

##### Testing
The parsing step of `cleansec` depends on the output of the `-dump-ast` mode emitted from `swiftc`. This format can change between swift compiler versions and consequently Xcode versions. In order to make sure our parsing code works with each version of the swift compiler, we generate our `-dump-ast` fixtures and run our tests against these fixtures.

In order to bump these fixtures with the latest Xcode (or swift compiler) version, build the `Cleansec-Generate-Fixtures` target in `cleansec.xcworkspace`. This will modify the contents of `CleansecFrameworkTests/Fixtures/CodeFixtures.swift`. Once the fixtures are updated, you can validate by testing the `CleansecFrameworkTests` target.

---
#### `swiftc-ast.rb`
This script proxies to your normal `swiftc` compilation and also spawns another process to `swiftc` using the `-dump-ast` mode. This script is necessary because you cannot run normal compilation mode and `-dump-ast` mode at the same time. It also strips some options passed to normal compilation that cannot be passed to `-dump-ast`.

#### `CleansecFramework`
Library that implements the primary steps used by the `cleansec` binary. The pipeline is broken down into 3 steps: Analyzing, Linking, and Resolving. These steps (in addition to running a plugin path) are represented by the public interface below.

```swift
public struct Cleansec {
    public static func analyze(syntax: [Syntax]) -> ModuleRepresentation
    
    public static func link(modules: [ModuleRepresentation]) -> LinkedInterface
    
    public static func resolve(interface: LinkedInterface) -> [ResolvedComponent]
    
    public static func run(plugin path: String, astFilePath: String) -> ModuleRepresentation?
}
```

#### `SwiftAstParser`
Library responsible for parsing the contents from `-dump-ast` mode. You can learn more under [`SwiftAstParser/`](https://github.com/square/Cleanse/tree/master/cleansec/SwiftAstParser).
