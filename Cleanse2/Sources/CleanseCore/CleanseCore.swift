
public protocol Module {}

public protocol Scope {
    func instance<E>(_ element: E) -> E
}

public protocol ComponentBase {}

public protocol Component: ComponentBase {
    associatedtype Root
    
    static var modules: [Module.Type] { get }
    static var parent: ComponentBase.Type? { get }
}

public extension Component {
    static var parent: ComponentBase.Type? {
        return nil
    }
}
