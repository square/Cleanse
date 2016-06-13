//
//  ComponentBindingBuilder.swift
//  Cleanse
//
//  Created by Mike Lewis on 5/2/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation
//
//
//
///// This protocol exists to be able extend BindingBuilder with generic constraints. In practice, this will probably only be implemented by BindingBuilder
//public protocol ComponentBindingBuilderProtocol : VariableArityBindingBuilderProtocol {
//    /// The type of Binder that created this
//    associatedtype B: Binder
//    
//    /// The element of this is the type that we're building for the bindingBUilder
//    associatedtype BT: ComponentBindingProviderProtocol
//    
//    
//    /// The tag of the BT.E being bound
//    associatedtype T: BaseTag = VoidTag
//    
//    /// The scope of the provider. If this is a singleton it will be "Singleton"
//    associatedtype S: Scope = Unscoped
//    
//    func toComponentBindingBuilder() -> ComponentBindingBuilder<B, BT, T, S>
//    
//    var binder: B { get }
//}
//
//public struct ComponentBindingBuilder<B: Binder, BT: BindingProvider, T: BaseTag, S: Scope where BT: ComponentBindingProviderProtocol> : ComponentBindingBuilderProtocol {
//    public unowned let binder: B
//    
//    /// Entry point. Only `Binder` should be constructing with this
//    init(binder: B) {
//        self.binder = binder
//    }
//    
//    /// Constructs a new builder from the shared properties.
//    private init<BB: ComponentBindingBuilderProtocol where BB.B == B, BB.BT.E == BT.E>(_ other: BB) {
//        self.binder = other.binder
//    }
//
//    public func toComponentBindingBuilder() -> ComponentBindingBuilder<B, BT, T, S> {
//        return self
//    }
//    
//    public func to<P : ProviderConvertible where P.E == BT.FinalElement>(
//        file file: StaticString,
//             line: Int,
//             function: StaticString,
//             provider: P) {
//        let bindingInfo = InternalBindInfo<BT.E,T,S>(provider: BT._internalMakeProvider(provider: provider.asProvider()))
//        
//        binder._internalBind(bindingInfo: bindingInfo)
//        BT._internalPerformExtraBindingSteps(bindingInfo: bindingInfo, binder: binder)
//    }
//}

/// MARK: Building steps

//extension ComponentBindingBuilderProtocol where T == VoidTag, S == Unscoped /* Tagging must happen before typing */{
//    /// Qualifies the provider being registered with a tag. Note that the tag has to qualify the Root of the component
//    @warn_unused_result
//    public func with<NewTag: Tag where NewTag.E == BT.E.Root>(tag tag: NewTag.Type) -> ComponentBindingBuilder<B, BT, NewTag, S> {
//        return .init(self)
//    }
//    
//    @warn_unused_result
//    public func with<NewTag: UnqualifiedTag>(tag tag: NewTag.Type) -> ComponentBindingBuilder<B, BT, NewTag, S> {
//        return .init(self)
//    }
//}
//
//extension ComponentBindingBuilderProtocol where S == Unscoped {
//    @warn_unused_result
//    public func asSingleton() -> ComponentBindingBuilder<B, BT, T, Singleton> {
//        return .init(self)
//    }
//}

