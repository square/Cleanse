//
//  ModuleFixtures.swift
//  cleasecTests
//
//  Created by Sebastian Edward Shanus on 4/21/20.
//  Copyright © 2020 Square, Inc. All rights reserved.
//

import Foundation

struct ModuleFixtures {
    /**
     ````
     struct CoreAppModule : Cleanse.Module {
         static func configure(binder: Binder<Singleton>) {
             binder
             .bind(String.self)
             .to { (a: Int, b: Character, c: Float) -> String in
                     return "\(a)\(b)\(c)"
             }
         }
     }
     ````
     */
    static let moduleBindingWith3Dependenices = """
    (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:20:1] "CoreAppModule" interface type='CoreAppModule.Type' access=internal non-resilient inherits: Module
      (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:19:5] "configure(binder:)" interface type='(CoreAppModule.Type) -> (Binder<Singleton>) -> ()' access=internal type
        (parameter "self" interface type='CoreAppModule.Type')
        (parameter_list
          (parameter "binder" apiName=binder interface type='Binder<Singleton>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:26 - line:13:52])
        (call_expr type='BindingReceipt<String>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:18:9] nothrow arg_labels=_:
          (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping ((Int, Character, Float)) -> String) -> BindingReceipt<String>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:16:10] nothrow
            (declref_expr type='(BaseBindingBuilder<String, Binder<Singleton>>) -> (StaticString, Int, StaticString, @escaping ((Int, Character, Float)) -> String) -> BindingReceipt<String>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 - line:16:10] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1, P_2, P_3 where Self : BindToable> (substitution Self -> BaseBindingBuilder<String, Binder<Singleton>>) (substitution P_1 -> Int) (substitution P_2 -> Character) (substitution P_3 -> Float))] function_ref=single)
            (call_expr type='BaseBindingBuilder<String, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:15:26] nothrow arg_labels=_:
              (dot_syntax_call_expr type='(String.Type) -> BaseBindingBuilder<String, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:15:10] nothrow
                (declref_expr type='(Binder<Singleton>) -> (String.Type) -> BaseBindingBuilder<String, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 - line:15:10] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Singleton>) (substitution Element -> String))] function_ref=single)
                (declref_expr type='Binder<Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:14:9] decl=Test.(file).CoreAppModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:27 function_ref=unapplied))
              (paren_expr type='(String.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:14 - line:15:26]
                (dot_self_expr type='String.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 - line:15:22]
                  (type_expr type='String.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 - line:15:15] typerepr='String')))))
          (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: ((Int, Character, Float)) -> String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 - line:18:9] scalar_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1, P_2, P_3 where Self : BindToable> (substitution Self -> BaseBindingBuilder<String, Binder<Singleton>>) (substitution P_1 -> Int) (substitution P_2 -> Character) (substitution P_3 -> Float))]
            (paren_expr type='(((Int, Character, Float)) -> String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 - line:18:9] trailing-closure
              (function_conversion_expr implicit type='((Int, Character, Float)) -> String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 - line:18:9]
                (closure_expr type='(Int, Character, Float) -> String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:13 - line:18:9] discriminator=0 escaping single-expression
                  (parameter_list
                    (parameter "a" type='Int' interface type='Int')
                    (parameter "b" type='Character' interface type='Character')
                    (parameter "c" type='Float' interface type='Float') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:15 - line:16:46])
                  (interpolated_string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] literal_capacity=0 interpolation_count=3
                    (tap_expr implicit type='String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] var=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation
                      (call_expr implicit type='String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] nothrow arg_labels=literalCapacity:interpolationCount:
                        (constructor_ref_call_expr implicit type='(Int, Int) -> String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] nothrow
                          (declref_expr implicit type='(DefaultStringInterpolation.Type) -> (Int, Int) -> String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] decl=Swift.(file).DefaultStringInterpolation.init(literalCapacity:interpolationCount:) function_ref=single)
                          (type_expr implicit type='String.StringInterpolation.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] typerepr='String.StringInterpolation'))
                        (tuple_expr implicit type='(literalCapacity: Int, interpolationCount: Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] names=literalCapacity,interpolationCount
                          (integer_literal_expr implicit type='Int' value=0 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                          (integer_literal_expr implicit type='Int' value=3 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)))
                      (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:38]
                        (var_decl implicit "$interpolation" type='String.StringInterpolation' interface type='String.StringInterpolation' access=private non_pattern_init readImpl=stored writeImpl=stored readWriteImpl=stored)

                        (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:24] nothrow arg_labels=_:
                          (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:25] nothrow
                            (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                            (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:25]
                              (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:25] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                          (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24]
                            (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))
                        (call_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:28] nothrow arg_labels=_:
                          (dot_syntax_call_expr implicit type='(Int) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:26] nothrow
                            (declref_expr implicit type='(inout DefaultStringInterpolation) -> (Int) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendInterpolation [with (substitution_map generic_signature=<T where T : CustomStringConvertible> (substitution T -> Int))] function_ref=single)
                            (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:26]
                              (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:26] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                          (paren_expr type='(Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:28]
                            (declref_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 - line:17:27] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:16 function_ref=unapplied)))
                        (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] nothrow arg_labels=_:
                          (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] nothrow
                            (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                            (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29]
                              (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                          (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29]
                            (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))
                        (call_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:32] nothrow arg_labels=_:
                          (dot_syntax_call_expr implicit type='(Character) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:30] nothrow
                            (declref_expr implicit type='(inout DefaultStringInterpolation) -> (Character) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendInterpolation [with (substitution_map generic_signature=<T where T : CustomStringConvertible, T : TextOutputStreamable> (substitution T -> Character))] function_ref=single)
                            (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:30]
                              (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:30] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                          (paren_expr type='(Character)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:32]
                            (declref_expr type='Character' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 - line:17:31] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.b@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:24 function_ref=unapplied)))
                        (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] nothrow arg_labels=_:
                          (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] nothrow
                            (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                            (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33]
                              (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                          (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33]
                            (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))
                        (call_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:36] nothrow arg_labels=_:
                          (dot_syntax_call_expr implicit type='(Float) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:34] nothrow
                            (declref_expr implicit type='(inout DefaultStringInterpolation) -> (Float) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendInterpolation [with (substitution_map generic_signature=<T where T : CustomStringConvertible, T : TextOutputStreamable> (substitution T -> Float))] function_ref=single)
                            (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:34]
                              (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:34] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                          (paren_expr type='(Float)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:36]
                            (declref_expr type='Float' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 - line:17:35] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.c@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:38 function_ref=unapplied)))
                        (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] nothrow arg_labels=_:
                          (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] nothrow
                            (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                            (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37]
                              (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                          (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37]
                            (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))))
                    (semantic_expr
                      (call_expr implicit type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] nothrow arg_labels=stringInterpolation:
                        (constructor_ref_call_expr implicit type='(DefaultStringInterpolation) -> String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] nothrow
                          (declref_expr implicit type='(String.Type) -> (DefaultStringInterpolation) -> String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] decl=Swift.(file).String extension.init(stringInterpolation:) function_ref=single)
                          (type_expr implicit type='String.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] typerepr='String'))
                        (tuple_expr implicit type='(stringInterpolation: String.StringInterpolation)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] names=stringInterpolation
                          (tap_expr implicit type='String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] var=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation
                            (call_expr implicit type='String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] nothrow arg_labels=literalCapacity:interpolationCount:
                              (constructor_ref_call_expr implicit type='(Int, Int) -> String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] nothrow
                                (declref_expr implicit type='(DefaultStringInterpolation.Type) -> (Int, Int) -> String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] decl=Swift.(file).DefaultStringInterpolation.init(literalCapacity:interpolationCount:) function_ref=single)
                                (type_expr implicit type='String.StringInterpolation.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] typerepr='String.StringInterpolation'))
                              (tuple_expr implicit type='(literalCapacity: Int, interpolationCount: Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] names=literalCapacity,interpolationCount
                                (integer_literal_expr implicit type='Int' value=0 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)
                                (integer_literal_expr implicit type='Int' value=3 builtin_initializer=Swift.(file).Int.init(_builtinIntegerLiteral:) initializer=**NULL**)))
                            (brace_stmt range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:38]
                              (var_decl implicit "$interpolation" type='String.StringInterpolation' interface type='String.StringInterpolation' access=private non_pattern_init readImpl=stored writeImpl=stored readWriteImpl=stored)

                              (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:24] nothrow arg_labels=_:
                                (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:25] nothrow
                                  (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                                  (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:25]
                                    (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:25 - line:17:25] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                                (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24]
                                  (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:24 - line:17:24] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))
                              (call_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:28] nothrow arg_labels=_:
                                (dot_syntax_call_expr implicit type='(Int) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:26] nothrow
                                  (declref_expr implicit type='(inout DefaultStringInterpolation) -> (Int) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendInterpolation [with (substitution_map generic_signature=<T where T : CustomStringConvertible> (substitution T -> Int))] function_ref=single)
                                  (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:26]
                                    (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:26] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                                (paren_expr type='(Int)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:26 - line:17:28]
                                  (declref_expr type='Int' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:27 - line:17:27] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.a@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:16 function_ref=unapplied)))
                              (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] nothrow arg_labels=_:
                                (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] nothrow
                                  (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                                  (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29]
                                    (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                                (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29]
                                  (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:29 - line:17:29] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))
                              (call_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:32] nothrow arg_labels=_:
                                (dot_syntax_call_expr implicit type='(Character) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:30] nothrow
                                  (declref_expr implicit type='(inout DefaultStringInterpolation) -> (Character) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendInterpolation [with (substitution_map generic_signature=<T where T : CustomStringConvertible, T : TextOutputStreamable> (substitution T -> Character))] function_ref=single)
               
                     (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:30]
                                    (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:30] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                                (paren_expr type='(Character)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:30 - line:17:32]
                                  (declref_expr type='Character' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:31 - line:17:31] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.b@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:24 function_ref=unapplied)))
                              (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] nothrow arg_labels=_:
                                (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] nothrow
                                  (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                                  (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33]
                                    (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                                (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33]
                                  (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:33 - line:17:33] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))
                              (call_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:36] nothrow arg_labels=_:
                                (dot_syntax_call_expr implicit type='(Float) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:34] nothrow
                                  (declref_expr implicit type='(inout DefaultStringInterpolation) -> (Float) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendInterpolation [with (substitution_map generic_signature=<T where T : CustomStringConvertible, T : TextOutputStreamable> (substitution T -> Float))] function_ref=single)
                                  (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:34]
                                    (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:34] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                                (paren_expr type='(Float)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:34 - line:17:36]
                                  (declref_expr type='Float' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:35 - line:17:35] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.c@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:38 function_ref=unapplied)))
                              (call_expr implicit type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] nothrow arg_labels=_:
                                (dot_syntax_call_expr implicit type='(String) -> ()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] nothrow
                                  (declref_expr implicit type='(inout DefaultStringInterpolation) -> (String) -> ()' decl=Swift.(file).DefaultStringInterpolation.appendLiteral function_ref=single)
                                  (inout_expr implicit type='inout DefaultStringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37]
                                    (declref_expr implicit type='@lvalue String.StringInterpolation' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] decl=Test.(file).CoreAppModule.configure(binder:).explicit closure discriminator=0.$interpolation function_ref=unapplied)))
                                (paren_expr implicit type='(String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37]
                                  (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:37 - line:17:37] encoding=utf8 value="" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))))))))))))))
      (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init()" interface type='(CoreAppModule.Type) -> () -> CoreAppModule' access=internal designated
        (parameter "self" interface type='CoreAppModule' inout)
        (parameter_list)
        (brace_stmt implicit
          (return_stmt implicit)))
      (typealias implicit "Scope" interface type='CoreAppModule.Scope.Type' access=internal type='Singleton')))

}
"""
    
