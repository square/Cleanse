Cleanse - Swift Dependency Injection
====================================

.. image:: Documentation/cleanse_logo_small.png
  :align: right


.. image:: https://travis-ci.org/square/Cleanse.svg?branch=master
  :target: https://travis-ci.org/square/Cleanse

.. image:: https://coveralls.io/repos/github/square/Cleanse/badge.svg?branch=master&asdf
  :target: https://coveralls.io/github/square/Cleanse?branch=master


Cleanse is a `dependency injection`_ framework for Swift. It is designed from the ground-up with *developer experience*
in mind. It takes inspiration from both `Dagger`_ and `Guice`_.

.. _dependency injection: https://en.wikipedia.org/wiki/Dependency_injection
.. _Guice: https://github.com/google/guice
.. _Dagger: http://google.github.io/dagger/

Getting Started
---------------
This is a quick guide on how to get started using Cleanse in your application.

A full-fledged example of using Cleanse with Cocoa Touch can be found in ``Examples/CleanseGithubBrowser``

Installation
````````````
Using `CocoaPods`_
~~~~~~~~~~~~~~~~~~~
You can pull in the latest Cleanse version into your ``Podfile`` using

``pod 'Cleanse'``

.. _CocoaPods: https://github.com/cocoapods/cocoapods/

Using Xcode
~~~~~~~~~~~
``Cleanse.xcodeproj`` can be dragged and dropped into an existing project or workspace in Xcode.
One may add ``Cleanse.framework`` as a target dependency and embed it.

Using `Carthage`_
~~~~~~~~~~~~~~~~~
Cleanse should be able to be configured with `Carthage`_. One should be able to follow the
`Adding Frameworks to an Application`_ from `Carthage's README`_ to successfully do this.

.. _Adding Frameworks to an Application: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application
.. _Carthage's README: https://github.com/Carthage/Carthage/blob/master/README.md
.. _Carthage: https://github.com/Carthage/Carthage/

Using `Swift Package Manager`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cleanse can be used with `Swift Package Manager`_. The following a definition that can be added to the dependencies 
of a ``Project`` declaration. Adding `Cleanse` as a package dependency in Xcode 11 is supported by v4.2.5 and above.

.. _Swift Package Manager: https://github.com/apple/swift-package-manager

Features
--------
=================================== =================================
   Feature                          Cleanse Implementation Status
