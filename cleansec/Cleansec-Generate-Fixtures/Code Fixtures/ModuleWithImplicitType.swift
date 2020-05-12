//
//  ModuleWithImplicitType.swift
//  cleansec-generate-fixtures
//
//  Created by Sebastian Edward Shanus on 5/1/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation
import Cleanse

 struct CoreAppModule7 : Cleanse.Module {
     static func configure(binder: Binder<Singleton>) {
         binder
             .bind()
             .to(factory: A.init)
     }
 }