    /**
     ````
     struct CoreAppModule : Cleanse.Module {
         static func configure(binder: Binder<Singleton>) {
             binder
             .bind(String.self)
             .to(value: "square")
         }
     }
     ````
     */
    static let simpleModuleBinding = """
      (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:1 - line:18:1] "CoreAppModule" interface type='CoreAppModule.Type' access=internal non-resilient inherits: Module
        (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:5 - line:17:5] "configure(binder:)" interface type='(CoreAppModule.Type) -> (Binder<Singleton>) -> ()' access=internal type
          (parameter "self" interface type='CoreAppModule.Type')
          (parameter_list
            (parameter "binder" apiName=binder interface type='Binder<Singleton>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:26 - line:13:52])
          (call_expr type='BindingReceipt<String>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:16:28] nothrow arg_labels=value:
            (dot_syntax_call_expr type='(String, StaticString, Int, StaticString) -> BindingReceipt<String>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:16:10] nothrow
              (declref_expr type='(BaseBindingBuilder<String, Binder<Singleton>>) -> (String, StaticString, Int, StaticString) -> BindingReceipt<String>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:10 - line:16:10] decl=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> BaseBindingBuilder<String, Binder<Singleton>>))] function_ref=single)
              (call_expr type='BaseBindingBuilder<String, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:15:26] nothrow arg_labels=_:
                (dot_syntax_call_expr type='(String.Type) -> BaseBindingBuilder<String, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:15:10] nothrow
                  (declref_expr type='(Binder<Singleton>) -> (String.Type) -> BaseBindingBuilder<String, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:10 - line:15:10] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Singleton>) (substitution Element -> String))] function_ref=single)
                  (declref_expr type='Binder<Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:14:9 - line:14:9] decl=Test.(file).CoreAppModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:13:27 function_ref=unapplied))
                (paren_expr type='(String.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:14 - line:15:26]
                  (dot_self_expr type='String.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 - line:15:22]
                    (type_expr type='String.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:15:15 - line:15:15] typerepr='String')))))
            (argument_shuffle_expr implicit type='(value: String, file: StaticString, line: Int, function: StaticString)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:12 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:12 - line:16:28] tuple_to_tuple elements=[0, -3, -3, -3] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(value:file:line:function:) [with (substitution_map generic_signature=<Self where Self : BindToable> (substitution Self -> BaseBindingBuilder<String, Binder<Singleton>>))]
              (tuple_expr type='(value: String)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:12 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:12 - line:16:28] names=value
                (string_literal_expr type='String' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:16:20 - line:16:20] encoding=utf8 value="square" builtin_initializer=Swift.(file).String extension.init(_builtinStringLiteral:utf8CodeUnitCount:isASCII:) initializer=**NULL**)))))
        (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 - line:12:8] "init()" interface type='(CoreAppModule.Type) -> () -> CoreAppModule' access=internal designated
          (parameter "self" interface type='CoreAppModule' inout)
          (parameter_list)
          (brace_stmt implicit
            (return_stmt implicit)))
        (typealias implicit "Scope" interface type='CoreAppModule.Scope.Type' access=internal type='Singleton')))
    """
    