=================================== =================================
Multi-Bindings                      Supported (``.intoCollection()``)
Overrides                           Supported
Objective-C Compatibility layer     Supported
Property Injection [#pinj]_         Supported
Type Qualifiers                     Supported via `Type Tags`_
`Assisted Injection`_               Supported
`Subcomponents`_                    Supported via `Components`_
`Service Provider Interface`_       Supported
`cleansec`_ (Cleanse Compiler)      Experimental
=================================== =================================

.. [#pinj] Property injection is known as `field injection`_ in other DI frameworks

.. _Subcomponents: http://google.github.io/dagger/subcomponents.html
.. _cleansec: https://github.com/square/Cleanse/tree/master/cleansec
.. _field injection: https://github.com/google/guice/wiki/Injections#field-injection

Another very important part of a DI framework is how it handles errors. Failing fast is ideal. Cleanse is designed to
support fast failure. It currently supports fast failing for some of the more common errors, but it isn't complete

=================================== =================================
   Error Type                       Cleanse Implementation Status
=================================== =================================
Missing Providers                   Supported [#f1]_
Duplicate Bindings                  Supported
Cycle Detection                     Supported
=================================== =================================

.. [#f1] When a provider is missing, errors present line numbers, etc. where the provider was required. Cleanse
        will also collect all errors before failing

Using Cleanse
`````````````
The Cleanse API is in a Swift module called ``Cleanse`` (surprised?). To use any of its API in a file, at the top,
one must import it.

.. code-block:: swift

  import Cleanse

Defining a Component and Root Type
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Cleanse is responsible for building a graph (or more specifically a `directed acyclic graph`_) that represents all of your dependencies.
This graph starts with a root object which is connected to its immediate dependencies, and those dependencies hold edges to its dependencies and so on until we have a complete picture of your application's object graph.

.. _`directed acyclic graph`: https://en.wikipedia.org/wiki/Directed_acyclic_graph

The entry point into managing your dependencies with Cleanse starts by defining a "Root" object that is returned to you upon construction. In a Cocoa Touch application, our root object could be the ``rootViewController`` object we set on the application's ``UIWindow``. *(More logically the root object is the App Delegate, however since since we don't control construction of that we would have to use Property Injection. You can read more about this in the* `Advanced Setup`_ *guide)*

Let's begin by defining the ``RootComponent``:


.. code-block:: swift

  struct Component : Cleanse.RootComponent {
      // When we call build(()) it will return the Root type, which is a RootViewController instance.
      typealias Root = RootViewController

      // Required function from Cleanse.RootComponent protocol.
      static func configureRoot(binder bind: ReceiptBinder<RootViewController>) -> BindingReceipt<RootViewController> {

      }

      // Required function from Cleanse.RootComponent protocol.
      static func configure(binder: Binder<Unscoped>) {
          // We will fill out contents later.
      }
  }

After creating our root component, we find that we're required to implement two functions:
``static func configureRoot(binder bind: ReceiptBinder<RootViewController>) -> BindingReceipt<RootViewController>`` and ``static func configure(binder: Binder<Unscoped>)``. These functions are very important because they will contain the logic for how we construct every object/dependency in our app. The parameters and return types are confusing right now, but will make more sense as we go along.

The first function is required of any `Component` since it tells Cleanse how to construct the root object. Let's fill in the contents to configure how we will construct our ``RootViewController``.

.. code-block:: swift

  static func configureRoot(binder bind: ReceiptBinder<RootViewController>) -> BindingReceipt<RootViewController> {
      return bind.to(factory: RootViewController.init)
  }


Now, let's create our ``RootViewController`` class

.. code-block:: swift

  class RootViewController: UIViewController {
      init() {
          super.init(nibName: nil, bundle: nil)
      }

      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      override func viewDidLoad() {
          super.viewDidLoad()
          self.view.backgroundColor = .blue
      }
  }


We've successfully wired up our root component! Our root object ``RootViewController`` is configured properly, so in our App Delegate we can now `build` the component (and graph) to use it.

**Important**: It is important that you retain an instance of the `ComponentFactory<E>` returned from `ComponentFactory.of(:)`. Otherwise subcomponents may unexpectedly become deallocated.

.. code-block:: swift

    // IMPORTANT: We must retain an instance of our `ComponentFactory`.
    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        var factory: ComponentFactory<AppDelegate.Component>?

        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) ->  Bool {
            // Build our root object in our graph.
            factory = try! ComponentFactory.of(AppDelegate.Component.self)
            let rootViewController = factory!.build(())

            // Now we can use the root object in our app.
            window!.rootViewController = rootViewController
            window!.makeKeyAndVisible()

            return true
        }

Satisfying Dependencies
~~~~~~~~~~~~~~~~~~~~~~~

Running the app will now display our ``RootViewController`` with a blue background. However this is not very interesting nor realistic as our ``RootViewController`` will likely require many dependencies to set up our app. So let's create a simple dependency ``RootViewProperties`` that will hold the background color of our root view (among other future properties).

.. code-block:: swift

  struct RootViewProperties {
      let backgroundColor: UIColor
  }

And then inject ``RootViewProperties`` into our ``RootViewContoller`` and set the background color.

.. code-block:: swift

  class RootViewController: UIViewController {
      let rootViewProperties: RootViewProperties
      init(rootViewProperties: RootViewProperties) {
          self.rootViewProperties = rootViewProperties
          super.init(nibName: nil, bundle: nil)
      }

      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

      override func viewDidLoad() {
          super.viewDidLoad()

          self.view.backgroundColor = rootViewProperties.backgroundColor
      }
  }


Running the app now will yield a new error saying a provider for ``RootViewProperties`` is missing. That's because we referenced it from our ``RootViewController`` class, but Cleanse didn't find a binding for the ``RootViewProperties`` type. So let's create one! We will do this inside the ``static func configure(binder: Binder<Unscoped>)`` function we talked about earlier inside our root component.

.. code-block:: swift

  static func configure(binder: Binder<Unscoped>) {
        binder
            .bind(RootViewProperties.self)
            .to { () -> RootViewProperties in
                RootViewProperties(backgroundColor: .blue)
            }
    }

Now that we have satisfied the ``RootViewProperties`` dependency, we should be able to successfully launch and see the same blue background as before.

As the functionality of this app grows, one may add more dependencies to ``RootViewController`` as well as more Modules_ to satisfy them.

It may be worth taking a look at our `example app`_ to see a more full-featured example.

.. _example app: https://github.com/square/Cleanse/tree/master/Examples/CleanseGithubBrowser

Core Concepts & Data Types
--------------------------

``Provider``\ /\ ``ProviderProtocol``
`````````````````````````````````````

Wraps a value of its containing type. Serves the same functionality as Java's `javax.inject.Provider`_.

``Provider`` and ``TaggedProvider`` (see below) implement ``ProviderProtocol`` protocol which is defined as:

.. code-block:: swift

    public protocol ProviderProtocol {
        associatedtype Element
        func get() -> Element
    }

.. _javax.inject.Provider: http://docs.oracle.com/javaee/6/api/javax/inject/Provider.html

Type Tags
`````````

In a given component, there may be the desire to provide or require different instances of common types with different
significances. Perhaps we need to distinguish the base URL of our API server from the URL of our temp directory.

In Java, this is done with annotations, in particular ones annotated with `@Qualifier`_. In Go, this can be accomplished
with `tags on structs`_ of fields.

.. _@Qualifier:  https://docs.oracle.com/javaee/6/api/javax/inject/Qualifier.html
.. _tags on structs: https://golang.org/pkg/reflect/#StructTag

In Cleanse's system a type annotation is equivalent to an implementation of the Tag protocol:

.. code-block:: swift

    public protocol Tag {
        associatedtype Element
    }

The `associatedtype`_, ``Element``, indicates what type the tag is valid to apply to. This is very different than annotations
in Java used as qualifiers in Dagger and Guice which cannot be constrained by which type they apply to.

In Cleanse, the ``Tag`` protocol is implemented to distinguish a type, and the ``TaggedProvider`` is used to wrap a value of
``Tag.Element``. Since most of the library refers to ``ProviderProtocol``, ``TaggedProvider`` is accepted almost everywhere a
``Provider`` is.

Its definition is almost identical to ``Provider`` aside from an additional generic argument:

.. code-block:: swift

    struct TaggedProvider<Tag : Cleanse.Tag> : ProviderProtocol {
        func get() -> Tag.Element
    }

Example
~~~~~~~

Say one wanted to indicate a URL type, perhaps the base URL for the API endpoints, one could define a tag this way:

.. code-block:: swift

    public struct PrimaryAPIURL : Tag {
        typealias Element = NSURL
    }

Then one may be able to request a ``TaggedProvider`` of this special URL by using the type:

.. code-block:: swift

    TaggedProvider<PrimaryAPIURL>

If we had a class that requires this URL to perform a function, the constructor could be defined like:


.. code-block:: swift

    class SomethingThatDoesAnAPICall {
        let primaryURL: NSURL
        init(primaryURL: TaggedProvider<PrimaryAPIURL>) {
            self.primaryURL = primaryURL.get()
        }
    }


Modules
```````

Modules in Cleanse serve a similar purpose to Modules in other DI systems such as Dagger or Guice.
Modules are building blocks for one's object graph. Using modules in Cleanse may look very similar to those
familiar with Guice since configuration is done at runtime and the binding DSL is very inspired by Guice's.

The ``Module`` protocol has a single method, ``configure(binder:)``, and is is defined as:

.. code-block:: swift

    protocol Module {
        func configure<B : Binder>(binder: B)
    }

Examples
~~~~~~~~

Providing the Base API URL
""""""""""""""""""""""""""

.. code-block:: swift

    struct PrimaryAPIURLModule : Module {
      func configure(binder: Binder<Unscoped>) {
        binder
          .bind(NSURL.self)
          .tagged(with: PrimaryAPIURL.self)
          .to(value: NSURL(string: "https://connect.squareup.com/v2/")!)
      }
    }

Consuming the Primary API URL (e.g. "https://connect.squareup.com/v2/")
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

**Note**: It is generally a good practice to embed the ``Module`` that configures X as an inner struct of X named ``Module``. To disambiguate Cleanse's Module protocol from the inner struct being defined, one has to qualify the protocol with ``Cleanse.Module``


.. code-block:: swift

    class SomethingThatDoesAnAPICall {
        let primaryURL: NSURL
        init(primaryURL: TaggedProvider<PrimaryAPIURL>) {
            self.primaryURL = primaryURL.get()
        }
        struct Module : Cleanse.Module {
            func configure(binder: Binder<Unscoped>) {
                binder
                    .bind(SomethingThatDoesAnAPICall.self)
                    .to(factory: SomethingThatDoesAnAPICall.init)
            }
        }
    }

Components
`````````````````````
Cleanse has a concept of a ``Component``. A ``Component`` represents an object graph of our dependencies that returns the ``Root`` `associated type`_ upon construction and is used as the "entry point" into Cleanse. However, we can also use a ``Component`` to create a subgraph inside our parent object graph, called a subcomponent. Subcomponents are closely related to scopes_ and are used to scope your dependencies. Objects inside a component are only allowed to inject dependencies that exist within the same component (or scope), or an ancestor's component. A parent component is not allowed to reach into a subcomponent and retrieve a dependency. One example of using components to scope dependencies is by having a ``LoggedInComponent`` inherting from your application's Root component. This allows you to bind logged in specific objects such as session tokens or account objects within the ``LoggedInComponent`` so that you can't accidently leak these dependencies into objects used outside of a logged session (i.e welcome flow views).

The base component protocol is defined as:

.. code-block:: swift

    public protocol ComponentBase {
      /// This is the binding required to construct a new Component. Think of it as somewhat of an initialization value.
      associatedtype Seed = Void

      /// This should be set to the root type of object that is created.
      associatedtype Root

      associatedtype Scope: Cleanse._ScopeBase = Unscoped

      static func configure(binder: Binder<Self.Scope>)

      static func configureRoot(binder bind: ReceiptBinder<Root>) -> BindingReceipt<Root>
    }


The outermost component of an object graph (e.g. the Root component), is built by the ``build(())`` method on `ComponentFactory`.
This is defined as the following protocol extension:

.. code-block:: swift

    public extension Component {
        /// Builds the component and returns the root object.
        public func build() throws -> Self.Root
    }

Examples
~~~~~~~~

Defining a subcomponent
"""""""""""""""""""""""

.. code-block:: swift

    struct RootAPI {
        let somethingUsingTheAPI: SomethingThatDoesAnAPICall
    }

    struct APIComponent : Component {
        typealias Root = RootAPI
        func configure(binder: Binder<Unscoped>) {
            // "include" the modules that create the component
            binder.include(module: PrimaryAPIURLModule.self)
            binder.include(module: SomethingThatDoesAnAPICall.Module.self)
            // bind our root Object
            binder
                .bind(RootAPI.self)
                .to(factory: RootAPI.init)
        }
    }

Using the component
"""""""""""""""""""
Cleanse will automatically create the type ``ComponentFactory<APIComponent>`` in your object graph by calling ``binder.install(dependency: APIComponent.self)``.

.. code-block:: swift

  struct Root : RootComponent {
      func configure(binder: Binder<Unscoped>) {
          binder.install(dependency: APIComponent.self)
      }
      // ...
  }


And then you can use it by injecting in the ``ComponentFactory<APIComponent>`` instance into an object and calling ``build(())``.

.. code-block:: swift

  class RootViewController: UIViewController {
      let loggedInComponent: ComponentFactory<APIComponent>

      init(loggedInComponent: ComponentFactory<APIComponent>) {
          self.loggedInComponent = loggedInComponent
          super.init(nibName: nil, bundle: nil)
      }

      func logIn() {
          let apiRoot = loggedInComponent.build(())
      }
  }

Assisted Injection
``````````````````
Summary (`RFC #112`_)
~~~~~~~~~~~~~~~~~~~~~

.. _RFC #112: https://github.com/square/Cleanse/issues/112


Assisted injection is used when combining seeded parameters and pre-bound dependencies. Similar to how a subcomponent has a ``Seed`` that is used to build the object graph, assisted injection allows you to eliminate boilerplate by creating a ``Factory`` type with a defined ``Seed`` object for construction via the ``build(_:)`` function.

Examples
~~~~~~~~

Creating a factory
""""""""""""""""""
Say we have a detail view controller that displays a particular customer's information based on the user's selection from a list view controller.

.. code-block:: swift

  class CustomerDetailViewController: UIViewController {
      let customerID: String
      let customerService: CustomerService
      init(customerID: Assisted<String>, customerService: CustomerService) {
          self.customerID = customerID.get()
          self.customerService = customerService
      }
      ...
  }

In our initializer, we have ``Assisted<String>`` which represents an assisted injection parameter based on the customer ID selected from the list view controller, and a pre-bound dependency ``CustomerService``.

In order to create our factory, we need to define a type that conforms to ``AssistedFactory`` to set our ``Seed`` and ``Element`` types.

.. code-block:: swift

  extension CustomerDetailViewController {
      struct Seed: AssistedFactory {
          typealias Seed = String
          typealias Element = CustomerDetailViewController
      }
  }

Once we create our ``AssistedFactory`` object, we can create the factory binding through Cleanse.

.. code-block:: swift

  extension CustomerDetailViewController {
      struct Module: Cleanse.Module {
          static func configure(binder: Binder<Unscoped>) {
              binder
                .bindFactory(CustomerDetailViewController.self)
                .with(AssistedFactory.self)
                .to(factory: CustomerDetailViewController.init)
          }
      }
  }

Consuming our factory
"""""""""""""""""""""
After creating our binding, Cleanse will bind a ``Factory<CustomerDetailViewController.AssistedFactory>`` type into our object graph. So in our customer list view controller, consuming this factory may look like:

.. code-block:: swift

    class CustomerListViewController: UIViewController {
        let detailViewControllerFactory: Factory<CustomerDetailViewController.AssistedFactory>

        init(detailViewControllerFactory: Factory<CustomerDetailViewController.AssistedFactory>) {
            self.detailViewControllerFactory = detailViewControllerFactory
        }
        ...

        func tappedCustomer(with customerID: String) {
            let detailVC = detailViewControllerFactory.build(customerID)
            self.present(detailVC, animated: false)
        }
    }

Service Provider Interface
``````````````````````````
Summary (`RFC #118`_)
~~~~~~~~~~~~~~~~~~~~~

.. _RFC #118: https://github.com/square/Cleanse/issues/118

Cleanse provides a plugin interface that developers can use to hook into the generated object graph to create custom validations and tooling.

Creating a plugin can be done in 3 steps:

**1. Create your plugin implementation by conforming to the protocol** ``CleanseBindingPlugin``

You will be required to implement the function ``func visit(root: ComponentBinding, errorReporter:
CleanseErrorReporter)``, which hands you an instance of a ``ComponentBinding`` and
``CleanseErrorReporter``.

The first parameter, ``ComponentBinding``, is a representation of the root component and can be used
to traverse the entire object graph. The second, ``CleanseErrorReporter`` is used to report
errors back to the user after validation is complete.

**2. Register your plugin with a** ``CleanseServiceLoader`` **instance**

After creating an instance of a ``CleanseServiceLoader``, you can register your plugin via the
``register(_:)`` function.

**3. Pass your service loader into the** ``RootComponent`` **factory function**

The ``RootComponent`` factory function, ``public static func of(_:validate:serviceLoader:)`` accepts
a ``CleanseServiceLoader`` instance and will run all the plugins registered within that object.

**NOTE**: Your plugins will only be run if you set `validate` to `true` in the factory function.

Sample plugin implementations are available in the RFC linked above.

Binder
``````
A ``Binder`` instance is what is passed to ``Module.configure(binder:)`` which module implementations use to configure
their providers.

Binders have two core methods that one will generally interface with. The first, and simpler one, is the install method.
One passes it an instance of a module to be installed.  It is used like:

.. code-block:: swift

  binder.include(module: PrimaryAPIURLModule.self)

It essentially tells the binder to call ``configure(binder:)`` on ``PrimaryAPIURLModule``.

The other core method that binders expose is the ``bind<E>(type: E.Type)``. This is the entry point to configure a
binding. The bind methods takes one argument, which the `metattype`_ of the element being configured. ``bind()``
returns a ``BindingBuilder`` that one must call methods on to complete the configuration of the binding that was
initiated.

``bind()`` and subsequent builder methods that are not *terminating* are annotated with ``@warn_unused_result``
to prevent errors by only partially configuring a binding.

.. _metattype: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Types.html#//apple_ref/swift/grammar/metatype-type


The ``type`` argument of ``bind()`` has a default and can be inferred and omitted in some common cases. In this documentation we sometimes specify it explicitly to improve readability.


``BindingBuilder`` and Configuring Your Bindings
````````````````````````````````````````````````

The BindingBuilder is a fluent API for configuring your bindings. It is built in a way that guides one through the
process of configuring a binding through code completion. A simplified grammar for the DSL of ``BindingBuilder`` is::

  binder
    .bind([Element.self])                // Bind Step
   [.tagged(with: Tag_For_Element.self)] // Tag step
   [.sharedInScope()]                    // Scope step
   {.to(provider:) |                     // Terminating step
    .to(factory:)  |
    .to(value:)}

Bind Step
~~~~~~~~~
This starts the binding process to define how an instance of ``Element`` is created

Tag Step (Optional)
~~~~~~~~~~~~~~~~~~~
An optional step that indicates that the provided type should actually be
``TaggedProvider<Element>`` and not just ``Provider<Element>``.

See: `Type Tags`_ for more information

.. _scopes:

Scope Step
~~~~~~~~~~~~~~~~~~~~~

By default, whenever an object is requested, Cleanse constructs a new one.
If the optional `.sharedInScope()` is specified, Cleanse will memoize and return the same instance in the scope of the ``Component`` it was configured in. Each ``Component`` requires its own `Scope` type. So if this is configured as a singleton in the `RootComponent`, then will return the same instance for the entire app.

Cleanse provides two scopes for you: ``Unscoped`` and ``Singleton``. ``Unscoped`` is the default scope that will always construct a new object, and ``Singleton`` is provided out of convenience but not necessary to use. It is most commonly used as the scope type for your application's ``RootComponent``.


Terminating Step
~~~~~~~~~~~~~~~~

To finish configuring a binding, one *must* invoke one of the terminating methods on ``BindingBuilder``.
There are multiple methods that are considered terminating steps. The common ones are described below.

Dependency-Free Terminating methods
"""""""""""""""""""""""""""""""""""
This is a category of terminating methods that configure how to instantiate elements that don't have dependencies
on other instances configured in the object graph.

Terminating Method: ``to(provider: Provider<E>)``
#################################################
Other terminating methods funnel into this. If the binding of ``Element`` is terminated with this variant,
``.get()`` will be invoked on the on the provider argument when an instance of ``Element`` is requested.

Terminating Method: ``to(value: E)``
####################################
This is a convenience method. It is semantically equivalent to
``.to(provider: Provider(value: value))`` or ``.to(factory: { value })``. It may
offer performance advantages in the future, but currently doesn't.

Terminating Method: ``to(factory: () -> E)`` *(0th arity)*
##########################################################
This takes a closure instead of a provider, but is otherwise equivalent. Is equivalent to ``.to(provider: Provider(getter: factory))``


Dependency-Requesting Terminating Methods
"""""""""""""""""""""""""""""""""""""""""
This is how we define requirements for bindings.
`Dagger 2`_ determines requirements at compile time by looking at the arguments of ``@Provides`` methods and ``@Inject`` constructors.
`Guice`_ does something similar, but using reflection to determine arguments.
One can explicitly request a dependency from Guice's binder via the `getProvider()`_ method.

.. _getProvider(): https://google.github.io/guice/api-docs/latest/javadoc/com/google/inject/Binder.html#getProvider-java.lang.Class-
.. _Dagger 2: https://google.github.io/dagger/

Unlike Java, Swift doesn't have annotation processors to do this at compile time, nor does it have a `stable` reflection
API. We also don't want to expose a `getProvider()`_-like method since it allows one to do dangerous things and
also one loses important information on which providers depend on other providers.

Swift does, however, have a very powerful generic system. We leverage this to provide safety and simplicity when
creating our bindings.

Terminating Methods: ``to<P1>(factory: (P1) -> E)`` *(1st arity)*
#################################################################

This registers a binding of E to the factory function which takes one argument.

.. admonition:: How it works

  Say we have a hamburger defined as:

  .. code-block:: swift

     struct Hamburger {
        let topping: Topping
        // Note: this actually would be created implicitly for structs
        init(topping: Topping) {
          self.topping = topping
        }
      }

  When one references the initializer without calling it (e.g. ``let factory = Hamburger.init``),
  the expression results in a `function type`_ of

  .. code-block:: swift

     (topping: Topping) -> Hamburger

  So when configuring its creation in a module, calling

  .. code-block:: swift

     binder.bind(Hamburger.self).to(factory: Hamburger.init)

  will result in calling the ``.to<P1>(factory: (P1) -> E)`` terminating function and resolve ``Element``
  to ``Hamburger`` and ``P1`` to ``Topping``.

  A pseudo-implementation of this ``to(factory:)``:

  .. code-block:: swift

    public func to<P1>(factory: (P1) -> Element) {
      // Ask the binder for a provider of P1. This provider
      // is invalid until the component is constructed
      // Note that getProvider is an internal method, unlike in Guice.
      // It also specifies which binding this provider is for to
      // improve debugging.
      let dependencyProvider1: Provider<P1> =
          binder.getProvider(P1.self, requiredFor: Element.self)

      // Create a Provider of Element. This will call the factory
      // method with the providers
      let elementProvider: Provider<Element> = Provider {
          factory(dependencyProvider1.get())
      }

      // Call the to(provider:) terminating function to finish
      // this binding
      to(provider: elementProvider)
    }

  Since the requesting of the dependent providers happen at configuration time, the object graph is aware of all
  the bindings and dependencies at configuration time and will fail fast.


.. _function type: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Types.html#//apple_ref/doc/uid/TP40014097-CH31-ID449


Terminating Methods: ``to<P1, P2, … PN>(factory: (P1, P2, … PN) -> E)`` *(Nth arity)*
#####################################################################################

Well, we may have more than one requirement to construct a given instance.
There aren't `variadic generics`_ in swift. However we used a small script to generate various arities of the
``to(factory:)`` methods.

.. _variadic generics: https://en.wikipedia.org/wiki/Variadic_template

Collection Bindings
```````````````````
It is sometimes desirable to provide multiple objects of the same type into one collection. A very common use of
this would be providing interceptors or filters to an RPC library.
In an app, one may want to add to a set of view controllers of a tab bar controller, or settings in a settings page.

This concept is referred to as *Multibindings*
`in Dagger <http://google.github.io/dagger/multibindings.html>`_
and
`in Guice <https://github.com/google/guice/wiki/Multibindings>`_.

Providing to a Set or Dictionary is not an unwanted feature and could probably be built as an extension on top of providing to ``Arrays``.

Binding an element to a collection is very similar to standard `Bind Step`_\ s,
but with the addition of one step: calling ``.intoCollection()`` in the builder definition.::

  binder
    .bind([Element.self])                // Bind Step
    .intoCollection()	// indicates that we are providing an
                      // element or elements into Array<Element>**
   [.tagged(with: Tag_For_Element.self)]   // Tag step
   [.asSingleton()]                        // Scope step
   {.to(provider:) |                       // Terminating step
    .to(factory:)  |
    .to(value:)}

The `Terminating Step`_ for this builder sequence can either be a factory/value/provider
of a single ``Element`` or ``Array`` of ``Element``\ s.

.. _`Property Injection`:
Property Injection
``````````````````
There are a few instances where one does not control the construction of an object, but dependency injection would be deemed useful.
Some of the more common occurrences of this are:

- App Delegate: This is required in every iOS app and is the entry point, but UIKit will construct it.
- View Controllers constructed via storyboard (in particular via segues): Yes, we all make mistakes. One of those mistakes
  may have been using Storyboards before they became unwieldy. One does not control the construction of view controllers
  when using storyboards.
- XCTestCase: We don't control how they're instantiated, but may want to access objects from an object graph. This is
  more desirable in higher levels of testing such as UI and integration testing (DI can usually be avoided for lower
  level unit tests)

Cleanse has a solution for this: Property injection (known as Member injection in Guice and Dagger).

In cleanse, Property injection is a second class citizen by design. Factory/Constructor injection should be used wherever
possible, but when it won't property injection may be used. Property Injection has a builder language, similar to the
``BindingBuilder``:

.. code-block:: swift

  binder
    .bindPropertyInjectionOf(<metatype of class being injected into>)
    .to(injector: <property injection method>)

There are two variants of the terminating function, one is where the signature is

.. code-block:: swift

  (Element, P1, P2,  ..., Pn) -> ()

And the other is

.. code-block:: swift

  (Element) -> (P1, P2, ..., Pn) -> ()

The former is to allow for simple injection methods that aren't instance methods, for example:

.. code-block:: swift

  binder
    .bindPropertyInjectionOf(AClass.self)
    .to {
       $0.a = ($1 as TaggedProvider<ATag>).get()
    }

or

.. code-block:: swift

  binder
    .bindPropertyInjectionOf(BClass.self)
    .to {
        $0.injectProperties(superInjector: $1, b: $2, crazyStruct: $3)
    }

The latter type of injection method that can be used (``Element -> (P1, P2,  …, Pn) -> ()``) is convenient
when referring to instant methods on the target for injection.

Say we have

.. code-block:: swift

    class FreeBeer {
      var string1: String!
      var string2: String!

      func injectProperties(
        string1: TaggedProvider<String1>,
        string2: TaggedProvider<String2>
      ) {
        self.string1 = string1.get()
        self.string2 = string2.get()
      }
    }

One can bind a property injection for FreeBeer by doing:

.. code-block:: swift

    binder
      .bindPropertyInjectionOf(FreeBeer.self)
      .to(injector: FreeBeer.injectProperties)

The result type of the expression ``FreeBeer.injectProperties`` is ``FreeBeer -> (TaggedProvider<String1>, TaggedProvider<String2>) -> ()``

After binding a property injector for ``Element``, one will be able to request the type ``PropertyInjector<Element>``
in a factory argument. This has a single method defined as:

.. code-block:: swift

  func injectProperties(into instance: Element)

Which will then perform property injection into ``Element``.

**Note:** Property injectors in the non-legacy API are unaware of class hierarchies. If one wants property injection to cascade up a class hierarchy, the injector bound may call the inject method for super, or request a ``PropertyInjector<Superclass>`` as an injector argument and use that.

.. _`Advanced Setup`:
Advanced Setup
``````````````
We can make the root of our Cleanse object graph the App Delegate through `Property Injection`_. We must use property injection here because we don't control construction of the app delegate. Now we can model our "Root" as an instance of ``PropertyInjector<AppDelegate>`` and then use this object to inject properties into our already constructed App Delegate.

Let's start by redefining the ``RootComponent``:

.. code-block:: swift

    extension AppDelegate {
      struct Component : Cleanse.RootComponent {
        // When we call build() it will return the Root type, which is a PropertyInjector<AppDelegate>.
        // More on how we use the PropertyInjector type later.
        typealias Root = PropertyInjector<AppDelegate>

        // Required function from Cleanse.RootComponent protocol.
        static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<AppDelegate>>) -> BindingReceipt<PropertyInjector<AppDelegate>> {
            return bind.propertyInjector(configuredWith: { bind in
                bind.to(injector: AppDelegate.injectProperties)
            })
        }

        // Required function from Cleanse.RootComponent protocol.
        static func configure(binder: Binder<Unscoped>) {
            // Binding go here.
        }
      }
    }

Inside of our app delegate, we add the function ``injectProperties``:

.. code-block:: swift

  func injectProperties(_ window: UIWindow) {
    self.window = window
  }

Now to wire up our new root object, we can call ``injectProperties(:)`` on ourself in the app delegate:

.. code-block:: swift

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
      // Build our component, and make the property injector
      let propertyInjector = try! ComponentFactory.of(AppDelegate.Component.self).build(())

       // Now inject the properties into ourselves
      propertyInjector.injectProperties(into: self)

      window!.makeKeyAndVisible()

      return true
  }

Running the app now will yield a new error saying a provider for ``UIWindow`` is missing, but after binding an instance of our ``UIWindow`` and its dependencies, we should be good to go!

.. code-block:: swift

  extension UIWindow {
    struct Module : Cleanse.Module {
      public func configure(binder: Binder<Singleton>) {
        binder
          .bind(UIWindow.self)
          // The root app window should only be constructed once.
          .sharedInScope()
          .to { (rootViewController: RootViewController) in
            let window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.rootViewController = rootViewController
            return window
          }
      }
    }
  }

Contributing
------------
We're glad you're interested in Cleanse, and we'd love to see where you take it.

Any contributors to the master Cleanse repository must sign the `Individual Contributor License Agreement (CLA)`_. It's
a short form that covers our bases and makes sure you're eligible to contribute.

.. _Individual Contributor License Agreement (CLA): https://spreadsheets.google.com/spreadsheet/viewform?formkey=dDViT2xzUHAwRkI3X3k5Z0lQM091OGc6MQ&ndplr=1


License
-------
`Apache 2.0`_

.. _Apache 2.0: http://www.apache.org/licenses/LICENSE-2.0.html
.. _associated type: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID189
.. _associatedtype: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID189
