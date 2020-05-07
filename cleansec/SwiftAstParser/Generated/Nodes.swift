// This file is generated! DO NOT EDIT!

public enum NodeIdentifier: String {

    case source_file = "source_file"

    case import_decl = "import_decl"

    case var_decl = "var_decl"

    case enum_case_decl = "enum_case_decl"

    case enum_decl = "enum_decl"

    case enum_element_decl = "enum_element_decl"

    case struct_decl = "struct_decl"

    case class_decl = "class_decl"

    case pattern_binding_decl = "pattern_binding_decl"

    case subscript_decl = "subscript_decl"

    case func_decl = "func_decl"

    case accessor_decl = "accessor_decl"

    case constructor_decl = "constructor_decl"

    case destructor_decl = "destructor_decl"

    case top_level_code_decl = "top_level_code_decl"

    case if_config_decl = "if_config_decl"

    case pound_diagnostic_decl = "pound_diagnostic_decl"

    case precedence_group_decl = "precedence_group_decl"

    case infix_operator_decl = "infix_operator_decl"

    case prefix_operator_decl = "prefix_operator_decl"

    case postfix_operator_decl = "postfix_operator_decl"

    case missing_member_decl = "missing_member_decl"

    case declref_expr = "declref_expr"

    case overloaded_decl_ref_expr = "overloaded_decl_ref_expr"

    case unresolved_decl_ref_expr = "unresolved_decl_ref_expr"

    case pattern_expr = "pattern_expr"

    case semantic_expr = "semantic_expr"

    case error_expr = "error_expr"

    case code_completion_expr = "code_completion_expr"

    case nil_literal_expr = "nil_literal_expr"

    case integer_literal_expr = "integer_literal_expr"

    case float_literal_expr = "float_literal_expr"

    case boolean_literal_expr = "boolean_literal_expr"

    case string_literal_expr = "string_literal_expr"

    case interpolated_string_literal_expr = "interpolated_string_literal_expr"

    case magic_identifier_literal_expr = "magic_identifier_literal_expr"

    case discard_assignment_expr = "discard_assignment_expr"

    case super_ref_expr = "super_ref_expr"

    case type_expr = "type_expr"

    case other_constructor_ref_expr = "other_constructor_ref_expr"

    case unresolved_specialize_expr = "unresolved_specialize_expr"

    case member_ref_expr = "member_ref_expr"

    case dynamic_member_ref_expr = "dynamic_member_ref_expr"

    case unresolved_member_expr = "unresolved_member_expr"

    case dot_self_expr = "dot_self_expr"

    case paren_expr = "paren_expr"

    case tuple_expr = "tuple_expr"

    case array_expr = "array_expr"

    case dictionary_expr = "dictionary_expr"

    case subscript_expr = "subscript_expr"

    case keypath_application_expr = "keypath_application_expr"

    case dynamic_subscript_expr = "dynamic_subscript_expr"

    case unresolved_dot_expr = "unresolved_dot_expr"

    case tuple_element_expr = "tuple_element_expr"

    case destructure_tuple_expr = "destructure_tuple_expr"

    case unresolvedtype_conversion_expr = "unresolvedtype_conversion_expr"

    case function_conversion_expr = "function_conversion_expr"

    case covariant_function_conversion_expr = "covariant_function_conversion_expr"

    case covariant_return_conversion_expr = "covariant_return_conversion_expr"

    case implicitly_unwrapped_function_conversion_expr = "implicitly_unwrapped_function_conversion_expr"

    case underlying_to_opaque_expr = "underlying_to_opaque_expr"

    case erasure_expr = "erasure_expr"

    case any_hashable_erasure_expr = "any_hashable_erasure_expr"

    case conditional_bridge_from_objc_expr = "conditional_bridge_from_objc_expr"

    case bridge_from_objc_expr = "bridge_from_objc_expr"

    case bridge_to_objc_expr = "bridge_to_objc_expr"

    case load_expr = "load_expr"

    case metatype_conversion_expr = "metatype_conversion_expr"

    case collection_upcast_expr = "collection_upcast_expr"

    case derived_to_base_expr = "derived_to_base_expr"

    case archetype_to_super_expr = "archetype_to_super_expr"

    case inout_expr = "inout_expr"

    case vararg_expansion_expr = "vararg_expansion_expr"

    case force_try_expr = "force_try_expr"

