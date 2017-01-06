//
//  _BindingBuilder.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/6/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


public protocol BindingBuilder : BindToable {
    // NOTE: When adding a new associated type here, you MUST make it cascade to the wrapped in BindingBuilderDecorator.swift
    associatedtype MaybeScope : Scope = _Unscoped
    
    // What is returned in the to functions
    associatedtype Input = FinalProvider.Element
    
    // This is what get exposed to get injected
    associatedtype FinalProvider: ProviderProtocol
    
    associatedtype CollectionOrUnique: _CollectionOrUniqueBindingBase = _UniqueBinding
    
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

protocol _AnyStandardProvider : AnyProvider {
}

extension Provider : _StandardProvider, _AnyStandardProvider {
}

/// MARK: Building steps

extension BindingBuilder where FinalProvider: _StandardProvider, Self.MaybeScope == _Unscoped {
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


extension BindToable {
    public func to(
        file file: StaticString=#file,
             line: Int=#line,
             function: StaticString=#function,
             provider: Provider<Input>) -> BindingReceipt<Input> {
        return _innerTo(file: file, line: line, function: function, provider: provider)
    }

    public func to(
        value value: Input,
              file: StaticString=#file,
              line: Int=#line,
              function: StaticString=#function
        ) -> BindingReceipt<Input> {
        return _innerTo(file: file, line: line, function: function, provider: Provider(value: value))
    }

    /**
     This is the 0th arity `to(factory:)` function. This finishes the binding process.
     */
    public func to(
        file file: StaticString=#file,
             line: Int=#line,
             function: StaticString=#function,
             factory: () -> Input) -> BindingReceipt<Input> {

        return _innerTo(file: file, line: line, function: function, provider: Provider(getter: factory))
    }
}
/// Terminating functions

extension BindingBuilder {
    public var _finalProviderType: Any.Type {
        return FinalProvider.self
    }

    public func _innerTo(
        file file: StaticString=#file,
             line: Int=#line,
             function: StaticString=#function,
             provider: Provider<Input>) -> BindingReceipt<Input> {
        
        let mappedProvider = FinalProvider(other: provider.map(transform: Self.mapElement))

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
            sourceLocation: SourceLocation(file: file, line: line, function: function)
        )
        
        binder._internalBind(binding: rpb)

        return BindingReceipt()
    }
}