    /**
     ````
     struct A {
         let string: String
         let number: Int
     }

     struct CoreAppModule : Cleanse.Module {
         static func configure(binder: Binder<Singleton>) {
             binder
                 .bind(A.self)
                 .to(factory: A.init)
         }
     }
     ````
     */
    static let implicitModuleBinding = """
      (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:1 - line:23:1] "CoreAppModule" interface type='CoreAppModule.Type' access=internal non-resilient inherits: Module
        (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:5 - line:22:5] "configure(binder:)" interface type='(CoreAppModule.Type) -> (Binder<Singleton>) -> ()' access=internal type
          (parameter "self" interface type='CoreAppModule.Type')
          (parameter_list
            (parameter "binder" apiName=binder interface type='Binder<Singleton>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:26 - line:18:52])
          (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:9 - line:21:32] nothrow arg_labels=factory:
            (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping ((String, Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:9 - line:21:14] nothrow
              (declref_expr type='(BaseBindingBuilder<A, Binder<Singleton>>) -> (StaticString, Int, StaticString, @escaping ((String, Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:14 - line:21:14] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1, P_2 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Singleton>>) (substitution P_1 -> String) (substitution P_2 -> Int))] function_ref=single)
              (call_expr type='BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:9 - line:20:25] nothrow arg_labels=_:
                (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:9 - line:20:14] nothrow
                  (declref_expr type='(Binder<Singleton>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:14 - line:20:14] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Singleton>) (substitution Element -> A))] function_ref=single)
                  (declref_expr type='Binder<Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:19:9 - line:19:9] decl=Test.(file).CoreAppModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:18:27 function_ref=unapplied))
                (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:18 - line:20:25]
                  (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:19 - line:20:21]
                    (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:20:19 - line:20:19] typerepr='A')))))
            (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: ((String, Int)) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 - line:21:32] tuple_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1, P_2 where Self : BindToable> (substitution Self -> BaseBindingBuilder<A, Binder<Singleton>>) (substitution P_1 -> String) (substitution P_2 -> Int))]
              (tuple_expr type='(factory: ((String, Int)) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:16 - line:21:32] names=factory
                (function_conversion_expr implicit type='((String, Int)) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:26 - line:21:28]
                  (constructor_ref_call_expr type='(String, Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:26 - line:21:28] nothrow
                    (declref_expr type='(A.Type) -> (String, Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:28 - line:21:28] decl=Test.(file).A.init(string:number:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=unapplied)
                    (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:21:26 - line:21:26] typerepr='A')))))))
        (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:17:8 - line:17:8] "init()" interface type='(CoreAppModule.Type) -> () -> CoreAppModule' access=internal designated
          (parameter "self" interface type='CoreAppModule' inout)
          (parameter_list)
          (brace_stmt implicit
            (return_stmt implicit)))
        (typealias implicit "Scope" interface type='CoreAppModule.Scope.Type' access=internal type='Singleton')))
"""
    