    case optional_try_expr = "optional_try_expr"

    case try_expr = "try_expr"

    case sequence_expr = "sequence_expr"

    case closure_expr = "closure_expr"

    case autoclosure_expr = "autoclosure_expr"

    case metatype_expr = "metatype_expr"

    case opaque_value_expr = "opaque_value_expr"

    case property_wrapper_value_placeholder_expr = "property_wrapper_value_placeholder_expr"

    case default_argument_expr = "default_argument_expr"

    case call_expr = "call_expr"

    case prefix_unary_expr = "prefix_unary_expr"

    case postfix_unary_expr = "postfix_unary_expr"

    case binary_expr = "binary_expr"

    case dot_syntax_call_expr = "dot_syntax_call_expr"

    case constructor_ref_call_expr = "constructor_ref_call_expr"

    case forced_checked_cast_expr = "forced_checked_cast_expr"

    case conditional_checked_cast_expr = "conditional_checked_cast_expr"

    case is_subtype_expr = "is_subtype_expr"

    case coerce_expr = "coerce_expr"

    case rebind_self_in_constructor_expr = "rebind_self_in_constructor_expr"

    case if_expr = "if_expr"

    case assign_expr = "assign_expr"

    case enum_is_case_expr = "enum_is_case_expr"

    case unresolved_pattern_expr = "unresolved_pattern_expr"

    case bind_optional_expr = "bind_optional_expr"

    case optional_evaluation_expr = "optional_evaluation_expr"

    case force_value_expr = "force_value_expr"

    case open_existential_expr = "open_existential_expr"

    case make_temporarily_escapable_expr = "make_temporarily_escapable_expr"

    case editor_placeholder_expr = "editor_placeholder_expr"

    case lazy_initializer_expr = "lazy_initializer_expr"

    case objc_selector_expr = "objc_selector_expr"

    case keypath_expr = "keypath_expr"

    case key_path_dot_expr = "key_path_dot_expr"

    case one_way_expr = "one_way_expr"

    case tap_expr = "tap_expr"

    case pattern_paren = "pattern_paren"

    case pattern_named = "pattern_named"

    case pattern_any = "pattern_any"

    case pattern_typed = "pattern_typed"

    case pattern_is = "pattern_is"

    case pattern_let = "pattern_let"

    case pattern_var = "pattern_var"

    case pattern_enum_element = "pattern_enum_element"

    case pattern_optional_some = "pattern_optional_some"

    case pattern_bool = "pattern_bool"

    case extension_decl = "extension_decl"

    case `typealias` = "typealias"

    case generic_type_param = "generic_type_param"

    case associated_type_decl = "associated_type_decl"

    case `protocol` = "`protocol`"

    case param_decl = "param_decl"

    case module = "module"

    case brace_stmt = "brace_stmt"

    case return_stmt = "return_stmt"

    case yield_stmt = "yield_stmt"

    case defer_stmt = "defer_stmt"

    case if_stmt = "if_stmt"

    case guard_stmt = "guard_stmt"

    case do_stmt = "do_stmt"

    case while_stmt = "while_stmt"

    case repeat_while_stmt = "repeat_while_stmt"

    case for_each_stmt = "for_each_stmt"

    case break_stmt = "break_stmt"

    case continue_stmt = "continue_stmt"

    case fallthrough_stmt = "fallthrough_stmt"

    case switch_stmt = "switch_stmt"

    case case_stmt = "case_stmt"

    case fail_stmt = "fail_stmt"

    case throw_stmt = "throw_stmt"

    case pound_assert = "pound_assert"

    case do_catch_stmt = "do_catch_stmt"

    case object_literal = "object_literal"

    case type_error = "type_error"

    case type_attributed = "type_attributed"

    case type_ident = "type_ident"

    case type_function = "type_function"

    case type_array = "type_array"

    case type_dictionary = "type_dictionary"

    case type_tuple = "type_tuple"

    case type_composite = "type_composite"

    case type_metatype = "type_metatype"

    case type_protocol = "type_protocol"

    case type_inout = "type_inout"

    case type_shared = "type_shared"

    case type_owned = "type_owned"

    case type_optional = "type_optional"

    case type_implicitly_unwrapped_optional = "type_implicitly_unwrapped_optional"

    case type_opaque_return = "type_opaque_return"

    case type_fixed = "type_fixed"

