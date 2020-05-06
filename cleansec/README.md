
# cleansec: Cleanse Compiler

**IMPORTANT**: This tool and its associated components are experimental and under active development. There are no guarantees around stability.


This doc outlines the development and components of **cleansec**, a tool used to provide graph validations at build-time. Today, all graph validations (and plugin validations) are run upon construction of a graph's root component via `ComponentFactory.of` at runtime, throwing an exception if any errors are present.

### Why are build-time validations helpful?
One way to think about build-time validations is that it provides a form of type-safety to your object graph.  Instead of building your entire app and waiting for the simulator to launch and attach before throwing an exception, we can surface errors faster and in the same environment where you write your code. The benefits might not be dramatic if you only ever construct one object graph for one application. However, when we start constructing multiple object graphs that share parts of the DAG for different applications/targets, modifying the object graph in one application might break the graph in another app. Providing build-time validations shortens the error feedback loop and provides the guarantee that all types, objects, and dependencies will exist at runtime.
