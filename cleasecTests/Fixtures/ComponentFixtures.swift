//
//  ComponentFixtures.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation


struct ComponentFixtures {
    /**
     ````
     struct Subcomponent: Component {
         static func configure(binder: Binder<Unscoped>) {
             
         }
         static func configureRoot(binder bind: ReceiptBinder<Int>) -> BindingReceipt<Int> {
             return bind.to(value: 3)
         }
         typealias Root = Int
     }
    ````
     */
    static let simpleComponentFixtures = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
    (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
    (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
    (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:20:1] "Subcomponent" interface type='Subcomponent.Type' access=internal non-resilient inherits: Component
      (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:15:5] "configure(binder:)" interface type='(Subcomponent.Type) -> (Binder<Unscoped>) -> ()' access=internal type
        (parameter "self" interface type='Subcomponent.Type')
        (parameter_list
          (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:26 - line:13:51])
        (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:53 - line:15:5]))
      (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:5 - line:18:5] "configureRoot(binder:)" interface type='(Subcomponent.Type) -> (ReceiptBinder<Int>) -> BindingReceipt<Int>' access=internal type
        (parameter "self" interface type='Subcomponent.Type')
        (parameter_list
          (parameter "bind" apiName=binder interface type='ReceiptBinder<Int>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:30 - line:16:62])
        (result
          (type_ident
            (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
              (type_ident
                (component id='Int' bind=Swift.(file).Int))))
        (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:87 - line:18:5]
          (return_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:32]
            (call_expr type='BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:32] nothrow arg_labels=value:
              (dot_syntax_call_expr type='(Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:21] nothrow
                (declref_expr type='(ReceiptBinder<Int>) -> (Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 - line:17:21] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> ReceiptBinder<Int>))] function_ref=single)
                (declref_expr type='ReceiptBinder<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:16] decl=Test.(file).Subcomponent.configureRoot(binder:).bind@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:38 function_ref=unapplied))
              (argument_shuffle_expr implicit type='(value: Int, file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:32] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> ReceiptBinder<Int>))]
                (tuple_expr type='(value: Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:32] names=value
                  (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 - line:17:31] value=3 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)))))))
      (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:5 - line:19:22] "Root" interface type='Subcomponent.Root.Type' access=internal type='Int')
      (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init()" interface type='(Subcomponent.Type) -> () -> Subcomponent' access=internal designated
        (parameter "self" interface type='Subcomponent' inout)
        (parameter_list)
        (brace_stmt implicit
          (return_stmt implicit)))
      (typealias implicit "Seed" interface type='Subcomponent.Seed.Type' access=internal type='Void')
      (typealias implicit "Scope" interface type='Subcomponent.Scope.Type' access=internal type='Unscoped')))
"""
    
    /**
     ````
     struct Subcomponent: RootComponent {
         static func configure(binder: Binder<Unscoped>) {
             
         }
         static func configureRoot(binder bind: ReceiptBinder<Int>) -> BindingReceipt<Int> {
             return bind.to(value: 3)
         }
         typealias Root = Int
     }

     ````
     */
    
    static let simpleRootComponentFixture = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:20:1] "Subcomponent" interface type='Subcomponent.Type' access=internal non-resilient inherits: RootComponent
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:15:5] "configure(binder:)" interface type='(Subcomponent.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='Subcomponent.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:26 - line:13:51])
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:53 - line:15:5]))
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:5 - line:18:5] "configureRoot(binder:)" interface type='(Subcomponent.Type) -> (ReceiptBinder<Int>) -> BindingReceipt<Int>' access=internal type
      (parameter "self" interface type='Subcomponent.Type')
      (parameter_list
        (parameter "bind" apiName=binder interface type='ReceiptBinder<Int>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:30 - line:16:62])
      (result
        (type_ident
          (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
            (type_ident
              (component id='Int' bind=Swift.(file).Int))))
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:87 - line:18:5]
        (return_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:32]
          (call_expr type='BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:32] nothrow arg_labels=value:
            (dot_syntax_call_expr type='(Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:21] nothrow
              (declref_expr type='(ReceiptBinder<Int>) -> (Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 - line:17:21] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> ReceiptBinder<Int>))] function_ref=single)
              (declref_expr type='ReceiptBinder<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:16] decl=Test.(file).Subcomponent.configureRoot(binder:).bind@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:38 function_ref=unapplied))
            (argument_shuffle_expr implicit type='(value: Int, file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:32] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> ReceiptBinder<Int>))]
              (tuple_expr type='(value: Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:32] names=value
                (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 - line:17:31] value=3 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)))))))
    (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:5 - line:19:22] "Root" interface type='Subcomponent.Root.Type' access=internal type='Int')
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init()" interface type='(Subcomponent.Type) -> () -> Subcomponent' access=internal designated
      (parameter "self" interface type='Subcomponent' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Seed" interface type='Subcomponent.Seed.Type' access=internal type='Void')
    (typealias implicit "Scope" interface type='Subcomponent.Scope.Type' access=internal type='Unscoped')))
"""
}