    case sil_box = "sil_box"

    case error_type = "error_type"

    case builtin_integer_type = "builtin_integer_type"

    case builtin_float_type = "builtin_float_type"

    case builtin_vector_type = "builtin_vector_type"

    case type_alias_type = "type_alias_type"

    case paren_type = "paren_type"

    case tuple_type = "tuple_type"

    case enum_type = "enum_type"

    case struct_type = "struct_type"

    case class_type = "class_type"

    case protocol_type = "protocol_type"

    case metatype_type = "metatype_type"

    case existential_metatype_type = "existential_metatype_type"

    case module_type = "module_type"

    case dynamic_self_type = "dynamic_self_type"

    case primary_archetype_type = "primary_archetype_type"

    case nested_archetype_type = "nested_archetype_type"

    case opened_archetype_type = "opened_archetype_type"

    case opaque_type = "opaque_type"

    case generic_type_param_type = "generic_type_param_type"

    case dependent_member_type = "dependent_member_type"

    case function_type = "function_type"

    case generic_function_type = "generic_function_type"

    case sil_function_type = "sil_function_type"

    case sil_block_storage_type = "sil_block_storage_type"

    case sil_box_type = "sil_box_type"

    case array_slice_type = "array_slice_type"

    case optional_type = "optional_type"

    case dictionary_type = "dictionary_type"

    case protocol_composition_type = "protocol_composition_type"

    case lvalue_type = "lvalue_type"

    case inout_type = "inout_type"

    case unbound_generic_type = "unbound_generic_type"

    case bound_generic_class_type = "bound_generic_class_type"

    case bound_generic_struct_type = "bound_generic_struct_type"

    case bound_generic_enum_type = "bound_generic_enum_type"

    case type_variable_type = "type_variable_type"

    case pattern_tuple = "pattern_tuple"

    case parameter_list = "parameter_list"

    case parameter = "parameter"

    case argument_shuffle_expr = "argument_shuffle_expr"

}


