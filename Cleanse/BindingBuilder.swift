//
//  _BindingBuilder.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public protocol BindingBuilder {
    
    // NOTE: When adding a new associated type here, you MUST make it cascade to the wrapped in BindingBuilderDecorator.swift
    
    associatedtype MaybeScope : Scope = _Unscoped
    associatedtype _Binder : Binder
    
    // What is returned in the to functions
    associatedtype Input = FinalProvider.Element
    

    // This is what get exposed to get injected
    associatedtype FinalProvider: ProviderProtocol
    
    associatedtype MaybeComponentOrSubcomponent: Any = Void
    
    associatedtype CollectionOrUnique: _CollectionOrUniqueBindingBase = _UniqueBinding
    
    
    var binder: _Binder { get }
    static func mapElement(input input: Input) -> FinalProvider.Element
    
    static var collectionMergeFunc: Optional<[FinalProvider.Element] -> FinalProvider.Element> { get }
}

/// Extended to represent if we're a collection binding or unique binding
public protocol _CollectionOrUniqueBindingBase {
    static var isCollectionBinding: Bool { get }
}

public struct _CollectionBinding : _CollectionOrUniqueBindingBase {
    public static var isCollectionBinding: Bool {
        return true
    }
}


public struct _UniqueBinding : _CollectionOrUniqueBindingBase {
    public static var isCollectionBinding: Bool {
        return false
    }
}


extension BindingBuilder {
    func with<Decorator: BindingBuilderDecorator where Decorator.Wrapped == Self>(decorator: Decorator.Type=Decorator.self) -> Decorator {
        return Decorator(wrapped: self)
    }
}

/// MARK: Binding creation

extension Binder {
    /// Standard entry point to bind something
    @warn_unused_result
    public func bind<Element>(_ type: Element.Type = Element.self) -> BaseBindingBuilder<Element, Self> {
        return BaseBindingBuilder(binder: self)
    }
}
/// Used for BindingBuilder only. Don't use
public protocol _StandardProvider : ProviderProtocol {
}

extension Provider : _StandardProvider {
}

/// MARK: Building steps

extension BindingBuilder where FinalProvider: _StandardProvider, Self.MaybeScope == _Unscoped
/*, Self.MaybeComponentOrSubcomponent == Void*/ /* Tagging must happen before typing */{
    /// Qualifies the provider being registered with a tag.
    @warn_unused_result
    public func tagged<Tag: Cleanse.Tag where Tag.Element == FinalProvider.Element>(with tag: Tag.Type) -> TaggedBindingBuilderDecorator<Self, Tag> {
        return self.with()
    }
}

extension BindingBuilder where MaybeScope == _Unscoped {
    @warn_unused_result
    public func asSingleton() -> ScopedBindingDecorator<Self, Singleton> {
        return self.with()
    }

    @warn_unused_result
    public func scoped<S: Scope>(`in` scope: S.Type) -> ScopedBindingDecorator<Self, S> {
        return self.with()
    }
}

/// Terminating functions

extension BindingBuilder {
    public func to<P: ProviderConvertible where P.Element == Input>(
        file file: StaticString=#file,
             line: Int=#line,
             function: StaticString=#function,
             provider: P) {
        
        let mappedProvider = FinalProvider(other: provider.asProvider().map(transform: Self.mapElement))

        let typeErasedProvider: AnyProvider


        let isCollectionBinding = CollectionOrUnique.isCollectionBinding
        
        let anyCollectionMergeFunc: Optional<[Any] -> Any>
        
        if let mergeFunc = self.dynamicType.collectionMergeFunc {
            precondition(isCollectionBinding)
            anyCollectionMergeFunc = { inputs in
                return mergeFunc(inputs.map { $0 as! FinalProvider.Element })
            }
        } else {
            precondition(!isCollectionBinding)
            anyCollectionMergeFunc = nil
        }
        
        let componentOrSubcomponentProvider: AnyProvider?
        
        if MaybeComponentOrSubcomponent.self is _AnyBaseComponent.Type && Input.self == MaybeComponentOrSubcomponent.self {
            componentOrSubcomponentProvider = provider.asProvider()
        } else {
            componentOrSubcomponentProvider = nil
        }

        let scope: Scope.Type?

        // If we explicitely declared our scope (e.g. `scopedIn(
        if let declaredScope = MaybeScope.scopeOrNil {
            scope = declaredScope
        } else if let scopedElementType = FinalProvider.Element.self as? _AnyScoped.Type {
            scope = scopedElementType._scopeType
        } else {
            scope = nil
        }

        let rpb = RawProviderBinding(
            scope: scope,
            provider: mappedProvider as! AnyProvider,
            collectionMergeFunc: anyCollectionMergeFunc,
            componentOrSubcomponentProvider: componentOrSubcomponentProvider
        )
        
        binder._internalBind(binding: rpb)
    }
    
    
    public func to(
        value value: Input,
              file: StaticString=#file,
              line: Int=#line,
              function: StaticString=#function
        ) {
        to(file: file, line: line, function: function, provider: Provider(value: value))
    }
}


extension BindingBuilder {
    /**
     This is the 0th arity `to(factory:)` function. This finishes the binding process.
     */
    public func to(
        file file: StaticString=#file,
             line: Int=#line,
             function: StaticString=#function,
             factory: () -> Input) {
        
        to(file: file, line: line, function: function, provider: Provider(getter: factory))
    }
}