    /**
     ````
     struct A {
         let string: String
         let number: Int
     }

     struct MyTag: Tag {
         typealias Element = A
         
     }

     struct CoreAppModule : Cleanse.Module {
         static func configure(binder: Binder<Singleton>) {
             binder
                 .bind(A.self)
                 .tagged(with: MyTag.self)
                 .sharedInScope()
                 .to(factory: A.init)
         }
     }
     ````
     */
    static let moduleWithScopedAndTaggedProvider = """
      (struct_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:1 - line:30:1] "CoreAppModule" interface type='CoreAppModule.Type' access=internal non-resilient inherits: Module
        (func_decl range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:5 - line:29:5] "configure(binder:)" interface type='(CoreAppModule.Type) -> (Binder<Singleton>) -> ()' access=internal type
          (parameter "self" interface type='CoreAppModule.Type')
          (parameter_list
            (parameter "binder" apiName=binder interface type='Binder<Singleton>') range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:26 - line:23:52])
          (call_expr type='BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:28:32] nothrow arg_labels=factory:
            (dot_syntax_call_expr type='(StaticString, Int, StaticString, @escaping ((String, Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:28:14] nothrow
              (declref_expr type='(ScopedBindingDecorator<TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>, Singleton>) -> (StaticString, Int, StaticString, @escaping ((String, Int)) -> A) -> BindingReceipt<A>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:14 - line:28:14] decl=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1, P_2 where Self : BindToable> (substitution Self -> ScopedBindingDecorator<TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>, Singleton>) (substitution P_1 -> String) (substitution P_2 -> Int))] function_ref=single)
              (call_expr type='ScopedBindingDecorator<TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>, Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:27:28] nothrow arg_labels=
                (dot_syntax_call_expr type='() -> ScopedBindingDecorator<TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>, Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:27:14] nothrow
                  (declref_expr type='(TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>) -> () -> ScopedBindingDecorator<TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>, Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:14 - line:27:14] decl=Cleanse.(file).BindingBuilder extension.sharedInScope() [with (substitution_map generic_signature=<Self where Self : BindingBuilder, Self.Binder : BinderType, Self.MaybeScope == Unscoped, Self.Binder.Scope : Scope> (substitution Self -> TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>))] function_ref=single)
                  (call_expr type='TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:26:37] nothrow arg_labels=with:
                    (dot_syntax_call_expr type='(MyTag.Type) -> TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:26:14] nothrow
                      (declref_expr type='(BaseBindingBuilder<A, Binder<Singleton>>) -> (MyTag.Type) -> TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:14 - line:26:14] decl=Cleanse.(file).BindingBuilder extension.tagged(with:) [with (substitution_map generic_signature=<Self, Tag where Self : BindingBuilder, Tag : Tag, Self.FinalProvider : _StandardProvider, Self.MaybeScope == Unscoped, Tag.Element == Self.FinalProvider.Element> (substitution Self -> BaseBindingBuilder<A, Binder<Singleton>>) (substitution Tag -> MyTag))] function_ref=single)
                      (call_expr type='BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:25:25] nothrow arg_labels=_:
                        (dot_syntax_call_expr type='(A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:25:14] nothrow
                          (declref_expr type='(Binder<Singleton>) -> (A.Type) -> BaseBindingBuilder<A, Binder<Singleton>>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:14 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:14 - line:25:14] decl=Cleanse.(file).BinderBase extension.bind [with (substitution_map generic_signature=<Self, Element where Self : BinderBase> (substitution Self -> Binder<Singleton>) (substitution Element -> A))] function_ref=single)
                          (declref_expr type='Binder<Singleton>' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:24:9 - line:24:9] decl=Test.(file).CoreAppModule.configure(binder:).binder@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:23:27 function_ref=unapplied))
                        (paren_expr type='(A.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:18 - line:25:25]
                          (dot_self_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:19 - line:25:21]
                            (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:19 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:25:19 - line:25:19] typerepr='A')))))
                    (tuple_expr type='(with: MyTag.Type)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:20 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:20 - line:26:37] names=with
                      (dot_self_expr type='MyTag.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:27 - line:26:33]
                        (type_expr type='MyTag.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:26:27 - line:26:27] typerepr='MyTag')))))
                (tuple_expr type='()' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:27 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:27:27 - line:27:28])))
            (argument_shuffle_expr implicit type='(file: StaticString, line: Int, function: StaticString, factory: ((String, Int)) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:16 - line:28:32] tuple_to_tuple elements=[-3, -3, -3, 0] variadic_sources=[] default_args_owner=Cleanse.(file).BindToable extension.to(file:line:function:factory:) [with (substitution_map generic_signature=<Self, P_1, P_2 where Self : BindToable> (substitution Self -> ScopedBindingDecorator<TaggedBindingBuilderDecorator<BaseBindingBuilder<A, Binder<Singleton>>, MyTag>, Singleton>) (substitution P_1 -> String) (substitution P_2 -> Int))]
              (tuple_expr type='(factory: ((String, Int)) -> A)' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:16 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:16 - line:28:32] names=factory
                (function_conversion_expr implicit type='((String, Int)) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:26 - line:28:28]
                  (constructor_ref_call_expr type='(String, Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:26 - line:28:28] nothrow
                    (declref_expr type='(A.Type) -> (String, Int) -> A' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:28 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:28 - line:28:28] decl=Test.(file).A.init(string:number:)@/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:12:8 function_ref=unapplied)
                    (type_expr type='A.Type' location=/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:26 range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:28:26 - line:28:26] typerepr='A')))))))
        (constructor_decl implicit range=[/Users/sebastians/Desktop/SmallCleanse/Test/Sample.swift:22:8 - line:22:8] "init()" interface type='(CoreAppModule.Type) -> () -> CoreAppModule' access=internal designated
          (parameter "self" interface type='CoreAppModule' inout)
          (parameter_list)
          (brace_stmt implicit
            (return_stmt implicit)))
        (typealias implicit "Scope" interface type='CoreAppModule.Scope.Type' access=internal type='Singleton')))
"""
}
