/*:
 
 ## Github Client Example.

 This is a demonstration of using Cleanse and URLSession and friends to configure a GitHub client that
 will list a user's projects.
*/
import Cleanse
import PlaygroundSupport

// Since we will be doing an asynchronous call, we need to make it so the execution doesn't stop immediately
PlaygroundPage.current.needsIndefiniteExecution = true

//: Define our services. This are just normal objects, not Cleanse related.

/// Simple Service that lists "Member" logins for the current organization.
protocol GithubListMembersService {
    func listMembers(for orgName: String, handler: @escaping ([String]) -> Void)
}

/// Implementation of GithubListMembersService. It requires a base URL and an `URLSession`.
struct GithubListMembersServiceImpl : GithubListMembersService {
    let githubURL: URL
    let urlSession: URLSession

    func listMembers(for orgName: String, handler: @escaping ([String]) -> Void) {
        let url = githubURL.appendingPathComponent("orgs/\(orgName)/public_members")

        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            // For simplicity of example, just yield an empty list if the request wasn't successful
            guard let data = data, let result = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: AnyObject]] else {
                handler([])
                return
            }

            handler(result.flatMap { $0["login"] as? String })
        }

        dataTask.resume()
    }
}

/// Fake implementation of GithubListMembersService. This doesn't hit the network and thus doesn't require anything.
struct FakeListMembersServiceImpl : GithubListMembersService {
    func listMembers(for orgName: String, handler: @escaping ([String]) -> Void) {
        handler(["Fake #1", "Fake #2", "Fake #3"])
    }
}

//: Define our Network Scope (like a Singleton)
struct Network : Scope {}

//: Define our Cleanse Module(s) and Component(s). These objects are responsible for setting up and initializing the object graph.

/// The `NetworkModule` provides an `URLSession`.
struct NetworkModule : Module {
    static func configure(binder: Binder<Network>) {

        //: Provide `URLSessionConfiguration.ephemeral` when a `URLSessionConfiguration` is required.
        binder
            .bind()
            .sharedInScope()
            .to { URLSessionConfiguration.ephemeral }

        //: Provide `URLSession`. It depends on `URLSessionConfiguration` configured above (`$0`).
        binder
            .bind()
            .sharedInScope()
            .to {
                URLSession(
                    configuration: $0,
                    delegate: nil,
                    delegateQueue: OperationQueue.main
                )
        }
    }
}

//: This represents the base URL for GitHub. We might have multiple `URL`s in the app, so we should define each one with a specific tag.
struct GithubBaseURL : Tag {
    typealias Element = URL
}

//: Configure the Real Github API.
struct GithubAPIModule : Module {
    static func configure(binder: Binder<Network>) {
        binder.include(module: NetworkModule.self)

        // Configure the base URL for Github's API to be `"https://api.github.com"`
        binder
            .bind()
            .tagged(with: GithubBaseURL.self)
            .to(value: URL(string: "https://api.github.com")!)

        binder
            .bind(GithubListMembersServiceImpl.self)
            .sharedInScope()
            .to { (githubURL: TaggedProvider<GithubBaseURL>, urlSession: URLSession) in
                return GithubListMembersServiceImpl(githubURL: githubURL.get(), urlSession: urlSession)
        }
    }
}

//: Configure the Fake Github API. You would use this in tests or even while developing so you don't have to rely on a staging server.
struct FakeAPIModule : Module {
    static func configure(binder: Binder<Network>) {
        binder
            .bind(FakeListMembersServiceImpl.self)
            .sharedInScope()
            .to (factory: FakeListMembersServiceImpl.init)
    }
}

//: Define a Component. This is the root object that the object graph is built around.
struct GithubListMembersComponent : RootComponent {
    // When we build this Component we want to return `GithubListMembersService`.
    typealias Root = GithubListMembersService

    static func configureRoot(binder bind: ReceiptBinder<GithubListMembersService>) -> BindingReceipt<GithubListMembersService> {
        // Toggle this value to switch between hitting a real and fake service.
        let fakeMode = true

        return bind.to { (fake: FakeListMembersServiceImpl, real: GithubListMembersServiceImpl) -> GithubListMembersService in
            return fakeMode ? fake : real
        }
    }

    static func configure(binder: Binder<Network>) {
        // Install both the fake and real modules we defined earlier.
        binder.include(module: FakeAPIModule.self)
        binder.include(module: GithubAPIModule.self)
    }
}

//: Build the component; the return value is the `Root` defined above: `GithubListMembersService`
let membersService: GithubListMembersService = try! ComponentFactory.of(GithubListMembersComponent.self).build()
print("The member service: \(membersService)")

//: Finally, list all the members.
membersService.listMembers(for: "square") { members in
    print("Fetched \(members.count) members:")

    for (i, username) in members.enumerated() {
        print("\(i+1).\t\(username)")
    }

    PlaygroundPage.current.finishExecution()
}
