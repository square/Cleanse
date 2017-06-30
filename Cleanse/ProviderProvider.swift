//
//  ProviderProvider.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/26/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


/**
 Portion of the binder protocol used to request future providers. This is only used internally and will probably go away
 */
public protocol ProviderProvider {
    /// Raw inner function to request a provider. One should call standard provider methods instead
    func _internalProvider<Element>(_ type: Element.Type, debugInfo: ProviderRequestDebugInfo?) -> Provider<Element>
}

extension ProviderProvider {
    /// - parameter providerRequiredFor: Only used for debugging
    /// - returns: the provider used to obtain instances for the key
    func provider<Element>(
        _ type: Element.Type,
        file: StaticString=#file,
        line: Int=#line,
        function: StaticString=#function,
        providerRequiredFor: Any.Type? = nil
        ) -> Provider<Element> {
        
        let debugInfo = ProviderRequestDebugInfo(
            requestedType: type,
            providerRequiredFor: providerRequiredFor,
            sourceLocation: SourceLocation(file: file, line: line, function: function))
        
        return _internalProvider(type, debugInfo: debugInfo)
    }
}