public struct SourceFileDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ImportDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct VarDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct EnumCaseDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct EnumDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct EnumElementDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct StructDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ClassDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternBindingDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SubscriptDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct FuncDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct AccessorDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ConstructorDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DestructorDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TopLevelCodeDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct IfConfigDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PoundDiagnosticDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PrecedenceGroupDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct InfixOperatorDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PrefixOperatorDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PostfixOperatorDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct MissingMemberDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DeclrefExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OverloadedDeclRefExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnresolvedDeclRefExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SemanticExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ErrorExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct CodeCompletionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct NilLiteralExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct IntegerLiteralExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct FloatLiteralExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BooleanLiteralExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct StringLiteralExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct InterpolatedStringLiteralExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct MagicIdentifierLiteralExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DiscardAssignmentExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SuperRefExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OtherConstructorRefExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnresolvedSpecializeExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct MemberRefExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DynamicMemberRefExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnresolvedMemberExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DotSelfExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ParenExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TupleExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ArrayExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DictionaryExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SubscriptExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct KeypathApplicationExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DynamicSubscriptExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnresolvedDotExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TupleElementExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DestructureTupleExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnresolvedtypeConversionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct FunctionConversionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct CovariantFunctionConversionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct CovariantReturnConversionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ImplicitlyUnwrappedFunctionConversionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnderlyingToOpaqueExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ErasureExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct AnyHashableErasureExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ConditionalBridgeFromObjcExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BridgeFromObjcExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BridgeToObjcExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct LoadExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct MetatypeConversionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct CollectionUpcastExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DerivedToBaseExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ArchetypeToSuperExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct InoutExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct VarargExpansionExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ForceTryExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OptionalTryExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TryExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SequenceExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ClosureExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct AutoclosureExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct MetatypeExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OpaqueValueExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PropertyWrapperValuePlaceholderExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DefaultArgumentExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct CallExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PrefixUnaryExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PostfixUnaryExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BinaryExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DotSyntaxCallExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ConstructorRefCallExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ForcedCheckedCastExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ConditionalCheckedCastExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct IsSubtypeExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct CoerceExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct RebindSelfInConstructorExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct IfExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct AssignExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct EnumIsCaseExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnresolvedPatternExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BindOptionalExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OptionalEvaluationExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ForceValueExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OpenExistentialExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct MakeTemporarilyEscapableExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct EditorPlaceholderExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct LazyInitializerExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ObjcSelectorExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct KeypathExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct KeyPathDotExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OneWayExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TapExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternParen: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternNamed: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternAny: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternTyped: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternIs: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternLet: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternVar: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternEnumElement: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternOptionalSome: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternBool: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ExtensionDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct Typealias: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct GenericTypeParam: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct AssociatedTypeDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ProtocolInst: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ParamDecl: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct module: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BraceStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ReturnStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct YieldStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DeferStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct IfStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct GuardStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DoStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct WhileStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct RepeatWhileStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ForEachStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BreakStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ContinueStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct FallthroughStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SwitchStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct CaseStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct FailStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ThrowStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PoundAssert: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DoCatchStmt: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ObjectLiteral: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeError: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeAttributed: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeIdent: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeFunction: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeArray: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeDictionary: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeTuple: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeComposite: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeMetatype: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeProtocol: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeInout: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeShared: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeOwned: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeOptional: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeImplicitlyUnwrappedOptional: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeOpaqueReturn: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeFixed: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SilBox: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ErrorType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BuiltinIntegerType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BuiltinFloatType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BuiltinVectorType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeAliasType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ParenType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TupleType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct EnumType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct StructType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ClassType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ProtocolType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct MetatypeType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ExistentialMetatypeType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ModuleType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DynamicSelfType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PrimaryArchetypeType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct NestedArchetypeType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OpenedArchetypeType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OpaqueType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct GenericTypeParamType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DependentMemberType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct FunctionType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct GenericFunctionType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SilFunctionType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SilBlockStorageType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct SilBoxType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ArraySliceType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct OptionalType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct DictionaryType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ProtocolCompositionType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct LvalueType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct InoutType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct UnboundGenericType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BoundGenericClassType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BoundGenericStructType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct BoundGenericEnumType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct TypeVariableType: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct PatternTuple: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ParameterList: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct Parameter: Syntax {
    public let raw: String
    public let children: [Syntax]
}

public struct ArgumentShuffleExpr: Syntax {
    public let raw: String
    public let children: [Syntax]
}


public struct UnknownSyntax: Syntax {
    public let raw: String
    public let children: [Syntax]
}

