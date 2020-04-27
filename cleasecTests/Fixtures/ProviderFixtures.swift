//
//  ProviderFixtures.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 4/22/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

struct ProviderFixtures {
    /**
     ````
     struct A {
         let number: Int
     }
     struct MyOtherWorld {
         static func configureMyInt(aaaa: ReceiptBinder<A>) -> BindingReceipt<A> {
             return aaaa.to(factory: A.init)
         }
     }

     struct AModule: Module {
         static func configure(binder: Binder<Unscoped>) {
         }
         
         static func thisWorld(bbbb: ReceiptBinder<Int>) -> BindingReceipt<Int> {
             bbbb.to(value: 4)
         }
     }
     ````
     */
    static let danglingProviderFixtures = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:14:1] "A" interface type='A.Type' access=internal non-resilient
    (pattern_binding_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:13:17]
      (pattern_typed type='Int'
        (pattern_named type='Int' 'number')
        (type_ident
          (component id='Int' bind=Swift.(file).Int))))
    (var_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] "number" type='Int' interface type='Int' access=internal let readImpl=stored immutable
      (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fe2e90e8068' interface type='(A) -> () -> Int' access=internal get_for=number
        (parameter "self" interface type='A')
        (parameter_list)
        (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
          (return_stmt implicit
            (member_ref_expr implicit type='Int' decl=Test.(file).A.number@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
              (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied))))))
    (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fe2e90e8068' interface type='(A) -> () -> Int' access=internal get_for=number
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
        (return_stmt implicit
          (member_ref_expr implicit type='Int' decl=Test.(file).A.number@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
            (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied)))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init(number:)" interface type='(A.Type) -> (Int) -> A' access=internal designated
      (parameter "self" interface type='A' inout)
      (parameter_list
        (parameter "number" apiName=number interface type='Int') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8])))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:1 - line:19:1] "MyOtherWorld" interface type='MyOtherWorld.Type' access=internal non-resilient
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:5 - line:18:5] "configureMyInt(aaaa:)" interface type='(MyOtherWorld.Type) -> (ReceiptBinder<A>) -> BindingReceipt<A>' access=internal type
      (parameter "self" interface type='MyOtherWorld.Type')
      (parameter_list
        (parameter "aaaa" apiName=aaaa interface type='ReceiptBinder<A>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:31 - line:16:54])
      (result
        (type_ident
          (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
            (type_ident
              (component id='A' bind=Test.(file).A@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8))))
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:77 - line:18:5]
        (return_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:39]
          (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:39] nothrow arg_labels=factory:
            (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping ((Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:21] nothrow
              (declref_expr type='(ReceiptBinder<A>) -> (StaticString, Int, StaticString, @escaping ((Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 - line:17:21] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> ReceiptBinder<A>) (substitution P_1 -> Int))] function_ref=single)
              (declref_expr type='ReceiptBinder<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:16] decl=Test.(file).MyOtherWorld.configureMyInt(aaaa:).aaaa@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:32 function_ref=unapplied))
            (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: ((Int)) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:39] tuple_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> ReceiptBinder<A>) (substitution P_1 -> Int))]
              (tuple_expr type='(factory: (Int) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:39] names=factory
                (constructor_ref_call_expr type='(Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:35] nothrow
                  (declref_expr type='(A.Type) -> (Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 - line:17:35] decl=Test.(file).A.init(number:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=unapplied)
                  (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] typerepr='A'))))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:8 - line:15:8] "init()" interface type='(MyOtherWorld.Type) -> () -> MyOtherWorld' access=internal designated
      (parameter "self" interface type='MyOtherWorld' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit))))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:1 - line:28:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:5 - line:23:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:26 - line:22:51])
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:53 - line:23:5]))
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:5 - line:27:5] "thisWorld(bbbb:)" interface type='(AModule.Type) -> (ReceiptBinder<Int>) -> BindingReceipt<Int>' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "bbbb" apiName=bbbb interface type='ReceiptBinder<Int>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:26 - line:25:51])
      (result
        (type_ident
          (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
            (type_ident
              (component id='Int' bind=Swift.(file).Int))))
      (call_expr type='BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:25] nothrow arg_labels=value:
        (dot_syntax_call_expr type='(Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:14] nothrow
          (declref_expr type='(ReceiptBinder<Int>) -> (Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 - line:26:14] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> ReceiptBinder<Int>))] function_ref=single)
          (declref_expr type='ReceiptBinder<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:9] decl=Test.(file).AModule.thisWorld(bbbb:).bbbb@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:27 function_ref=unapplied))
        (argument_shuffle_expr implicit type='(value: Int, file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 - line:26:25] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> ReceiptBinder<Int>))]
          (tuple_expr type='(value: Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 - line:26:25] names=value
            (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:24 - line:26:24] value=4 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:8 - line:21:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
      (parameter "self" interface type='AModule' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Unscoped')))
"""
    
    /**
     ````
     struct A {
         let number: Int
     }
     struct MyOtherWorld {
         static func configureMyA(aaaa: ReceiptBinder<A>) -> BindingReceipt<A> {
             return aaaa.to(factory: A.init)
         }
     }

     struct AModule: Module {
         static func configure(binder: Binder<Unscoped>) {
             binder.bind(A.self).configured(with: MyOtherWorld.configureMyA)
         }
     }
     ````
     */
    static let danglingAndReferenceProvidersFixture = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:14:1] "A" interface type='A.Type' access=internal non-resilient
    (pattern_binding_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:13:17]
      (pattern_typed type='Int'
        (pattern_named type='Int' 'number')
        (type_ident
          (component id='Int' bind=Swift.(file).Int))))
    (var_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] "number" type='Int' interface type='Int' access=internal let readImpl=stored immutable
      (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7f9bd205ce68' interface type='(A) -> () -> Int' access=internal get_for=number
        (parameter "self" interface type='A')
        (parameter_list)
        (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
          (return_stmt implicit
            (member_ref_expr implicit type='Int' decl=Test.(file).A.number@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
              (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied))))))
    (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7f9bd205ce68' interface type='(A) -> () -> Int' access=internal get_for=number
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
        (return_stmt implicit
          (member_ref_expr implicit type='Int' decl=Test.(file).A.number@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
            (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied)))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init(number:)" interface type='(A.Type) -> (Int) -> A' access=internal designated
      (parameter "self" interface type='A' inout)
      (parameter_list
        (parameter "number" apiName=number interface type='Int') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8])))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:1 - line:19:1] "MyOtherWorld" interface type='MyOtherWorld.Type' access=internal non-resilient
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:5 - line:18:5] "configureMyA(aaaa:)" interface type='(MyOtherWorld.Type) -> (ReceiptBinder<A>) -> BindingReceipt<A>' access=internal type
      (parameter "self" interface type='MyOtherWorld.Type')
      (parameter_list
        (parameter "aaaa" apiName=aaaa interface type='ReceiptBinder<A>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:29 - line:16:52])
      (result
        (type_ident
          (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
            (type_ident
              (component id='A' bind=Test.(file).A@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8))))
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:75 - line:18:5]
        (return_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:39]
          (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:39] nothrow arg_labels=factory:
            (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping ((Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:21] nothrow
              (declref_expr type='(ReceiptBinder<A>) -> (StaticString, Int, StaticString, @escaping ((Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:21 - line:17:21] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> ReceiptBinder<A>) (substitution P_1 -> Int))] function_ref=single)
              (declref_expr type='ReceiptBinder<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:16 - line:17:16] decl=Test.(file).MyOtherWorld.configureMyA(aaaa:).aaaa@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:30 function_ref=unapplied))
            (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: ((Int)) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:39] tuple_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> ReceiptBinder<A>) (substitution P_1 -> Int))]
              (tuple_expr type='(factory: (Int) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:23 - line:17:39] names=factory
                (constructor_ref_call_expr type='(Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:35] nothrow
                  (declref_expr type='(A.Type) -> (Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 - line:17:35] decl=Test.(file).A.init(number:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=unapplied)
                  (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] typerepr='A'))))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:8 - line:15:8] "init()" interface type='(MyOtherWorld.Type) -> () -> MyOtherWorld' access=internal designated
      (parameter "self" interface type='MyOtherWorld' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit))))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:1 - line:25:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:5 - line:24:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:26 - line:22:51])
      (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:9 - line:23:71] nothrow arg_labels=with:
        (dot_syntax_call_expr type='((ReceiptBinder<A>) -> BindingReceipt<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:9 - line:23:29] nothrow
          (declref_expr type='(BaseBindingBuilder<A, Binder<Unscoped>>) -> ((ReceiptBinder<A>) -> BindingReceipt<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:29 - line:23:29] decl=Cleanse.(file).BindToable extension.configured(with:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Unscoped>>))] function_ref=single)
          (call_expr type='BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:9 - line:23:27] nothrow arg_labels=_:
            (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:9 - line:23:16] nothrow
              (declref_expr type='(Binder<Unscoped>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:16 - line:23:16] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> A))] function_ref=single)
              (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:9 - line:23:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:27 function_ref=unapplied))
            (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 - line:23:27]
              (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:21 - line:23:23]
                (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:21 - line:23:21] typerepr='A')))))
        (tuple_expr type='(with: (ReceiptBinder<A>) -> BindingReceipt<A>)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:39 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:39 - line:23:71] names=with
          (function_conversion_expr implicit type='(ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:59 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:46 - line:23:59]
            (dot_syntax_call_expr type='(ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:59 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:46 - line:23:59] nothrow
              (declref_expr type='(MyOtherWorld.Type) -> (ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:59 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:59 - line:23:59] decl=Test.(file).MyOtherWorld.configureMyA(aaaa:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:17 function_ref=unapplied)
              (type_expr type='MyOtherWorld.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:46 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:46 - line:23:46] typerepr='MyOtherWorld'))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:8 - line:21:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
      (parameter "self" interface type='AModule' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Unscoped')))
"""
    
    /**
     ````
     class A {
     }

     struct AModule: Module {
         static func configure(binder: Binder<Unscoped>) {
             binder
                 .bindPropertyInjectionOf(A.self)
                 .to { (a: A, number: Int) in
             }
         }
     }
     ````
     */
    static let propertyInjectionBindingFixture = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (class_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:13:1] "A" interface type='A.Type' access=internal non-resilient
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7 - line:12:7] "init()" interface type='(A.Type) -> () -> A' access=internal designated
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (destructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7 - line:12:7] "deinit" interface type='(A) -> () -> ()' access=internal @objc
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7 - line:12:7])))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:1 - line:22:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:5 - line:21:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:26 - line:16:51])
      (call_expr type='BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:20:9] nothrow arg_labels=_:
        (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping (A, Int) -> Void) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:19:14] nothrow
          (declref_expr type='(PropertyInjectorBindingBuilder<Binder<Unscoped>, A>) -> (StaticString, Int, StaticString, @escaping (A, Int) -> Void) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:14 - line:19:14] decl=Cleanse.(file).PropertyInjectorBindingBuilderProtocol extension.to(file:line:function:injector:) [with (substitution_map generic_signature=<Self, P_1 where Self : PropertyInjectorBindingBuilderProtocol> (substitution Self -> PropertyInjectorBindingBuilder<Binder<Unscoped>, A>) (substitution P_1 -> Int))] function_ref=single)
          (call_expr type='PropertyInjectorBindingBuilder<Binder<Unscoped>, A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:18:44] nothrow arg_labels=_:
            (dot_syntax_call_expr type='(A.Type) -> PropertyInjectorBindingBuilder<Binder<Unscoped>, A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:18:14] nothrow
              (declref_expr type='(Binder<Unscoped>) -> (A.Type) -> PropertyInjectorBindingBuilder<Binder<Unscoped>, A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:14 - line:18:14] decl=Cleanse.(file).BinderBase extension.bindPropertyInjectionOf [with (substitution_map generic_signature=<Self, Element where Self : BinderBase, Element : AnyObject> (substitution Self -> Binder<Unscoped>) (substitution Element -> A))] function_ref=single)
              (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:27 function_ref=unapplied))
            (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:38 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:37 - line:18:44]
              (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:38 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:38 - line:18:40]
                (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:38 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:38 - line:18:38] typerepr='A')))))
        (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, injector: (A, Int) -> Void)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:17 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:17 - line:20:9] scalar_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).PropertyInjectorBindingBuilderProtocol extension.to(file:line:function:injector:) [with (substitution_map generic_signature=<Self, P_1 where Self : PropertyInjectorBindingBuilderProtocol> (substitution Self -> PropertyInjectorBindingBuilder<Binder<Unscoped>, A>) (substitution P_1 -> Int))]
          (paren_expr type='((A, Int) -> Void)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:17 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:17 - line:20:9] trailing-closure
            (closure_expr type='(A, Int) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:17 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:17 - line:20:9] discriminator=0 escaping
              (parameter_list
                (parameter "a" type='A' interface type='A')
                (parameter "number" type='Int' interface type='Int') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:19 - line:19:37])
              (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:17 - line:20:9]))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:8 - line:15:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
      (parameter "self" interface type='AModule' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Unscoped')))
"""
    /**
     ````
     class A {
         static func configureAppDelegateInjector(binder bind: PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>> {
             return bind.to { (a, number:Int) in
                 // Noop
             }
         }
     }

     struct Component: RootComponent {
         static func configureRoot(binder bind: ReceiptBinder<PropertyInjector<A>>) -> BindingReceipt<PropertyInjector<A>> {
             return bind.propertyInjector(configuredWith: A.configureAppDelegateInjector)
         }
         
         typealias Root = PropertyInjector<A>
         
         static func configure(binder: Binder<Unscoped>) {
         }
     }
     ````
     */
    static var rootPropertyInjectorProvider = """

(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (class_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:18:1] "A" interface type='A.Type' access=internal non-resilient
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:17:5] "configureAppDelegateInjector(binder:)" interface type='(A.Type) -> (PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>>' access=internal final type
      (parameter "self" interface type='A.Type')
      (parameter_list
        (parameter "bind" apiName=binder interface type='PropertyInjectionReceiptBinder<A>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:45 - line:13:92])
      (result
        (type_ident
          (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
            (type_ident
              (component id='PropertyInjector' bind=Cleanse.(file).PropertyInjector)
                (type_ident
                  (component id='A' bind=Test.(file).A@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7)))))
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:133 - line:17:5]
        (return_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:16:9]
          (call_expr type='BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:16 - line:16:9] nothrow arg_labels=_:
            (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping (A, Int) -> Void) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:16 - line:14:21] nothrow
              (declref_expr type='(PropertyInjectionReceiptBinder<A>) -> (StaticString, Int, StaticString, @escaping (A, Int) -> Void) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:21 - line:14:21] decl=Cleanse.(file).PropertyInjectorBindingBuilderProtocol extension.to(file:line:function:injector:) [with (substitution_map generic_signature=<Self, P_1 where Self : PropertyInjectorBindingBuilderProtocol> (substitution Self -> PropertyInjectionReceiptBinder<A>) (substitution P_1 -> Int))] function_ref=single)
              (declref_expr type='PropertyInjectionReceiptBinder<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:16 - line:14:16] decl=Test.(file).A.configureAppDelegateInjector(binder:).bind@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:53 function_ref=unapplied))
            (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, injector: (A, Int) -> Void)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:24 - line:16:9] scalar_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).PropertyInjectorBindingBuilderProtocol extension.to(file:line:function:injector:) [with (substitution_map generic_signature=<Self, P_1 where Self : PropertyInjectorBindingBuilderProtocol> (substitution Self -> PropertyInjectionReceiptBinder<A>) (substitution P_1 -> Int))]
              (paren_expr type='((A, Int) -> Void)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:24 - line:16:9] trailing-closure
                (closure_expr type='(A, Int) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:24 - line:16:9] discriminator=0 escaping
                  (parameter_list
                    (parameter "a" type='A' interface type='A')
                    (parameter "number" type='Int' interface type='Int') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:26 - line:14:40])
                  (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:24 - line:16:9]))))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7 - line:12:7] "init()" interface type='(A.Type) -> () -> A' access=internal designated
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (destructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7 - line:12:7] "deinit" interface type='(A) -> () -> ()' access=internal @objc
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7 - line:12:7])))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:1 - line:29:1] "Component" interface type='Component.Type' access=internal non-resilient inherits: RootComponent
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:5 - line:23:5] "configureRoot(binder:)" interface type='(Component.Type) -> (ReceiptBinder<PropertyInjector<A>>) -> BindingReceipt<PropertyInjector<A>>' access=internal type
      (parameter "self" interface type='Component.Type')
      (parameter_list
        (parameter "bind" apiName=binder interface type='ReceiptBinder<PropertyInjector<A>>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:30 - line:21:78])
      (result
        (type_ident
          (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
            (type_ident
              (component id='PropertyInjector' bind=Cleanse.(file).PropertyInjector)
                (type_ident
                  (component id='A' bind=Test.(file).A@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:7)))))
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:119 - line:23:5]
        (return_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 - line:22:84]
          (call_expr type='BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 - line:22:84] nothrow arg_labels=configuredWith:
            (dot_syntax_call_expr type='((PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>>) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 - line:22:21] nothrow
              (declref_expr type='(ReceiptBinder<PropertyInjector<A>>) -> ((PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>>) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 - line:22:21] decl=Cleanse.(file).BindToable extension.propertyInjector(configuredWith:) [with (substitution_map generic_signature=<Self where Self : BindToable, Self.Input : PropertyInjectorProtocol> (substitution Self -> ReceiptBinder<PropertyInjector<A>>))] function_ref=single)
              (declref_expr type='ReceiptBinder<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 - line:22:16] decl=Test.(file).Component.configureRoot(binder:).bind@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:38 function_ref=unapplied))
            (tuple_expr type='(configuredWith: (PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>>)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:37 - line:22:84] names=configuredWith
              (function_conversion_expr implicit type='(PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:56 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:54 - line:22:56]
                (dot_syntax_call_expr type='(PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:56 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:54 - line:22:56] nothrow
                  (declref_expr type='(A.Type) -> (PropertyInjectionReceiptBinder<A>) -> BindingReceipt<PropertyInjector<A>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:56 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:56 - line:22:56] decl=Test.(file).A.configureAppDelegateInjector(binder:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:17 function_ref=unapplied)
                  (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:54 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:54 - line:22:54] typerepr='A'))))))))
    (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:5 - line:25:40] "Root" interface type='Component.Root.Type' access=internal type='PropertyInjector<A>')
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:5 - line:28:5] "configure(binder:)" interface type='(Component.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='Component.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:26 - line:27:51])
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:53 - line:28:5]))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:8 - line:20:8] "init()" interface type='(Component.Type) -> () -> Component' access=internal designated
      (parameter "self" interface type='Component' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Seed" interface type='Component.Seed.Type' access=internal type='Void')
    (typealias implicit "Scope" interface type='Component.Scope.Type' access=internal type='Unscoped')))
