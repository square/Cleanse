/*:
 
 ## Github Client Example.

 This is a demonstration of using Cleanse and NSURLSession and friends to configure a GitHub client that
 will list a user's projects.
*/
import Cleanse
import XCPlayground

// Since we will be doing an asynchronous call, we need to make it so the execution doesn't stop immediately
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: Define our services. This are just normal objects, not Cleanse related.

/// Simple Service that lists "Member" logins for the current organization.
protocol GithubListMembersService {
    func listMembers(organizationName: String, handler: [String] -> ())
}

/// Implementation of GithubListMembersService. It requires a base URL and an `NSURLSession`.
struct GithubListMembersServiceImpl : GithubListMembersService {
    let githubURL: NSURL
    let urlSession: NSURLSession

    func listMembers(organizationName: String, handler: [String] -> ()) {
        let url = githubURL.URLByAppendingPathComponent("orgs/\(organizationName)/public_members")

        let dataTask = urlSession.dataTaskWithURL(url) { data, response, error in
            // For simplicity of example, just yield an empty list if the request wasn't successful
            guard let data = data, let result = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]] else {
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
    func listMembers(organizationName: String, handler: [String] -> ()) {
        handler(["Fake #1", "Fake #2", "Fake #3"])
    }
}

//: Define our Cleanse Module(s) and Component(s). These objects are responsible for setting up and initializing the object graph.

/// The `NetworkModule` provides an `NSURLSession`.
struct NetworkModule : Module {
    static func configure<B : Binder>(binder binder: B) {

        //: Provide `NSURLSessionConfiguration.ephemeralSessionConfiguration` when a `NSURLSessionConfiguration` is required.
        binder
            .bind()
            .asSingleton()
            .to(factory: NSURLSessionConfiguration.ephemeralSessionConfiguration)

        //: Provide `NSURLSession`. It depends on `NSURLSessionConfiguration` configured above (`$0`).
        binder
            .bind()
            .asSingleton()
            .to {
                NSURLSession(
                    configuration: $0,
                    delegate: nil,
                    delegateQueue: NSOperationQueue.mainQueue()
                )
        }
    }
}

/// This represents the base URL for GitHub. We might have multiple `NSURL`s in the app, so we should define each one with a specific tag.
struct GithubBaseURL : Tag {
    typealias Element = NSURL
}

/// Configure the Github API.
struct GithubAPIModule : Module {
    static func configure<B : Binder>(binder binder: B) {

        // Configure the base URL for Github's API to be `"https://api.github.com"`
        binder
            .bind()
            .tagged(with: GithubBaseURL.self)
            .to(value: NSURL(string: "https://api.github.com")!)

        // Configure GithubMembersServiceImpl to be the implementation of GithubMembersService.
        binder
            .bind(GithubListMembersService.self)
            .asSingleton()
            .to { (githubURL: TaggedProvider<GithubBaseURL>, urlSession: NSURLSession) in
                return GithubListMembersServiceImpl(githubURL: githubURL.get(), urlSession: urlSession)
        }
    }
}

struct FakeAPIModule : Module {
    static func configure<B : Binder>(binder binder: B) {
        binder
            .bind(GithubListMembersService)
            .asSingleton()
            .to { FakeListMembersServiceImpl() }
    }
}

/// Define a Component. This is the root object that the object graph is built around.
struct GithubListMembersComponent : RootComponent {
    // When we build this Component we want to return `GithubListMembersService`.
    typealias Root = GithubListMembersService

    static func configure<B : Binder>(binder binder: B) {
        // Install the modules we defined earlier.
        binder.install(module: NetworkModule.self)

        // Toggle these to switch between hitting a real and fake service.
//         binder.install(module: FakeAPIModule.self)
        binder.install(module: GithubAPIModule.self)
    }
}

//: Build the component; the return value is the `Root` defined above: `GithubListMembersService`

let membersService: GithubListMembersService = try! ComponentFactory.of(GithubListMembersComponent.self).build()
print("Got ourselves a member service pointing")

//: Finally, list all the members.

membersService.listMembers("square") { members in
    print("Fetched \(members.count) members:")

    for (i, login) in members.enumerate() {
        print("\(i+1).\t\(login)")
    }

    XCPlaygroundPage.currentPage.finishExecution()
}
