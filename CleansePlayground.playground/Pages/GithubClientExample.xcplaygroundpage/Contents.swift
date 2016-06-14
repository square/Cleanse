/*:
 
 ## Github Client Example.

 This is a demonstration of using Cleanse and NSURLSession and friends to configure a github client that
 will list a User's projects
*/

import Cleanse

import XCPlayground


//: Since we will be doing an asynchronous call, we need to make it so the execution doesn't stop immediately
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: This is the base URL for github
struct GithubBaseURL : Tag {
    typealias Element = NSURL
}

//: The `NetworkModule` makes an `NSURLSession` available
struct NetworkModule : Module {
    func configure<B : Binder>(binder binder: B) {

//: Make `NSURLSessionConfiguration.ephemeralSessionConfiguration` be provided when one requests a `NSURLSessionConfiguration`
        binder
            .bind()
            .asSingleton()
            .to(factory: NSURLSessionConfiguration.ephemeralSessionConfiguration)

//: Make `NSURLSession` available. It depends on `NSURLSessionConfiguration` configured above (`$0`)
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

//: Simple Service that lists "Member" logins for the current organization
protocol GithubListMembersService {
    func listMembers(organizationName: String, handler: [String] -> ())
}

//: Implementation of our service. It requires a base URL and an `NSURLSession`
struct GithubListMembersServiceImpl : GithubListMembersService {
    let githubURL: TaggedProvider<GithubBaseURL>

    let urlSession: NSURLSession

    /// Lists members of an organization
    func listMembers(organizationName: String, handler: [String] -> ()) {

        let url = githubURL
            .get()
            .URLByAppendingPathComponent("orgs/\(organizationName)/public_members")

        let dataTask = urlSession.dataTaskWithURL(url) { data, response, error in
//: For simplicity of example, just yield an empty list if the request wasn't successful
            guard let data = data, result = (try? NSJSONSerialization.JSONObjectWithData(data, options: [])) as? [[String: AnyObject]] else {
                handler([])
                return
            }

            handler(result.flatMap { $0["login"] as? String })
        }

        dataTask.resume()
    }
}

//: Configures the GithubAPI

struct GithubAPIModule : Module {
    func configure<B : Binder>(binder binder: B) {

//: Configure the base URL for Github's API to be `"https://api.github.com"`
        binder
            .bind()
            .tagged(with: GithubBaseURL.self)
            .to(value: NSURL(string: "https://api.github.com")!)

//: Configure GithubMembersServiceImpl to be the implementation of GithubMembersService

        binder
            .bind(GithubListMembersService.self)
            .asSingleton()
            .to(factory: GithubListMembersServiceImpl.init)
    }
}


struct GithubListMembersComponent : Component {

//: When we build this component we want `GithubListMembersService` returned

    typealias Root = GithubListMembersService

    func configure<B : Binder>(binder binder: B) {
//: Install both the modules we have made
        binder.install(module: NetworkModule())
        binder.install(module: GithubAPIModule())
    }
}

//: Now its time to build the component

let membersService: GithubListMembersService = try! GithubListMembersComponent().build()

//: Let's list the members

membersService.listMembers("square") { members in
    print("Fetched \(members.count) members:")

    for (i, login) in members.enumerate() {
        print("\(i+1).\t\(login)")
    }

    XCPlaygroundPage.currentPage.finishExecution()
}