//
//  Binder.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/25/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/**
 Internal representation of a completed `BindingBuilder`. It is consolidated into a protocol to make message signatures simpler.
 */
public protocol _InternalBindInfoProtocol {
    associatedtype BP : BindingBuilder
    
    var bindingProvider: BP { get }
    var provider: BP.FinalProvider { get }
}

struct InternalBindInfo<BP_: BindingBuilder> : _InternalBindInfoProtocol {
    typealias BP = BP_
    
    let bindingProvider: BP
    let provider: BP_.FinalProvider
}

/// This is what is passed to `Module.configure` methods.It should be called to configure bindings.
public protocol Binder :  Installer, ProviderProvider {
    /// Authoritative bind function.
    func _internalBind(binding binding: RawProviderBinding)
}

