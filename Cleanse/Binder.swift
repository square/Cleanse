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

public protocol BinderBase : Installer, ProviderProvider {
    /// Authoritative bind function.
    func _internalBind(binding: RawProviderBinding)
}