extension String {
    func createNode(id: NodeIdentifier, children: [Syntax]) -> Syntax {
        switch id {
        
            case .source_file: 
                return SourceFileDecl(raw: self, children: children)
		
            case .import_decl: 
                return ImportDecl(raw: self, children: children)
		
            case .var_decl: 
                return VarDecl(raw: self, children: children)
		
            case .enum_case_decl: 
                return EnumCaseDecl(raw: self, children: children)
		
            case .enum_decl: 
                return EnumDecl(raw: self, children: children)
		
            case .enum_element_decl: 
                return EnumElementDecl(raw: self, children: children)
		
            case .struct_decl: 
                return StructDecl(raw: self, children: children)
		
            case .class_decl: 
                return ClassDecl(raw: self, children: children)
		
            case .pattern_binding_decl: 
                return PatternBindingDecl(raw: self, children: children)
		
            case .subscript_decl: 
                return SubscriptDecl(raw: self, children: children)
		
            case .func_decl: 
                return FuncDecl(raw: self, children: children)
		
            case .accessor_decl: 
                return AccessorDecl(raw: self, children: children)
		
            case .constructor_decl: 
                return ConstructorDecl(raw: self, children: children)
		
            case .destructor_decl: 
                return DestructorDecl(raw: self, children: children)
		
            case .top_level_code_decl: 
                return TopLevelCodeDecl(raw: self, children: children)
		
            case .if_config_decl: 
                return IfConfigDecl(raw: self, children: children)
		
            case .pound_diagnostic_decl: 
                return PoundDiagnosticDecl(raw: self, children: children)
		
            case .precedence_group_decl: 
                return PrecedenceGroupDecl(raw: self, children: children)
		
            case .infix_operator_decl: 
                return InfixOperatorDecl(raw: self, children: children)
		
            case .prefix_operator_decl: 
                return PrefixOperatorDecl(raw: self, children: children)
		
            case .postfix_operator_decl: 
                return PostfixOperatorDecl(raw: self, children: children)
		
            case .missing_member_decl: 
                return MissingMemberDecl(raw: self, children: children)
		
            case .declref_expr: 
                return DeclrefExpr(raw: self, children: children)
		
            case .overloaded_decl_ref_expr: 
                return OverloadedDeclRefExpr(raw: self, children: children)
		
            case .unresolved_decl_ref_expr: 
                return UnresolvedDeclRefExpr(raw: self, children: children)
		
            case .pattern_expr: 
                return PatternExpr(raw: self, children: children)
		
            case .semantic_expr: 
                return SemanticExpr(raw: self, children: children)
		
            case .error_expr: 
                return ErrorExpr(raw: self, children: children)
		
            case .code_completion_expr: 
                return CodeCompletionExpr(raw: self, children: children)
		
            case .nil_literal_expr: 
                return NilLiteralExpr(raw: self, children: children)
		
            case .integer_literal_expr: 
                return IntegerLiteralExpr(raw: self, children: children)
		
            case .float_literal_expr: 
                return FloatLiteralExpr(raw: self, children: children)
		
            case .boolean_literal_expr: 
                return BooleanLiteralExpr(raw: self, children: children)
		
            case .string_literal_expr: 
                return StringLiteralExpr(raw: self, children: children)
		
            case .interpolated_string_literal_expr: 
                return InterpolatedStringLiteralExpr(raw: self, children: children)
		
            case .magic_identifier_literal_expr: 
                return MagicIdentifierLiteralExpr(raw: self, children: children)
		
            case .discard_assignment_expr: 
                return DiscardAssignmentExpr(raw: self, children: children)
		
            case .super_ref_expr: 
                return SuperRefExpr(raw: self, children: children)
		
            case .type_expr: 
                return TypeExpr(raw: self, children: children)
		
            case .other_constructor_ref_expr: 
                return OtherConstructorRefExpr(raw: self, children: children)
		
            case .unresolved_specialize_expr: 
                return UnresolvedSpecializeExpr(raw: self, children: children)
		
            case .member_ref_expr: 
                return MemberRefExpr(raw: self, children: children)
		
            case .dynamic_member_ref_expr: 
                return DynamicMemberRefExpr(raw: self, children: children)
		
            case .unresolved_member_expr: 
                return UnresolvedMemberExpr(raw: self, children: children)
		
            case .dot_self_expr: 
                return DotSelfExpr(raw: self, children: children)
		
            case .paren_expr: 
                return ParenExpr(raw: self, children: children)
		
            case .tuple_expr: 
                return TupleExpr(raw: self, children: children)
		
            case .array_expr: 
                return ArrayExpr(raw: self, children: children)
		
            case .dictionary_expr: 
                return DictionaryExpr(raw: self, children: children)
		
            case .subscript_expr: 
                return SubscriptExpr(raw: self, children: children)
		
            case .keypath_application_expr: 
                return KeypathApplicationExpr(raw: self, children: children)
		
            case .dynamic_subscript_expr: 
                return DynamicSubscriptExpr(raw: self, children: children)
		
            case .unresolved_dot_expr: 
                return UnresolvedDotExpr(raw: self, children: children)
		
            case .tuple_element_expr: 
                return TupleElementExpr(raw: self, children: children)
		
            case .destructure_tuple_expr: 
                return DestructureTupleExpr(raw: self, children: children)
		
            case .unresolvedtype_conversion_expr: 
                return UnresolvedtypeConversionExpr(raw: self, children: children)
		
            case .function_conversion_expr: 
                return FunctionConversionExpr(raw: self, children: children)
		
            case .covariant_function_conversion_expr: 
                return CovariantFunctionConversionExpr(raw: self, children: children)
		
            case .covariant_return_conversion_expr: 
                return CovariantReturnConversionExpr(raw: self, children: children)
		
            case .implicitly_unwrapped_function_conversion_expr: 
                return ImplicitlyUnwrappedFunctionConversionExpr(raw: self, children: children)
		
            case .underlying_to_opaque_expr: 
                return UnderlyingToOpaqueExpr(raw: self, children: children)
		
            case .erasure_expr: 
                return ErasureExpr(raw: self, children: children)
		
            case .any_hashable_erasure_expr: 
                return AnyHashableErasureExpr(raw: self, children: children)
		
            case .conditional_bridge_from_objc_expr: 
                return ConditionalBridgeFromObjcExpr(raw: self, children: children)
		
            case .bridge_from_objc_expr: 
                return BridgeFromObjcExpr(raw: self, children: children)
		
            case .bridge_to_objc_expr: 
                return BridgeToObjcExpr(raw: self, children: children)
		
            case .load_expr: 
                return LoadExpr(raw: self, children: children)
		
            case .metatype_conversion_expr: 
                return MetatypeConversionExpr(raw: self, children: children)
		
            case .collection_upcast_expr: 
                return CollectionUpcastExpr(raw: self, children: children)
		
            case .derived_to_base_expr: 
                return DerivedToBaseExpr(raw: self, children: children)
		
            case .archetype_to_super_expr: 
                return ArchetypeToSuperExpr(raw: self, children: children)
		
            case .inout_expr: 
                return InoutExpr(raw: self, children: children)
		
            case .vararg_expansion_expr: 
                return VarargExpansionExpr(raw: self, children: children)
		
            case .force_try_expr: 
                return ForceTryExpr(raw: self, children: children)
		
            case .optional_try_expr: 
                return OptionalTryExpr(raw: self, children: children)
		
            case .try_expr: 
                return TryExpr(raw: self, children: children)
		
            case .sequence_expr: 
                return SequenceExpr(raw: self, children: children)
		
            case .closure_expr: 
                return ClosureExpr(raw: self, children: children)
		
            case .autoclosure_expr: 
                return AutoclosureExpr(raw: self, children: children)
		
            case .metatype_expr: 
                return MetatypeExpr(raw: self, children: children)
		
            case .opaque_value_expr: 
                return OpaqueValueExpr(raw: self, children: children)
		
            case .property_wrapper_value_placeholder_expr: 
                return PropertyWrapperValuePlaceholderExpr(raw: self, children: children)
		
            case .default_argument_expr: 
                return DefaultArgumentExpr(raw: self, children: children)
		
            case .call_expr: 
                return CallExpr(raw: self, children: children)
		
            case .prefix_unary_expr: 
                return PrefixUnaryExpr(raw: self, children: children)
		
            case .postfix_unary_expr: 
                return PostfixUnaryExpr(raw: self, children: children)
		
            case .binary_expr: 
                return BinaryExpr(raw: self, children: children)
		
            case .dot_syntax_call_expr: 
                return DotSyntaxCallExpr(raw: self, children: children)
		
            case .constructor_ref_call_expr: 
                return ConstructorRefCallExpr(raw: self, children: children)
		
            case .forced_checked_cast_expr: 
                return ForcedCheckedCastExpr(raw: self, children: children)
		
            case .conditional_checked_cast_expr: 
                return ConditionalCheckedCastExpr(raw: self, children: children)
		
            case .is_subtype_expr: 
                return IsSubtypeExpr(raw: self, children: children)
		
            case .coerce_expr: 
                return CoerceExpr(raw: self, children: children)
		
            case .rebind_self_in_constructor_expr: 
                return RebindSelfInConstructorExpr(raw: self, children: children)
		
            case .if_expr: 
                return IfExpr(raw: self, children: children)
		
            case .assign_expr: 
                return AssignExpr(raw: self, children: children)
		
            case .enum_is_case_expr: 
                return EnumIsCaseExpr(raw: self, children: children)
		
            case .unresolved_pattern_expr: 
                return UnresolvedPatternExpr(raw: self, children: children)
		
            case .bind_optional_expr: 
                return BindOptionalExpr(raw: self, children: children)
		
            case .optional_evaluation_expr: 
                return OptionalEvaluationExpr(raw: self, children: children)
		
            case .force_value_expr: 
                return ForceValueExpr(raw: self, children: children)
		
            case .open_existential_expr: 
                return OpenExistentialExpr(raw: self, children: children)
		
            case .make_temporarily_escapable_expr: 
                return MakeTemporarilyEscapableExpr(raw: self, children: children)
		
            case .editor_placeholder_expr: 
                return EditorPlaceholderExpr(raw: self, children: children)
		
            case .lazy_initializer_expr: 
                return LazyInitializerExpr(raw: self, children: children)
		
            case .objc_selector_expr: 
                return ObjcSelectorExpr(raw: self, children: children)
		
            case .keypath_expr: 
                return KeypathExpr(raw: self, children: children)
		
            case .key_path_dot_expr: 
                return KeyPathDotExpr(raw: self, children: children)
		
            case .one_way_expr: 
                return OneWayExpr(raw: self, children: children)
		
            case .tap_expr: 
                return TapExpr(raw: self, children: children)
		
            case .pattern_paren: 
                return PatternParen(raw: self, children: children)
		
            case .pattern_named: 
                return PatternNamed(raw: self, children: children)
		
            case .pattern_any: 
                return PatternAny(raw: self, children: children)
		
            case .pattern_typed: 
                return PatternTyped(raw: self, children: children)
		
            case .pattern_is: 
                return PatternIs(raw: self, children: children)
		
            case .pattern_let: 
                return PatternLet(raw: self, children: children)
		
            case .pattern_var: 
                return PatternVar(raw: self, children: children)
		
            case .pattern_enum_element: 
                return PatternEnumElement(raw: self, children: children)
		
            case .pattern_optional_some: 
                return PatternOptionalSome(raw: self, children: children)
		
            case .pattern_bool: 
                return PatternBool(raw: self, children: children)
		
            case .extension_decl: 
                return ExtensionDecl(raw: self, children: children)
		
            case .`typealias`: 
                return Typealias(raw: self, children: children)
		
            case .generic_type_param: 
                return GenericTypeParam(raw: self, children: children)
		
            case .associated_type_decl: 
                return AssociatedTypeDecl(raw: self, children: children)
		
            case .`protocol`: 
                return ProtocolInst(raw: self, children: children)
		
            case .param_decl: 
                return ParamDecl(raw: self, children: children)
		
            case .module: 
                return module(raw: self, children: children)
		
            case .brace_stmt: 
                return BraceStmt(raw: self, children: children)
		
            case .return_stmt: 
                return ReturnStmt(raw: self, children: children)
		
            case .yield_stmt: 
                return YieldStmt(raw: self, children: children)
		
            case .defer_stmt: 
                return DeferStmt(raw: self, children: children)
		
            case .if_stmt: 
                return IfStmt(raw: self, children: children)
		
            case .guard_stmt: 
                return GuardStmt(raw: self, children: children)
		
            case .do_stmt: 
                return DoStmt(raw: self, children: children)
		
            case .while_stmt: 
                return WhileStmt(raw: self, children: children)
		
            case .repeat_while_stmt: 
                return RepeatWhileStmt(raw: self, children: children)
		
            case .for_each_stmt: 
                return ForEachStmt(raw: self, children: children)
		
            case .break_stmt: 
                return BreakStmt(raw: self, children: children)
		
            case .continue_stmt: 
                return ContinueStmt(raw: self, children: children)
		
            case .fallthrough_stmt: 
                return FallthroughStmt(raw: self, children: children)
		
            case .switch_stmt: 
                return SwitchStmt(raw: self, children: children)
		
            case .case_stmt: 
                return CaseStmt(raw: self, children: children)
		
            case .fail_stmt: 
                return FailStmt(raw: self, children: children)
		
            case .throw_stmt: 
                return ThrowStmt(raw: self, children: children)
		
            case .pound_assert: 
                return PoundAssert(raw: self, children: children)
		
            case .do_catch_stmt: 
                return DoCatchStmt(raw: self, children: children)
		
            case .object_literal: 
                return ObjectLiteral(raw: self, children: children)
		
            case .type_error: 
                return TypeError(raw: self, children: children)
		
            case .type_attributed: 
                return TypeAttributed(raw: self, children: children)
		
            case .type_ident: 
                return TypeIdent(raw: self, children: children)
		
            case .type_function: 
                return TypeFunction(raw: self, children: children)
		
            case .type_array: 
                return TypeArray(raw: self, children: children)
		
            case .type_dictionary: 
                return TypeDictionary(raw: self, children: children)
		
            case .type_tuple: 
                return TypeTuple(raw: self, children: children)
		
            case .type_composite: 
                return TypeComposite(raw: self, children: children)
		
            case .type_metatype: 
                return TypeMetatype(raw: self, children: children)
		
            case .type_protocol: 
                return TypeProtocol(raw: self, children: children)
		
            case .type_inout: 
                return TypeInout(raw: self, children: children)
		
            case .type_shared: 
                return TypeShared(raw: self, children: children)
		
            case .type_owned: 
                return TypeOwned(raw: self, children: children)
		
            case .type_optional: 
                return TypeOptional(raw: self, children: children)
		
            case .type_implicitly_unwrapped_optional: 
                return TypeImplicitlyUnwrappedOptional(raw: self, children: children)
		
            case .type_opaque_return: 
                return TypeOpaqueReturn(raw: self, children: children)
		
            case .type_fixed: 
                return TypeFixed(raw: self, children: children)
		
            case .sil_box: 
                return SilBox(raw: self, children: children)
		
            case .error_type: 
                return ErrorType(raw: self, children: children)
		
            case .builtin_integer_type: 
                return BuiltinIntegerType(raw: self, children: children)
		
            case .builtin_float_type: 
                return BuiltinFloatType(raw: self, children: children)
		
            case .builtin_vector_type: 
                return BuiltinVectorType(raw: self, children: children)
		
            case .type_alias_type: 
                return TypeAliasType(raw: self, children: children)
		
            case .paren_type: 
                return ParenType(raw: self, children: children)
		
            case .tuple_type: 
                return TupleType(raw: self, children: children)
		
            case .enum_type: 
                return EnumType(raw: self, children: children)
		
            case .struct_type: 
                return StructType(raw: self, children: children)
		
            case .class_type: 
                return ClassType(raw: self, children: children)
		
            case .protocol_type: 
                return ProtocolType(raw: self, children: children)
		
            case .metatype_type: 
                return MetatypeType(raw: self, children: children)
		
            case .existential_metatype_type: 
                return ExistentialMetatypeType(raw: self, children: children)
		
            case .module_type: 
                return ModuleType(raw: self, children: children)
		
            case .dynamic_self_type: 
                return DynamicSelfType(raw: self, children: children)
		
            case .primary_archetype_type: 
                return PrimaryArchetypeType(raw: self, children: children)
		
            case .nested_archetype_type: 
                return NestedArchetypeType(raw: self, children: children)
		
            case .opened_archetype_type: 
                return OpenedArchetypeType(raw: self, children: children)
		
            case .opaque_type: 
                return OpaqueType(raw: self, children: children)
		
            case .generic_type_param_type: 
                return GenericTypeParamType(raw: self, children: children)
		
            case .dependent_member_type: 
                return DependentMemberType(raw: self, children: children)
		
            case .function_type: 
                return FunctionType(raw: self, children: children)
		
            case .generic_function_type: 
                return GenericFunctionType(raw: self, children: children)
		
            case .sil_function_type: 
                return SilFunctionType(raw: self, children: children)
		
            case .sil_block_storage_type: 
                return SilBlockStorageType(raw: self, children: children)
		
            case .sil_box_type: 
                return SilBoxType(raw: self, children: children)
		
            case .array_slice_type: 
                return ArraySliceType(raw: self, children: children)
		
            case .optional_type: 
                return OptionalType(raw: self, children: children)
		
            case .dictionary_type: 
                return DictionaryType(raw: self, children: children)
		
            case .protocol_composition_type: 
                return ProtocolCompositionType(raw: self, children: children)
		
            case .lvalue_type: 
                return LvalueType(raw: self, children: children)
		
            case .inout_type: 
                return InoutType(raw: self, children: children)
		
            case .unbound_generic_type: 
                return UnboundGenericType(raw: self, children: children)
		
            case .bound_generic_class_type: 
                return BoundGenericClassType(raw: self, children: children)
		
            case .bound_generic_struct_type: 
                return BoundGenericStructType(raw: self, children: children)
		
            case .bound_generic_enum_type: 
                return BoundGenericEnumType(raw: self, children: children)
		
            case .type_variable_type: 
                return TypeVariableType(raw: self, children: children)
		
            case .pattern_tuple: 
                return PatternTuple(raw: self, children: children)
		
            case .parameter_list: 
                return ParameterList(raw: self, children: children)
		
            case .parameter: 
                return Parameter(raw: self, children: children)
		
            case .argument_shuffle_expr: 
                return ArgumentShuffleExpr(raw: self, children: children)
		
        }
    }
}