"""
    
    /**
     ````
     struct A {
         let assisted: Assisted<Int>
         let string: String
     }

     class AssistedSeed: AssistedFactory {
         typealias Seed = Int
         typealias Element = A
     }

     struct AModule: Module {
         static func configure(binder: Binder<Unscoped>) {
             binder.bindFactory(A.self).with(AssistedSeed.self).to(factory: A.init)
         }
     }
     ````
     */
    static let assistedFactoryProviderFixture = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:15:1] "A" interface type='A.Type' access=internal non-resilient
    (pattern_binding_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:13:31]
      (pattern_typed type='Assisted<Int>'
        (pattern_named type='Assisted<Int>' 'assisted')
        (type_ident
          (component id='Assisted' bind=Cleanse.(file).Assisted)
            (type_ident
              (component id='Int' bind=Swift.(file).Int)))))
    (var_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] "assisted" type='Assisted<Int>' interface type='Assisted<Int>' access=internal let readImpl=stored immutable
      (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fd856339370' interface type='(A) -> () -> Assisted<Int>' access=internal get_for=assisted
        (parameter "self" interface type='A')
        (parameter_list)
        (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
          (return_stmt implicit
            (member_ref_expr implicit type='Assisted<Int>' decl=Test.(file).A.assisted@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
              (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied))))))
    (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fd856339370' interface type='(A) -> () -> Assisted<Int>' access=internal get_for=assisted
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
        (return_stmt implicit
          (member_ref_expr implicit type='Assisted<Int>' decl=Test.(file).A.assisted@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
            (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied)))))
    (pattern_binding_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:5 - line:14:17]
      (pattern_typed type='String'
        (pattern_named type='String' 'string')
        (type_ident
          (component id='String' bind=Swift.(file).String))))
    (var_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:14:9] "string" type='String' interface type='String' access=internal let readImpl=stored immutable
      (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:14:9] 'anonname=0x7fd856339570' interface type='(A) -> () -> String' access=internal get_for=string
        (parameter "self" interface type='A')
        (parameter_list)
        (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:14:9]
          (return_stmt implicit
            (member_ref_expr implicit type='String' decl=Test.(file).A.string@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 direct_to_storage
              (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 function_ref=unapplied))))))
    (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:14:9] 'anonname=0x7fd856339570' interface type='(A) -> () -> String' access=internal get_for=string
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:14:9]
        (return_stmt implicit
          (member_ref_expr implicit type='String' decl=Test.(file).A.string@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 direct_to_storage
            (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 function_ref=unapplied)))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init(assisted:string:)" interface type='(A.Type) -> (Assisted<Int>, String) -> A' access=internal designated
      (parameter "self" interface type='A' inout)
      (parameter_list
        (parameter "assisted" apiName=assisted interface type='Assisted<Int>')
        (parameter "string" apiName=string interface type='String') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8])))
  (class_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:1 - line:20:1] "AssistedSeed" interface type='AssistedSeed.Type' access=internal non-resilient inherits: AssistedFactory
    (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:5 - line:18:22] "Seed" interface type='AssistedSeed.Seed.Type' access=internal type='Int')
    (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:5 - line:19:25] "Element" interface type='AssistedSeed.Element.Type' access=internal type='A')
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:7 - line:17:7] "init()" interface type='(AssistedSeed.Type) -> () -> AssistedSeed' access=internal designated
      (parameter "self" interface type='AssistedSeed')
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (destructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:7 - line:17:7] "deinit" interface type='(AssistedSeed) -> () -> ()' access=internal @objc
      (parameter "self" interface type='AssistedSeed')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:7 - line:17:7])))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:1 - line:26:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:5 - line:25:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:26 - line:23:51])
      (call_expr type='BindingReceipt<Factory<AssistedSeed>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:60 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:78] nothrow arg_labels=factory:
        (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping ((Assisted<AssistedSeed.Seed>, String)) -> AssistedSeed.Element) -> BindingReceipt<Factory<AssistedSeed>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:60 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:60] nothrow
          (declref_expr type='(AssistedInjectionSeedDecorator<Binder<Unscoped>, A, AssistedSeed>) -> (StaticString, Int, StaticString, @escaping ((Assisted<AssistedSeed.Seed>, String)) -> AssistedSeed.Element) -> BindingReceipt<Factory<AssistedSeed>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:60 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:60 - line:24:60] decl=Cleanse.(file).AssistedInjectionBuilder extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : AssistedInjectionBuilder> (substitution Self -> AssistedInjectionSeedDecorator<Binder<Unscoped>, A, AssistedSeed>) (substitution P_1 -> String))] function_ref=single)
          (call_expr type='AssistedInjectionSeedDecorator<Binder<Unscoped>, A, AssistedSeed>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:36 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:58] nothrow arg_labels=_:
            (dot_syntax_call_expr type='(AssistedSeed.Type) -> AssistedInjectionSeedDecorator<Binder<Unscoped>, A, AssistedSeed>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:36 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:36] nothrow
              (declref_expr type='(AssistedInjectionBindingBuilder<Binder<Unscoped>, A>) -> (AssistedSeed.Type) -> AssistedInjectionSeedDecorator<Binder<Unscoped>, A, AssistedSeed>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:36 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:36 - line:24:36] decl=Cleanse.(file).AssistedInjectionBindingBuilder extension.with [with (substitution_map generic_signature=<B, E, S where B : BinderBase, E == S.Element, S : AssistedFactory> (substitution B -> Binder<Unscoped>) (substitution E -> A) (substitution S -> AssistedSeed))] function_ref=single)
              (call_expr type='AssistedInjectionBindingBuilder<Binder<Unscoped>, A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:34] nothrow arg_labels=_:
                (dot_syntax_call_expr type='(A.Type) -> AssistedInjectionBindingBuilder<Binder<Unscoped>, A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:16] nothrow
                  (declref_expr type='(Binder<Unscoped>) -> (A.Type) -> AssistedInjectionBindingBuilder<Binder<Unscoped>, A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 - line:24:16] decl=Cleanse.(file).BinderBase extension.bindFactory [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> A))] function_ref=single)
                  (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:27 function_ref=unapplied))
                (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:27 - line:24:34]
                  (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:28 - line:24:30]
                    (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:28 - line:24:28] typerepr='A')))))
            (paren_expr type='(AssistedSeed.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:41 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:40 - line:24:58]
              (dot_self_expr type='AssistedSeed.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:41 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:41 - line:24:54]
                (type_expr type='AssistedSeed.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:41 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:41 - line:24:41] typerepr='AssistedSeed')))))
        (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: ((Assisted<AssistedSeed.Seed>, String)) -> AssistedSeed.Element)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:62 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:62 - line:24:78] tuple_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).AssistedInjectionBuilder extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : AssistedInjectionBuilder> (substitution Self -> AssistedInjectionSeedDecorator<Binder<Unscoped>, A, AssistedSeed>) (substitution P_1 -> String))]
          (tuple_expr type='(factory: ((Assisted<AssistedSeed.Seed>, String)) -> AssistedSeed.Element)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:62 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:62 - line:24:78] names=factory
            (function_conversion_expr implicit type='((Assisted<AssistedSeed.Seed>, String)) -> AssistedSeed.Element' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:74 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:72 - line:24:74]
              (constructor_ref_call_expr type='(Assisted<Int>, String) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:74 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:72 - line:24:74] nothrow
                (declref_expr type='(A.Type) -> (Assisted<Int>, String) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:74 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:74 - line:24:74] decl=Test.(file).A.init(assisted:string:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=unapplied)
                (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:72 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:72 - line:24:72] typerepr='A')))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:8 - line:22:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
      (parameter "self" interface type='AModule' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Unscoped')))
"""
    
    /**
     ````
     struct MyTag: Tag {
         typealias Element = Int
     }

     struct A {
         let provider: TaggedProvider<MyTag>
     }
     struct AModule: Module {
         static func configure(binder: Binder<Unscoped>) {
             binder.bind(A.self).to(factory: A.init)
         }
     }
     ````
     */
    static let taggedProviderDependencyFixture = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:14:1] "MyTag" interface type='MyTag.Type' access=internal non-resilient inherits: Tag
    (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:13:25] "Element" interface type='MyTag.Element.Type' access=internal type='Int')
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init()" interface type='(MyTag.Type) -> () -> MyTag' access=internal designated
      (parameter "self" interface type='MyTag' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit))))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:1 - line:18:1] "A" interface type='A.Type' access=internal non-resilient
    (pattern_binding_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:5 - line:17:39]
      (pattern_typed type='TaggedProvider<MyTag>'
        (pattern_named type='TaggedProvider<MyTag>' 'provider')
        (type_ident
          (component id='TaggedProvider' bind=Cleanse.(file).TaggedProvider)
            (type_ident
              (component id='MyTag' bind=Test.(file).MyTag@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8)))))
    (var_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:9] "provider" type='TaggedProvider<MyTag>' interface type='TaggedProvider<MyTag>' access=internal let readImpl=stored immutable
      (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:9] 'anonname=0x7fd02ed4b160' interface type='(A) -> () -> TaggedProvider<MyTag>' access=internal get_for=provider
        (parameter "self" interface type='A')
        (parameter_list)
        (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:9]
          (return_stmt implicit
            (member_ref_expr implicit type='TaggedProvider<MyTag>' decl=Test.(file).A.provider@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 direct_to_storage
              (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 function_ref=unapplied))))))
    (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:9] 'anonname=0x7fd02ed4b160' interface type='(A) -> () -> TaggedProvider<MyTag>' access=internal get_for=provider
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 - line:17:9]
        (return_stmt implicit
          (member_ref_expr implicit type='TaggedProvider<MyTag>' decl=Test.(file).A.provider@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 direct_to_storage
            (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:9 function_ref=unapplied)))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:8 - line:16:8] "init(provider:)" interface type='(A.Type) -> (TaggedProvider<MyTag>) -> A' access=internal designated
      (parameter "self" interface type='A' inout)
      (parameter_list
        (parameter "provider" apiName=provider interface type='TaggedProvider<MyTag>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:8 - line:16:8])))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:1 - line:23:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:5 - line:22:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:26 - line:20:51])
      (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:21:47] nothrow arg_labels=factory:
        (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping ((TaggedProvider<MyTag>)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:21:29] nothrow
          (declref_expr type='(BaseBindingBuilder<A, Binder<Unscoped>>) -> (StaticString, Int, StaticString, @escaping ((TaggedProvider<MyTag>)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:29 - line:21:29] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Unscoped>>) (substitution P_1 -> TaggedProvider<MyTag>))] function_ref=single)
          (call_expr type='BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:21:27] nothrow arg_labels=_:
            (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:21:16] nothrow
              (declref_expr type='(Binder<Unscoped>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 - line:21:16] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> A))] function_ref=single)
              (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:21:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:27 function_ref=unapplied))
            (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:20 - line:21:27]
              (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:21 - line:21:23]
                (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:21 - line:21:21] typerepr='A')))))
        (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: ((TaggedProvider<MyTag>)) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:31 - line:21:47] tuple_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Unscoped>>) (substitution P_1 -> TaggedProvider<MyTag>))]
          (tuple_expr type='(factory: (TaggedProvider<MyTag>) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:31 - line:21:47] names=factory
            (constructor_ref_call_expr type='(TaggedProvider<MyTag>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:43 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:41 - line:21:43] nothrow
              (declref_expr type='(A.Type) -> (TaggedProvider<MyTag>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:43 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:43 - line:21:43] decl=Test.(file).A.init(provider:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:8 function_ref=unapplied)
              (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:41 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:41 - line:21:41] typerepr='A'))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:8 - line:19:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
      (parameter "self" interface type='AModule' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Unscoped')))
"""
    
    /**
     ````
     struct A {
         let a: Array<Int>
     }

     struct AModule: Module {
         static func configure(binder: Binder<Unscoped>) {
             binder.bind(A.self).to { (a:Array<Int>) -> A in
                 return A(a: a)
             }
             
             binder.bind(A.self).to { (a: [ [Int] ]) -> A in
                 return A(a: a.first!)
             }
             
             binder
                 .bind(Int.self)
                 .intoCollection()
                 .to(value: 5)
             
             binder
                 .bind(Int.self)
                 .intoCollection()
                 .to(value: [1,2,3])
             
             binder
                 .bind([Int].self)
                 .intoCollection()
                 .to(value: [2])
         }
     }

     ````
     */
    static let collectionBindingsFixture = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:14:1] "A" interface type='A.Type' access=internal non-resilient
    (pattern_binding_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:13:21]
      (pattern_typed type='Array<Int>'
        (pattern_named type='Array<Int>' 'a')
        (type_ident
          (component id='Array' bind=Swift.(file).Array)
            (type_ident
              (component id='Int' bind=Swift.(file).Int)))))
    (var_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] "a" type='Array<Int>' interface type='Array<Int>' access=internal let readImpl=stored immutable
      (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fc966877180' interface type='(A) -> () -> Array<Int>' access=internal get_for=a
        (parameter "self" interface type='A')
        (parameter_list)
        (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
          (return_stmt implicit
            (member_ref_expr implicit type='Array<Int>' decl=Test.(file).A.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
              (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied))))))
    (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fc966877180' interface type='(A) -> () -> Array<Int>' access=internal get_for=a
      (parameter "self" interface type='A')
      (parameter_list)
      (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
        (return_stmt implicit
          (member_ref_expr implicit type='Array<Int>' decl=Test.(file).A.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
            (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied)))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init(a:)" interface type='(A.Type) -> (Array<Int>) -> A' access=internal designated
      (parameter "self" interface type='A' inout)
      (parameter_list
        (parameter "a" apiName=a interface type='Array<Int>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8])))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:1 - line:41:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:5 - line:40:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:51])
      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:53 - line:40:5]
        (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:9 - line:20:9] nothrow arg_labels=_:
          (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping (([Int])) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:9 - line:18:29] nothrow
            (declref_expr type='(BaseBindingBuilder<A, Binder<Unscoped>>) -> (StaticString, Int, StaticString, @escaping (([Int])) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:29 - line:18:29] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Unscoped>>) (substitution P_1 -> [Int]))] function_ref=single)
            (call_expr type='BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:9 - line:18:27] nothrow arg_labels=_:
              (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:9 - line:18:16] nothrow
                (declref_expr type='(Binder<Unscoped>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:16 - line:18:16] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> A))] function_ref=single)
                (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:9 - line:18:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 function_ref=unapplied))
              (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:20 - line:18:27]
                (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:21 - line:18:23]
                  (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:21 - line:18:21] typerepr='A')))))
          (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: (([Int])) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:32 - line:20:9] scalar_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Unscoped>>) (substitution P_1 -> [Int]))]
            (paren_expr type='((([Int])) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:32 - line:20:9] trailing-closure
              (closure_expr type='(Array<Int>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:32 - line:20:9] discriminator=0 escaping single-expression
                (parameter_list
                  (parameter "a" type='Array<Int>' interface type='Array<Int>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:34 - line:18:47])
                (call_expr type='A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 - line:19:26] nothrow arg_labels=a:
                  (constructor_ref_call_expr type='(Array<Int>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 - line:19:20] nothrow
                    (declref_expr implicit type='(A.Type) -> (Array<Int>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 - line:19:20] decl=Test.(file).A.init(a:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=single)
                    (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:20 - line:19:20] typerepr='A'))
                  (tuple_expr type='(a: Array<Int>)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:21 - line:19:26] names=a
                    (declref_expr type='Array<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:25 - line:19:25] decl=Test.(file).AModule.configure(binder:).explicit closure discriminator=0.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:35 function_ref=unapplied)))))))
        (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 - line:24:9] nothrow arg_labels=_:
          (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping (([[Int]])) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 - line:22:29] nothrow
            (declref_expr type='(BaseBindingBuilder<A, Binder<Unscoped>>) -> (StaticString, Int, StaticString, @escaping (([[Int]])) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:29 - line:22:29] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Unscoped>>) (substitution P_1 -> [[Int]]))] function_ref=single)
            (call_expr type='BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 - line:22:27] nothrow arg_labels=_:
              (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 - line:22:16] nothrow
                (declref_expr type='(Binder<Unscoped>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 - line:22:16] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> A))] function_ref=single)
                (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 - line:22:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 function_ref=unapplied))
              (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:20 - line:22:27]
                (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 - line:22:23]
                  (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:21 - line:22:21] typerepr='A')))))
          (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: (([[Int]])) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 - line:24:9] scalar_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Unscoped>>) (substitution P_1 -> [[Int]]))]
            (paren_expr type='((([[Int]])) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 - line:24:9] trailing-closure
              (closure_expr type='([[Int]]) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 - line:24:9] discriminator=1 escaping single-expression
                (parameter_list
                  (parameter "a" type='[[Int]]' interface type='[[Int]]') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:34 - line:22:47])
                (call_expr type='A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 - line:23:33] nothrow arg_labels=a:
                  (constructor_ref_call_expr type='(Array<Int>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 - line:23:20] nothrow
                    (declref_expr implicit type='(A.Type) -> (Array<Int>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 - line:23:20] decl=Test.(file).A.init(a:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=single)
                    (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 - line:23:20] typerepr='A'))
                  (tuple_expr type='(a: [Int])' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:21 - line:23:33] names=a
                    (force_value_expr type='[Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:25 - line:23:32]
                      (member_ref_expr type='[Int]?' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:25 - line:23:27] decl=Swift.(file).Collection extension.first [with (substitution_map generic_signature=<Self where Self : Collection> (substitution Self -> [[Int]]))]
                        (declref_expr type='[[Int]]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:25 - line:23:25] decl=Test.(file).AModule.configure(binder:).explicit closure discriminator=1.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:35 function_ref=unapplied)))))))))
        (call_expr type='BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:29:25] nothrow arg_labels=value:
          (dot_syntax_call_expr type='(Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:29:14] nothrow
            (declref_expr type='(SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>) -> (Int, StaticString, Int, StaticString) -> BindingReceipt<Int>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:14 - line:29:14] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>))] function_ref=single)
            (call_expr type='SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:28:29] nothrow arg_labels=
              (dot_syntax_call_expr type='() -> SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:28:14] nothrow
                (declref_expr type='(BaseBindingBuilder<Int, Binder<Unscoped>>) -> () -> SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 - line:28:14] decl=Cleanse.(file).BindingBuilder extension.intoCollection() [with (substitution_map generic_signature=<Self where Self : BindingBuilder, Self.CollectionOrUnique == _UniqueBinding, Self.FinalProvider : _StandardProvider, Self.MaybeScope == Unscoped> (substitution Self -> BaseBindingBuilder<Int, Binder<Unscoped>>))] function_ref=single)
                (call_expr type='BaseBindingBuilder<Int, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:27:27] nothrow arg_labels=_:
                  (dot_syntax_call_expr type='(Int.Type) -> BaseBindingBuilder<Int, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:27:14] nothrow
                    (declref_expr type='(Binder<Unscoped>) -> (Int.Type) -> BaseBindingBuilder<Int, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 - line:27:14] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> Int))] function_ref=single)
                    (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 function_ref=unapplied))
                  (paren_expr type='(Int.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:18 - line:27:27]
                    (dot_self_expr type='Int.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:19 - line:27:23]
                      (type_expr type='Int.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:19 - line:27:19] typerepr='Int')))))
              (tuple_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:28 - line:28:29])))
          (argument_shuffle_expr implicit type='(value: Int, file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:16 - line:29:25] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>))]
            (tuple_expr type='(value: Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:16 - line:29:25] names=value
              (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:29:24 - line:29:24] value=5 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**))))
        (call_expr type='BindingReceipt<[Int]>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 - line:34:31] nothrow arg_labels=value:
          (dot_syntax_call_expr type='([Int], StaticString, Int, StaticString) -> BindingReceipt<[Int]>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 - line:34:14] nothrow
            (declref_expr type='(CollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>) -> ([Int], StaticString, Int, StaticString) -> BindingReceipt<[Int]>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:14 - line:34:14] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> CollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>))] function_ref=single)
            (call_expr type='CollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:33:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 - line:33:29] nothrow arg_labels=
              (dot_syntax_call_expr type='() -> CollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:33:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 - line:33:14] nothrow
                (declref_expr type='(BaseBindingBuilder<Int, Binder<Unscoped>>) -> () -> CollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:33:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:33:14 - line:33:14] decl=Cleanse.(file).BindingBuilder extension.intoCollection() [with (substitution_map generic_signature=<Self where Self : BindingBuilder, Self.CollectionOrUnique == _UniqueBinding, Self.FinalProvider : _StandardProvider, Self.MaybeScope == Unscoped> (substitution Self -> BaseBindingBuilder<Int, Binder<Unscoped>>))] function_ref=single)
                (call_expr type='BaseBindingBuilder<Int, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 - line:32:27] nothrow arg_labels=_:
                  (dot_syntax_call_expr type='(Int.Type) -> BaseBindingBuilder<Int, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 - line:32:14] nothrow
                    (declref_expr type='(Binder<Unscoped>) -> (Int.Type) -> BaseBindingBuilder<Int, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:14 - line:32:14] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> Int))] function_ref=single)
                    (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:31:9 - line:31:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 function_ref=unapplied))
                  (paren_expr type='(Int.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:18 - line:32:27]
                    (dot_self_expr type='Int.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:19 - line:32:23]
                      (type_expr type='Int.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:32:19 - line:32:19] typerepr='Int')))))
              (tuple_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:33:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:33:28 - line:33:29])))
          (argument_shuffle_expr implicit type='(value: [Int], file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:16 - line:34:31] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> CollectionBindingBuilderDecorator<BaseBindingBuilder<Int, Binder<Unscoped>>>))]
            (tuple_expr type='(value: [Int])' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:16 - line:34:31] names=value
              (array_expr type='[Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 - line:34:30]
                (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 - line:34:25] value=1 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:27 - line:34:27] value=2 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:29 - line:34:29] value=3 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                (semantic_expr
                  (call_expr implicit type='[Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 - line:34:29] nothrow arg_labels=arrayLiteral:_:_:
                    (constructor_ref_call_expr implicit type='(Int...) -> [Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 - line:34:24] nothrow
                      (declref_expr implicit type='(Array<Int>.Type) -> (Int...) -> [Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 - line:34:24] decl=Swift.(file).Array extension.init(arrayLiteral:) [with (substitution_map generic_signature=<Element> (substitution Element -> Int))] function_ref=single)
                      (type_expr implicit type='[Int].Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:24 - line:34:24] typerepr='[Int]'))
                    (argument_shuffle_expr implicit type='(arrayLiteral: Int...)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 - line:34:29] tuple_to_tuple elements=[-2] variadic_sources=[0, 1, 2] default_args_owner=Swift.(file).Array extension.init(arrayLiteral:) [with (substitution_map generic_signature=<Element> (substitution Element -> Int))]
                      (tuple_expr implicit type='(arrayLiteral: Int, Int, Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 - line:34:29] names=arrayLiteral,'',''
                        (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:25 - line:34:25] value=1 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                        (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:27 - line:34:27] value=2 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                        (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:34:29 - line:34:29] value=3 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)))))))))
        (call_expr type='BindingReceipt<[Int]>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 - line:39:27] nothrow arg_labels=value:
          (dot_syntax_call_expr type='([Int], StaticString, Int, StaticString) -> BindingReceipt<[Int]>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 - line:39:14] nothrow
            (declref_expr type='(SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<[Int], Binder<Unscoped>>>) -> ([Int], StaticString, Int, StaticString) -> BindingReceipt<[Int]>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:14 - line:39:14] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<[Int], Binder<Unscoped>>>))] function_ref=single)
            (call_expr type='SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<[Int], Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:38:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 - line:38:29] nothrow arg_labels=
              (dot_syntax_call_expr type='() -> SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<[Int], Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:38:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 - line:38:14] nothrow
                (declref_expr type='(BaseBindingBuilder<[Int], Binder<Unscoped>>) -> () -> SingularCollectionBindingBu
ilderDecorator<BaseBindingBuilder<[Int], Binder<Unscoped>>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:38:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:38:14 - line:38:14] decl=Cleanse.(file).BindingBuilder extension.intoCollection() [with (substitution_map generic_signature=<Self where Self : BindingBuilder, Self.CollectionOrUnique == _UniqueBinding, Self.FinalProvider : _StandardProvider, Self.MaybeScope == Unscoped> (substitution Self -> BaseBindingBuilder<[Int], Binder<Unscoped>>))] function_ref=single)
                (call_expr type='BaseBindingBuilder<[Int], Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 - line:37:29] nothrow arg_labels=_:
                  (dot_syntax_call_expr type='([Int].Type) -> BaseBindingBuilder<[Int], Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 - line:37:14] nothrow
                    (declref_expr type='(Binder<Unscoped>) -> ([Int].Type) -> BaseBindingBuilder<[Int], Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:14 - line:37:14] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> [Int]))] function_ref=single)
                    (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:36:9 - line:36:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 function_ref=unapplied))
                  (paren_expr type='([Int].Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:18 - line:37:29]
                    (dot_self_expr type='[Int].Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:19 - line:37:25]
                      (type_expr type='[Int].Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:37:19 - line:37:23] typerepr='[Int]')))))
              (tuple_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:38:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:38:28 - line:38:29])))
          (argument_shuffle_expr implicit type='(value: [Int], file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:16 - line:39:27] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> SingularCollectionBindingBuilderDecorator<BaseBindingBuilder<[Int], Binder<Unscoped>>>))]
            (tuple_expr type='(value: [Int])' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:16 - line:39:27] names=value
              (array_expr type='[Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 - line:39:26]
                (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 - line:39:25] value=2 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                (semantic_expr
                  (call_expr implicit type='[Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 - line:39:25] nothrow arg_labels=arrayLiteral:
                    (constructor_ref_call_expr implicit type='(Int...) -> [Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 - line:39:24] nothrow
                      (declref_expr implicit type='(Array<Int>.Type) -> (Int...) -> [Int]' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 - line:39:24] decl=Swift.(file).Array extension.init(arrayLiteral:) [with (substitution_map generic_signature=<Element> (substitution Element -> Int))] function_ref=single)
                      (type_expr implicit type='[Int].Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:24 - line:39:24] typerepr='[Int]'))
                    (argument_shuffle_expr implicit type='(arrayLiteral: Int...)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 - line:39:25] tuple_to_tuple elements=[-2] variadic_sources=[0] default_args_owner=Swift.(file).Array extension.init(arrayLiteral:) [with (substitution_map generic_signature=<Element> (substitution Element -> Int))]
                      (tuple_expr implicit type='(arrayLiteral: Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 - line:39:25] names=arrayLiteral
                        (integer_literal_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:39:25 - line:39:25] value=2 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)))))))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:8 - line:16:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
      (parameter "self" interface type='AModule' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Unscoped')))
"""
    
    /**
     ````
     struct A {
         let a: Array<Int>
     }

     struct ATag: Tag {
         typealias Element = A
     }

     struct AModule: Module {
         static func configureA(b: ReceiptBinder<A>) -> BindingReceipt<A> {
             return b.to(factory: A.init)
         }
         
         static func configure(binder: Binder<Singleton>) {
             binder.bind(A.self).sharedInScope().configured(with: configureA)
             binder.bind(A.self).tagged(with: ATag.self).configured(with: configureA)
         }
     }
     ````
     */
    static let decoratedReferenceProviderFixture = """
(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
 (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
 (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
 (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:14:1] "A" interface type='A.Type' access=internal non-resilient
   (pattern_binding_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:13:21]
     (pattern_typed type='Array<Int>'
       (pattern_named type='Array<Int>' 'a')
       (type_ident
         (component id='Array' bind=Swift.(file).Array)
           (type_ident
             (component id='Int' bind=Swift.(file).Int)))))
   (var_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] "a" type='Array<Int>' interface type='Array<Int>' access=internal let readImpl=stored immutable
     (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fc56b2088f8' interface type='(A) -> () -> Array<Int>' access=internal get_for=a
       (parameter "self" interface type='A')
       (parameter_list)
       (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
         (return_stmt implicit
           (member_ref_expr implicit type='Array<Int>' decl=Test.(file).A.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
             (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied))))))
   (accessor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9] 'anonname=0x7fc56b2088f8' interface type='(A) -> () -> Array<Int>' access=internal get_for=a
     (parameter "self" interface type='A')
     (parameter_list)
     (brace_stmt implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 - line:13:9]
       (return_stmt implicit
         (member_ref_expr implicit type='Array<Int>' decl=Test.(file).A.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 direct_to_storage
           (declref_expr implicit type='A' decl=Test.(file).A.<anonymous>.self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:9 function_ref=unapplied)))))
   (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init(a:)" interface type='(A.Type) -> (Array<Int>) -> A' access=internal designated
     (parameter "self" interface type='A' inout)
     (parameter_list
       (parameter "a" apiName=a interface type='Array<Int>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8])))
 (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:1 - line:18:1] "ATag" interface type='ATag.Type' access=internal non-resilient inherits: Tag
   (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:5 - line:17:25] "Element" interface type='ATag.Element.Type' access=internal type='A')
   (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:8 - line:16:8] "init()" interface type='(ATag.Type) -> () -> ATag' access=internal designated
     (parameter "self" interface type='ATag' inout)
     (parameter_list)
     (brace_stmt implicit
       (return_stmt implicit))))
 (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:1 - line:29:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
   (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:5 - line:23:5] "configureA(b:)" interface type='(AModule.Type) -> (ReceiptBinder<A>) -> BindingReceipt<A>' access=internal type
     (parameter "self" interface type='AModule.Type')
     (parameter_list
       (parameter "b" apiName=b interface type='ReceiptBinder<A>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:27 - line:21:47])
     (result
       (type_ident
         (component id='BindingReceipt' bind=Cleanse.(file).BindingReceipt)
           (type_ident
             (component id='A' bind=Test.(file).A@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8))))
     (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:70 - line:23:5]
       (return_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:9 - line:22:36]
         (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:18 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 - line:22:36] nothrow arg_labels=factory:
           (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping (([Int])) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:18 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 - line:22:18] nothrow
             (declref_expr type='(ReceiptBinder<A>) -> (StaticString, Int, StaticString, @escaping (([Int])) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:18 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:18 - line:22:18] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> ReceiptBinder<A>) (substitution P_1 -> [Int]))] function_ref=single)
             (declref_expr type='ReceiptBinder<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:16 - line:22:16] decl=Test.(file).AModule.configureA(b:).b@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:28 function_ref=unapplied))
           (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: (([Int])) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:20 - line:22:36] tuple_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1 where Self : BindToable> (substitution Self -> ReceiptBinder<A>) (substitution P_1 -> [Int]))]
             (tuple_expr type='(factory: (Array<Int>) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:20 - line:22:36] names=factory
               (constructor_ref_call_expr type='(Array<Int>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:30 - line:22:32] nothrow
                 (declref_expr type='(A.Type) -> (Array<Int>) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:32 - line:22:32] decl=Test.(file).A.init(a:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=unapplied)
                 (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:30 - line:22:30] typerepr='A'))))))))
   (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:5 - line:28:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Singleton>) -> ()' access=internal type
     (parameter "self" interface type='AModule.Type')
     (parameter_list
       (parameter "binder" apiName=binder interface type='Binder<Singleton>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:26 - line:25:52])
     (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:54 - line:28:5]
       (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:45 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:72] nothrow arg_labels=with:
         (dot_syntax_call_expr type='((ReceiptBinder<A>) -> BindingReceipt<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:45 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:45] nothrow
           (declref_expr type='(ScopedBindingDecorator<BaseBindingBuilder<A, Binder<Singleton>>, Singleton>) -> ((ReceiptBinder<A>) -> BindingReceipt<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:45 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:45 - line:26:45] decl=Cleanse.(file).BindToable extension.configured(with:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> ScopedBindingDecorator<BaseBindingBuilder<A, Binder<Singleton>>, Singleton>))] function_ref=single)
           (call_expr type='ScopedBindingDecorator<BaseBindingBuilder<A, Binder<Singleton>>, Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:43] nothrow arg_labels=
             (dot_syntax_call_expr type='() -> ScopedBindingDecorator<BaseBindingBuilder<A, Binder<Singleton>>, Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:29] nothrow
               (declref_expr type='(BaseBindingBuilder<A, Binder<Singleton>>) -> () -> ScopedBindingDecorator<BaseBindingBuilder<A, Binder<Singleton>>, Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:29 - line:26:29] decl=Cleanse.(file).BindingBuilder extension.sharedInScope() [with (substitution_map generic_signature=<Self where Self : BindingBuilder, Self.Binder : BinderType, Self.MaybeScope == Unscoped, Self.Binder.Scope : Scope> (substitution Self -> BaseBindingBuilder<A, Binder<Singleton>>))] function_ref=single)
               (call_expr type='BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:27] nothrow arg_labels=_:
                 (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:16] nothrow
                   (declref_expr type='(Binder<Singleton>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:16 - line:26:16] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Singleton>) (substitution Element -> A))] function_ref=single)
                   (declref_expr type='Binder<Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:9 - line:26:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:27 function_ref=unapplied))
                 (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:20 - line:26:27]
                   (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:21 - line:26:23]
                     (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:21 - line:26:21] typerepr='A')))))
             (tuple_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:42 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:42 - line:26:43])))
         (tuple_expr type='(with: (ReceiptBinder<A>) -> BindingReceipt<A>)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:55 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:55 - line:26:72] names=with
           (function_conversion_expr implicit type='(ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 - line:26:62]
             (dot_syntax_call_expr implicit type='(ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 - line:26:62] nothrow
               (declref_expr type='(AModule.Type) -> (ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 - line:26:62] decl=Test.(file).AModule.configureA(b:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:17 function_ref=unapplied)
               (declref_expr implicit type='AModule.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:62 - line:26:62] decl=Test.(file).AModule.configure(binder:).self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:17 function_ref=unapplied)))))
       (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:53 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 - line:27:80] nothrow arg_labels=with:
         (dot_syntax_call_expr type='((ReceiptBinder<A>) -> BindingReceipt<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:53 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 - line:27:53] nothrow
           (declref_expr type='(TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, ATag>) -> ((ReceiptBinder<A>) -> BindingReceipt<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:53 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:53 - line:27:53] decl=Cleanse.(file).BindToable extension.configured(with:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, ATag>))] function_ref=single)
           (call_expr type='TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, ATag>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 - line:27:51] nothrow arg_labels=with:
             (dot_syntax_call_expr type='(ATag.Type) -> TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, ATag>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 - line:27:29] nothrow
               (declref_expr type='(BaseBindingBuilder<A, Binder<Singleton>>) -> (ATag.Type) -> TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, ATag>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:29 - line:27:29] decl=Cleanse.(file).BindingBuilder extension.tagged(with:) [with (substitution_map generic_signature=<Self, Tag where Self : BindingBuilder, Tag : Tag, Self.FinalProvider : _StandardProvider, Self.MaybeScope == Unscoped, Tag.Element == Self.FinalProvider.Element>
(substitution Self -> BaseBindingBuilder<A, Binder<Singleton>>) (substitution Tag -> ATag))] function_ref=single)
               (call_expr type='BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 - line:27:27] nothrow arg_labels=_:
                 (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 - line:27:16] nothrow
                   (declref_expr type='(Binder<Singleton>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:16 - line:27:16] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Singleton>) (substitution Element -> A))] function_ref=single)
                   (declref_expr type='Binder<Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:9 - line:27:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:27 function_ref=unapplied))
                 (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:20 - line:27:27]
                   (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:21 - line:27:23]
                     (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:21 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:21 - line:27:21] typerepr='A')))))
             (tuple_expr type='(with: ATag.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:35 - line:27:51] names=with
               (dot_self_expr type='ATag.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:42 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:42 - line:27:47]
                 (type_expr type='ATag.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:42 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:42 - line:27:42] typerepr='ATag')))))
         (tuple_expr type='(with: (ReceiptBinder<A>) -> BindingReceipt<A>)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:63 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:63 - line:27:80] names=with
           (function_conversion_expr implicit type='(ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 - line:27:70]
             (dot_syntax_call_expr implicit type='(ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 - line:27:70] nothrow
               (declref_expr type='(AModule.Type) -> (ReceiptBinder<A>) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 - line:27:70] decl=Test.(file).AModule.configureA(b:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:17 function_ref=unapplied)
               (declref_expr implicit type='AModule.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:70 - line:27:70] decl=Test.(file).AModule.configure(binder:).self@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:17 function_ref=unapplied)))))))
   (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:8 - line:20:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
     (parameter "self" interface type='AModule' inout)
     (parameter_list)
     (brace_stmt implicit
       (return_stmt implicit)))
   (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Singleton')))
"""

    /**
     ````
     extension UIViewController {
         /// This will represent the rootViewController that is assigned to our main window
         struct Root : Tag {
             typealias Element = UIViewController
         }
     }

     struct AModule: Module {
         static func configure(binder: Binder<Unscoped>) {
             binder
                 .bind(UIViewController.self)
                 .tagged(with: UIViewController.Root.self)
                 .to(value: UIViewController(nibName: nil, bundle: nil))
         }
     }
     ````
     */
    static var referencedInnerTagFixture = """

(source_file "/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift"
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:9:1 - line:9:8] 'Foundation')
  (import_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:10:1 - line:10:8] 'Cleanse')
  (extension_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:17:1] UIViewController
    (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:5 - line:16:5] "Root" interface type='UIViewController.Root.Type' access=internal non-resilient inherits: Tag
      (typealias range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:9 - line:15:29] "Element" interface type='UIViewController.Root.Element.Type' access=internal type='UIViewController')
      (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:12 - line:14:12] "init()" interface type='(UIViewController.Root.Type) -> () -> UIViewController.Root' access=internal designated
        (parameter "self" interface type='UIViewController.Root' inout)
        (parameter_list)
        (brace_stmt implicit
          (return_stmt implicit)))))
  (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:1 - line:26:1] "AModule" interface type='AModule.Type' access=internal non-resilient inherits: Module
    (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:5 - line:25:5] "configure(binder:)" interface type='(AModule.Type) -> (Binder<Unscoped>) -> ()' access=internal type
      (parameter "self" interface type='AModule.Type')
      (parameter_list
        (parameter "binder" apiName=binder interface type='Binder<Unscoped>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:26 - line:20:51])
      (call_expr type='BindingReceipt<UIViewController>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:24:67] nothrow arg_labels=value:
        (dot_syntax_call_expr type='(UIViewController, StaticString, Int, StaticString) -> BindingReceipt<UIViewController>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:24:14] nothrow
          (declref_expr type='(TaggedBindingBuilderDecorator<BaseBindingBuilder<UIViewController, Binder<Unscoped>>, UIViewController.Root>) -> (UIViewController, StaticString, Int, StaticString) -> BindingReceipt<UIViewController>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:14 - line:24:14] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> TaggedBindingBuilderDecorator<BaseBindingBuilder<UIViewController, Binder<Unscoped>>, UIViewController.Root>))] function_ref=single)
          (call_expr type='TaggedBindingBuilderDecorator<BaseBindingBuilder<UIViewController, Binder<Unscoped>>, UIViewController.Root>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:23:53] nothrow arg_labels=with:
            (dot_syntax_call_expr type='(UIViewController.Root.Type) -> TaggedBindingBuilderDecorator<BaseBindingBuilder<UIViewController, Binder<Unscoped>>, UIViewController.Root>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:23:14] nothrow
              (declref_expr type='(BaseBindingBuilder<UIViewController, Binder<Unscoped>>) -> (UIViewController.Root.Type) -> TaggedBindingBuilderDecorator<BaseBindingBuilder<UIViewController, Binder<Unscoped>>, UIViewController.Root>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:14 - line:23:14] decl=Cleanse.(file).BindingBuilder extension.tagged(with:) [with (substitution_map generic_signature=<Self, Tag where Self : BindingBuilder, Tag : Tag, Self.FinalProvider : _StandardProvider, Self.MaybeScope == Unscoped, Tag.Element == Self.FinalProvider.Element> (substitution Self -> BaseBindingBuilder<UIViewController, Binder<Unscoped>>) (substitution Tag -> UIViewController.Root))] function_ref=single)
              (call_expr type='BaseBindingBuilder<UIViewController, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:22:40] nothrow arg_labels=_:
                (dot_syntax_call_expr type='(UIViewController.Type) -> BaseBindingBuilder<UIViewController, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:22:14] nothrow
                  (declref_expr type='(Binder<Unscoped>) -> (UIViewController.Type) -> BaseBindingBuilder<UIViewController, Binder<Unscoped>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:14 - line:22:14] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Unscoped>) (substitution Element -> UIViewController))] function_ref=single)
                  (declref_expr type='Binder<Unscoped>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:9 - line:21:9] decl=Test.(file).AModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:27 function_ref=unapplied))
                (paren_expr type='(UIViewController.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:18 - line:22:40]
                  (dot_self_expr type='UIViewController.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:19 - line:22:36]
                    (type_expr type='UIViewController.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:19 - line:22:19] typerepr='UIViewController')))))
            (tuple_expr type='(with: UIViewController.Root.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:20 - line:23:53] names=with
              (dot_self_expr type='UIViewController.Root.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:27 - line:23:49]
                (type_expr type='UIViewController.Root.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:27 - line:23:44] typerepr='UIViewController.Root')))))
        (argument_shuffle_expr implicit type='(value: UIViewController, file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 - line:24:67] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> TaggedBindingBuilderDecorator<BaseBindingBuilder<UIViewController, Binder<Unscoped>>, UIViewController.Root>))]
          (tuple_expr type='(value: UIViewController)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:16 - line:24:67] names=value
            (call_expr type='UIViewController' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 - line:24:66] nothrow arg_labels=nibName:bundle:
              (constructor_ref_call_expr type='(String?, Bundle?) -> UIViewController' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 - line:24:24] nothrow
                (declref_expr implicit type='(UIViewController.Type) -> (String?, Bundle?) -> UIViewController' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 - line:24:24] decl=UIKit.(file).UIViewController.init(nibName:bundle:) function_ref=single)
                (type_expr type='UIViewController.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:24 - line:24:24] typerepr='UIViewController'))
              (tuple_expr type='(nibName: String?, bundle: Bundle?)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:40 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:40 - line:24:66] names=nibName,bundle
                (dot_syntax_call_expr implicit type='String?' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:50 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:50 - line:24:50] nothrow
                  (declref_expr implicit type='(String?.Type) -> String?' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:50 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:50 - line:24:50] decl=Swift.(file).Optional.none [with (substitution_map generic_signature=<Wrapped> (substitution Wrapped -> String))] function_ref=unapplied)
                  (type_expr implicit type='String?.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:50 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:50 - line:24:50] typerepr='String?'))
                (dot_syntax_call_expr implicit type='Bundle?' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:63 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:63 - line:24:63] nothrow
                  (declref_expr implicit type='(Bundle?.Type) -> Bundle?' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:63 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:63 - line:24:63] decl=Swift.(file).Optional.none [with (substitution_map generic_signature=<Wrapped> (substitution Wrapped -> Bundle))] function_ref=unapplied)
                  (type_expr implicit type='Bundle?.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:63 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:63 - line:24:63] typerepr='Bundle?'))))))))
    (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:8 - line:19:8] "init()" interface type='(AModule.Type) -> () -> AModule' access=internal designated
      (parameter "self" interface type='AModule' inout)
      (parameter_list)
      (brace_stmt implicit
        (return_stmt implicit)))
    (typealias implicit "Scope" interface type='AModule.Scope.Type' access=internal type='Unscoped')))
"""
}
