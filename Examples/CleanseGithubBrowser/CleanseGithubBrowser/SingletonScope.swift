//
//  SingletonScope.swift
//  CleanseGithubBrowser
//
//  Created by holmes on 6/28/17.
//  Copyright © 2017 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

public struct Singleton : Cleanse.Scope {
}

public typealias SingletonBinder = Binder<Singleton>
