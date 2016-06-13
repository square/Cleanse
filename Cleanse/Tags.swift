//
//  TaggedValue.swift
//  Cleanse
//
//  Created by Mike Lewis on 4/28/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Swift

/**
 
 The `*Tag` family of protocols and `Tagged` struct are ways of attributing additional meta information to keys.
 
 In Java, this is done with annotations, in particular `@Qualifier` ones. In Go, fields may have tags (using the ``)
 
 This is useful to distinguish different common types such as Strings, URLs, etc.
 
 Say one wanted to provide the current "git sha" to an about page. In java this could be something like:
 
 ````
 @Qualifier
 @Retention(RUNTIME)
 @interface GitSha {
 }
 …
 
 @Inject Foo(@GitSha String gitSha) { …
 ````
 
 The equivalent in this system would be
 
 ````
 struct GitShaTag : Tag {
    typealias Element = String // It wouldn't make sense for other types of GitSha
 }
 …
 init(gitSHA: TaggedProvider<GitShaTag>) {
   self.gitSHA = gitSHA.value
 }
 ````
 Unlike java's annotation syste, Tag cannot have constants in them (there is no equivalent of @Named("omgponies")), but creation of them is much lighter weight and encourages better practices, so there shouldn't be much inconvenience.
 
 Users probably should not ever need to construct tagged values (outside of maybe tests). If you need to, use a .of variant
 
 
 Yes, you could create your own structs to wrap Strings, without using the tag protocol. The following is completely valid and would work:
 
 
 ````
 struct GitShaTaggedString {
    let value: String
    init(gitSHA: GitShaTaggedString) {
        self.gitSHA = gitSHA
    }
 }
 ````
 
 However there disadvantages of doing it the latter.
 
 First, you don't get to use the 'taggedWith' helper method of BindingBuilder.
 
 ````
 bind().tagged(with:  gitSHA.self).to(value: MY_GIT_SHA)
 ````
 
 goes to 
 
 ```
 bind().to(value: GitShaTaggedString(value: MY_GIT_SHA))
 ```

 This is the canonical Tag. It can only be used to attribute meaning to `Element`
 By using this instead of `UnqualifiedTag` we gain the benefit of documentation of intent and its not overloaded.
 Note that invalid combinations are not blocked at the compiler level when referencing Tagged<NotA, ATag> (and ATag should only apply to type A). BindingBuilder does prevent invalid combinations from being provided though
 
 It is also valid to make generic implementations which offer a type-safe alternatives to having a tag applied to a class of items.

*/

public protocol Tag : _BaseTag, _AnyTag {
    
    /// This tag should only be used on type Element
    associatedtype Element
}

/// So we can distinguish a Tag from _BaseTag
public protocol _AnyTag {
}

/// Base protocol for Tag. It exists so we can determine absense of tag using _VoidTag
public protocol _BaseTag {
}

/// This represents the absense of a tag
public struct _VoidTag : _BaseTag {
    
}