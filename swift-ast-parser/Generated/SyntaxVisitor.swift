// This file is generated! DO NOT EDIT!!

public extension SyntaxVisitor {
    mutating func walk(_ node: Syntax) {
        var shouldVisitChildren = false
        if false {
          // Noop
        
        } else if let node = node as? SourceFileDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ImportDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? VarDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? EnumCaseDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? EnumDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? EnumElementDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? StructDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ClassDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternBindingDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SubscriptDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? FuncDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? AccessorDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ConstructorDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DestructorDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TopLevelCodeDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? IfConfigDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PoundDiagnosticDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PrecedenceGroupDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? InfixOperatorDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PrefixOperatorDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PostfixOperatorDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? MissingMemberDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DeclrefExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OverloadedDeclRefExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnresolvedDeclRefExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SemanticExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ErrorExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? CodeCompletionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? NilLiteralExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? IntegerLiteralExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? FloatLiteralExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BooleanLiteralExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? StringLiteralExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? InterpolatedStringLiteralExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? MagicIdentifierLiteralExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DiscardAssignmentExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SuperRefExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OtherConstructorRefExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnresolvedSpecializeExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? MemberRefExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DynamicMemberRefExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnresolvedMemberExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DotSelfExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ParenExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TupleExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ArrayExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DictionaryExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SubscriptExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? KeypathApplicationExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DynamicSubscriptExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnresolvedDotExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TupleElementExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DestructureTupleExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnresolvedtypeConversionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? FunctionConversionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? CovariantFunctionConversionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? CovariantReturnConversionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ImplicitlyUnwrappedFunctionConversionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnderlyingToOpaqueExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ErasureExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? AnyHashableErasureExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ConditionalBridgeFromObjcExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BridgeFromObjcExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BridgeToObjcExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? LoadExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? MetatypeConversionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? CollectionUpcastExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DerivedToBaseExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ArchetypeToSuperExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? InoutExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? VarargExpansionExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ForceTryExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OptionalTryExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TryExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SequenceExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ClosureExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? AutoclosureExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? MetatypeExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OpaqueValueExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PropertyWrapperValuePlaceholderExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DefaultArgumentExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? CallExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PrefixUnaryExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PostfixUnaryExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BinaryExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DotSyntaxCallExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ConstructorRefCallExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ForcedCheckedCastExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ConditionalCheckedCastExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? IsSubtypeExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? CoerceExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? RebindSelfInConstructorExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? IfExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? AssignExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? EnumIsCaseExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnresolvedPatternExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BindOptionalExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OptionalEvaluationExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ForceValueExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OpenExistentialExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? MakeTemporarilyEscapableExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? EditorPlaceholderExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? LazyInitializerExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ObjcSelectorExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? KeypathExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? KeyPathDotExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OneWayExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TapExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternParen {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternNamed {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternAny {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternTyped {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternIs {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternLet {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternVar {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternEnumElement {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternOptionalSome {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternBool {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ExtensionDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? Typealias {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? GenericTypeParam {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? AssociatedTypeDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? Protocol {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ParamDecl {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? module {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BraceStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ReturnStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? YieldStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DeferStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? IfStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? GuardStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DoStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? WhileStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? RepeatWhileStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ForEachStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BreakStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ContinueStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? FallthroughStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SwitchStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? CaseStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? FailStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ThrowStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PoundAssert {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DoCatchStmt {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ObjectLiteral {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeError {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeAttributed {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeIdent {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeFunction {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeArray {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeDictionary {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeTuple {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeComposite {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeMetatype {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeProtocol {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeInout {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeShared {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeOwned {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeOptional {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeImplicitlyUnwrappedOptional {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeOpaqueReturn {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeFixed {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SilBox {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ErrorType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BuiltinIntegerType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BuiltinFloatType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BuiltinVectorType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeAliasType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ParenType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TupleType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? EnumType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? StructType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ClassType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ProtocolType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? MetatypeType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ExistentialMetatypeType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ModuleType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DynamicSelfType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PrimaryArchetypeType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? NestedArchetypeType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OpenedArchetypeType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OpaqueType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? GenericTypeParamType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DependentMemberType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? FunctionType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? GenericFunctionType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SilFunctionType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SilBlockStorageType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? SilBoxType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ArraySliceType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? OptionalType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? DictionaryType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ProtocolCompositionType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? LvalueType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? InoutType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? UnboundGenericType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BoundGenericClassType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BoundGenericStructType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? BoundGenericEnumType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? TypeVariableType {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? PatternTuple {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ParameterList {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? Parameter {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? ArgumentShuffleExpr {
            visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        
        } else if let node = node as? NodeSyntax {
        	visit(node: node)
            shouldVisitChildren = visitChildren(node: node)
        }

        if shouldVisitChildren {
            node.children.forEach { walk($0) }
        }
    }
}

public protocol SyntaxVisitor {
	
    mutating func visit(node: SourceFileDecl)
    mutating func visitChildren(node: SourceFileDecl) -> Bool
    
    mutating func visit(node: ImportDecl)
    mutating func visitChildren(node: ImportDecl) -> Bool
    
    mutating func visit(node: VarDecl)
    mutating func visitChildren(node: VarDecl) -> Bool
    
    mutating func visit(node: EnumCaseDecl)
    mutating func visitChildren(node: EnumCaseDecl) -> Bool
    
    mutating func visit(node: EnumDecl)
    mutating func visitChildren(node: EnumDecl) -> Bool
    
    mutating func visit(node: EnumElementDecl)
    mutating func visitChildren(node: EnumElementDecl) -> Bool
    
    mutating func visit(node: StructDecl)
    mutating func visitChildren(node: StructDecl) -> Bool
    
    mutating func visit(node: ClassDecl)
    mutating func visitChildren(node: ClassDecl) -> Bool
    
    mutating func visit(node: PatternBindingDecl)
    mutating func visitChildren(node: PatternBindingDecl) -> Bool
    
    mutating func visit(node: SubscriptDecl)
    mutating func visitChildren(node: SubscriptDecl) -> Bool
    
    mutating func visit(node: FuncDecl)
    mutating func visitChildren(node: FuncDecl) -> Bool
    
    mutating func visit(node: AccessorDecl)
    mutating func visitChildren(node: AccessorDecl) -> Bool
    
    mutating func visit(node: ConstructorDecl)
    mutating func visitChildren(node: ConstructorDecl) -> Bool
    
    mutating func visit(node: DestructorDecl)
    mutating func visitChildren(node: DestructorDecl) -> Bool
    
    mutating func visit(node: TopLevelCodeDecl)
    mutating func visitChildren(node: TopLevelCodeDecl) -> Bool
    
    mutating func visit(node: IfConfigDecl)
    mutating func visitChildren(node: IfConfigDecl) -> Bool
    
    mutating func visit(node: PoundDiagnosticDecl)
    mutating func visitChildren(node: PoundDiagnosticDecl) -> Bool
    
    mutating func visit(node: PrecedenceGroupDecl)
    mutating func visitChildren(node: PrecedenceGroupDecl) -> Bool
    
    mutating func visit(node: InfixOperatorDecl)
    mutating func visitChildren(node: InfixOperatorDecl) -> Bool
    
    mutating func visit(node: PrefixOperatorDecl)
    mutating func visitChildren(node: PrefixOperatorDecl) -> Bool
    
    mutating func visit(node: PostfixOperatorDecl)
    mutating func visitChildren(node: PostfixOperatorDecl) -> Bool
    
    mutating func visit(node: MissingMemberDecl)
    mutating func visitChildren(node: MissingMemberDecl) -> Bool
    
    mutating func visit(node: DeclrefExpr)
    mutating func visitChildren(node: DeclrefExpr) -> Bool
    
    mutating func visit(node: OverloadedDeclRefExpr)
    mutating func visitChildren(node: OverloadedDeclRefExpr) -> Bool
    
    mutating func visit(node: UnresolvedDeclRefExpr)
    mutating func visitChildren(node: UnresolvedDeclRefExpr) -> Bool
    
    mutating func visit(node: PatternExpr)
    mutating func visitChildren(node: PatternExpr) -> Bool
    
    mutating func visit(node: SemanticExpr)
    mutating func visitChildren(node: SemanticExpr) -> Bool
    
    mutating func visit(node: ErrorExpr)
    mutating func visitChildren(node: ErrorExpr) -> Bool
    
    mutating func visit(node: CodeCompletionExpr)
    mutating func visitChildren(node: CodeCompletionExpr) -> Bool
    
    mutating func visit(node: NilLiteralExpr)
    mutating func visitChildren(node: NilLiteralExpr) -> Bool
    
    mutating func visit(node: IntegerLiteralExpr)
    mutating func visitChildren(node: IntegerLiteralExpr) -> Bool
    
    mutating func visit(node: FloatLiteralExpr)
    mutating func visitChildren(node: FloatLiteralExpr) -> Bool
    
    mutating func visit(node: BooleanLiteralExpr)
    mutating func visitChildren(node: BooleanLiteralExpr) -> Bool
    
    mutating func visit(node: StringLiteralExpr)
    mutating func visitChildren(node: StringLiteralExpr) -> Bool
    
    mutating func visit(node: InterpolatedStringLiteralExpr)
    mutating func visitChildren(node: InterpolatedStringLiteralExpr) -> Bool
    
    mutating func visit(node: MagicIdentifierLiteralExpr)
    mutating func visitChildren(node: MagicIdentifierLiteralExpr) -> Bool
    
    mutating func visit(node: DiscardAssignmentExpr)
    mutating func visitChildren(node: DiscardAssignmentExpr) -> Bool
    
    mutating func visit(node: SuperRefExpr)
    mutating func visitChildren(node: SuperRefExpr) -> Bool
    
    mutating func visit(node: TypeExpr)
    mutating func visitChildren(node: TypeExpr) -> Bool
    
    mutating func visit(node: OtherConstructorRefExpr)
    mutating func visitChildren(node: OtherConstructorRefExpr) -> Bool
    
    mutating func visit(node: UnresolvedSpecializeExpr)
    mutating func visitChildren(node: UnresolvedSpecializeExpr) -> Bool
    
    mutating func visit(node: MemberRefExpr)
    mutating func visitChildren(node: MemberRefExpr) -> Bool
    
    mutating func visit(node: DynamicMemberRefExpr)
    mutating func visitChildren(node: DynamicMemberRefExpr) -> Bool
    
    mutating func visit(node: UnresolvedMemberExpr)
    mutating func visitChildren(node: UnresolvedMemberExpr) -> Bool
    
    mutating func visit(node: DotSelfExpr)
    mutating func visitChildren(node: DotSelfExpr) -> Bool
    
    mutating func visit(node: ParenExpr)
    mutating func visitChildren(node: ParenExpr) -> Bool
    
    mutating func visit(node: TupleExpr)
    mutating func visitChildren(node: TupleExpr) -> Bool
    
    mutating func visit(node: ArrayExpr)
    mutating func visitChildren(node: ArrayExpr) -> Bool
    
    mutating func visit(node: DictionaryExpr)
    mutating func visitChildren(node: DictionaryExpr) -> Bool
    
    mutating func visit(node: SubscriptExpr)
    mutating func visitChildren(node: SubscriptExpr) -> Bool
    
    mutating func visit(node: KeypathApplicationExpr)
    mutating func visitChildren(node: KeypathApplicationExpr) -> Bool
    
    mutating func visit(node: DynamicSubscriptExpr)
    mutating func visitChildren(node: DynamicSubscriptExpr) -> Bool
    
    mutating func visit(node: UnresolvedDotExpr)
    mutating func visitChildren(node: UnresolvedDotExpr) -> Bool
    
    mutating func visit(node: TupleElementExpr)
    mutating func visitChildren(node: TupleElementExpr) -> Bool
    
    mutating func visit(node: DestructureTupleExpr)
    mutating func visitChildren(node: DestructureTupleExpr) -> Bool
    
    mutating func visit(node: UnresolvedtypeConversionExpr)
    mutating func visitChildren(node: UnresolvedtypeConversionExpr) -> Bool
    
    mutating func visit(node: FunctionConversionExpr)
    mutating func visitChildren(node: FunctionConversionExpr) -> Bool
    
    mutating func visit(node: CovariantFunctionConversionExpr)
    mutating func visitChildren(node: CovariantFunctionConversionExpr) -> Bool
    
    mutating func visit(node: CovariantReturnConversionExpr)
    mutating func visitChildren(node: CovariantReturnConversionExpr) -> Bool
    
    mutating func visit(node: ImplicitlyUnwrappedFunctionConversionExpr)
    mutating func visitChildren(node: ImplicitlyUnwrappedFunctionConversionExpr) -> Bool
    
    mutating func visit(node: UnderlyingToOpaqueExpr)
    mutating func visitChildren(node: UnderlyingToOpaqueExpr) -> Bool
    
    mutating func visit(node: ErasureExpr)
    mutating func visitChildren(node: ErasureExpr) -> Bool
    
    mutating func visit(node: AnyHashableErasureExpr)
    mutating func visitChildren(node: AnyHashableErasureExpr) -> Bool
    
    mutating func visit(node: ConditionalBridgeFromObjcExpr)
    mutating func visitChildren(node: ConditionalBridgeFromObjcExpr) -> Bool
    
    mutating func visit(node: BridgeFromObjcExpr)
    mutating func visitChildren(node: BridgeFromObjcExpr) -> Bool
    
    mutating func visit(node: BridgeToObjcExpr)
    mutating func visitChildren(node: BridgeToObjcExpr) -> Bool
    
    mutating func visit(node: LoadExpr)
    mutating func visitChildren(node: LoadExpr) -> Bool
    
    mutating func visit(node: MetatypeConversionExpr)
    mutating func visitChildren(node: MetatypeConversionExpr) -> Bool
    
    mutating func visit(node: CollectionUpcastExpr)
    mutating func visitChildren(node: CollectionUpcastExpr) -> Bool
    
    mutating func visit(node: DerivedToBaseExpr)
    mutating func visitChildren(node: DerivedToBaseExpr) -> Bool
    
    mutating func visit(node: ArchetypeToSuperExpr)
    mutating func visitChildren(node: ArchetypeToSuperExpr) -> Bool
    
    mutating func visit(node: InoutExpr)
    mutating func visitChildren(node: InoutExpr) -> Bool
    
    mutating func visit(node: VarargExpansionExpr)
    mutating func visitChildren(node: VarargExpansionExpr) -> Bool
    
    mutating func visit(node: ForceTryExpr)
    mutating func visitChildren(node: ForceTryExpr) -> Bool
    
    mutating func visit(node: OptionalTryExpr)
    mutating func visitChildren(node: OptionalTryExpr) -> Bool
    
    mutating func visit(node: TryExpr)
    mutating func visitChildren(node: TryExpr) -> Bool
    
    mutating func visit(node: SequenceExpr)
    mutating func visitChildren(node: SequenceExpr) -> Bool
    
    mutating func visit(node: ClosureExpr)
    mutating func visitChildren(node: ClosureExpr) -> Bool
    
    mutating func visit(node: AutoclosureExpr)
    mutating func visitChildren(node: AutoclosureExpr) -> Bool
    
    mutating func visit(node: MetatypeExpr)
    mutating func visitChildren(node: MetatypeExpr) -> Bool
    
    mutating func visit(node: OpaqueValueExpr)
    mutating func visitChildren(node: OpaqueValueExpr) -> Bool
    
    mutating func visit(node: PropertyWrapperValuePlaceholderExpr)
    mutating func visitChildren(node: PropertyWrapperValuePlaceholderExpr) -> Bool
    
    mutating func visit(node: DefaultArgumentExpr)
    mutating func visitChildren(node: DefaultArgumentExpr) -> Bool
    
    mutating func visit(node: CallExpr)
    mutating func visitChildren(node: CallExpr) -> Bool
    
    mutating func visit(node: PrefixUnaryExpr)
    mutating func visitChildren(node: PrefixUnaryExpr) -> Bool
    
    mutating func visit(node: PostfixUnaryExpr)
    mutating func visitChildren(node: PostfixUnaryExpr) -> Bool
    
    mutating func visit(node: BinaryExpr)
    mutating func visitChildren(node: BinaryExpr) -> Bool
    
    mutating func visit(node: DotSyntaxCallExpr)
    mutating func visitChildren(node: DotSyntaxCallExpr) -> Bool
    
    mutating func visit(node: ConstructorRefCallExpr)
    mutating func visitChildren(node: ConstructorRefCallExpr) -> Bool
    
    mutating func visit(node: ForcedCheckedCastExpr)
    mutating func visitChildren(node: ForcedCheckedCastExpr) -> Bool
    
    mutating func visit(node: ConditionalCheckedCastExpr)
    mutating func visitChildren(node: ConditionalCheckedCastExpr) -> Bool
    
    mutating func visit(node: IsSubtypeExpr)
    mutating func visitChildren(node: IsSubtypeExpr) -> Bool
    
    mutating func visit(node: CoerceExpr)
    mutating func visitChildren(node: CoerceExpr) -> Bool
    
    mutating func visit(node: RebindSelfInConstructorExpr)
    mutating func visitChildren(node: RebindSelfInConstructorExpr) -> Bool
    
    mutating func visit(node: IfExpr)
    mutating func visitChildren(node: IfExpr) -> Bool
    
    mutating func visit(node: AssignExpr)
    mutating func visitChildren(node: AssignExpr) -> Bool
    
    mutating func visit(node: EnumIsCaseExpr)
    mutating func visitChildren(node: EnumIsCaseExpr) -> Bool
    
    mutating func visit(node: UnresolvedPatternExpr)
    mutating func visitChildren(node: UnresolvedPatternExpr) -> Bool
    
    mutating func visit(node: BindOptionalExpr)
    mutating func visitChildren(node: BindOptionalExpr) -> Bool
    
    mutating func visit(node: OptionalEvaluationExpr)
    mutating func visitChildren(node: OptionalEvaluationExpr) -> Bool
    
    mutating func visit(node: ForceValueExpr)
    mutating func visitChildren(node: ForceValueExpr) -> Bool
    
    mutating func visit(node: OpenExistentialExpr)
    mutating func visitChildren(node: OpenExistentialExpr) -> Bool
    
    mutating func visit(node: MakeTemporarilyEscapableExpr)
    mutating func visitChildren(node: MakeTemporarilyEscapableExpr) -> Bool
    
    mutating func visit(node: EditorPlaceholderExpr)
    mutating func visitChildren(node: EditorPlaceholderExpr) -> Bool
    
    mutating func visit(node: LazyInitializerExpr)
    mutating func visitChildren(node: LazyInitializerExpr) -> Bool
    
    mutating func visit(node: ObjcSelectorExpr)
    mutating func visitChildren(node: ObjcSelectorExpr) -> Bool
    
    mutating func visit(node: KeypathExpr)
    mutating func visitChildren(node: KeypathExpr) -> Bool
    
    mutating func visit(node: KeyPathDotExpr)
    mutating func visitChildren(node: KeyPathDotExpr) -> Bool
    
    mutating func visit(node: OneWayExpr)
    mutating func visitChildren(node: OneWayExpr) -> Bool
    
    mutating func visit(node: TapExpr)
    mutating func visitChildren(node: TapExpr) -> Bool
    
    mutating func visit(node: PatternParen)
    mutating func visitChildren(node: PatternParen) -> Bool
    
    mutating func visit(node: PatternNamed)
    mutating func visitChildren(node: PatternNamed) -> Bool
    
    mutating func visit(node: PatternAny)
    mutating func visitChildren(node: PatternAny) -> Bool
    
    mutating func visit(node: PatternTyped)
    mutating func visitChildren(node: PatternTyped) -> Bool
    
    mutating func visit(node: PatternIs)
    mutating func visitChildren(node: PatternIs) -> Bool
    
    mutating func visit(node: PatternLet)
    mutating func visitChildren(node: PatternLet) -> Bool
    
    mutating func visit(node: PatternVar)
    mutating func visitChildren(node: PatternVar) -> Bool
    
    mutating func visit(node: PatternEnumElement)
    mutating func visitChildren(node: PatternEnumElement) -> Bool
    
    mutating func visit(node: PatternOptionalSome)
    mutating func visitChildren(node: PatternOptionalSome) -> Bool
    
    mutating func visit(node: PatternBool)
    mutating func visitChildren(node: PatternBool) -> Bool
    
    mutating func visit(node: ExtensionDecl)
    mutating func visitChildren(node: ExtensionDecl) -> Bool
    
    mutating func visit(node: Typealias)
    mutating func visitChildren(node: Typealias) -> Bool
    
    mutating func visit(node: GenericTypeParam)
    mutating func visitChildren(node: GenericTypeParam) -> Bool
    
    mutating func visit(node: AssociatedTypeDecl)
    mutating func visitChildren(node: AssociatedTypeDecl) -> Bool
    
    mutating func visit(node: Protocol)
    mutating func visitChildren(node: Protocol) -> Bool
    
    mutating func visit(node: ParamDecl)
    mutating func visitChildren(node: ParamDecl) -> Bool
    
    mutating func visit(node: module)
    mutating func visitChildren(node: module) -> Bool
    
    mutating func visit(node: BraceStmt)
    mutating func visitChildren(node: BraceStmt) -> Bool
    
    mutating func visit(node: ReturnStmt)
    mutating func visitChildren(node: ReturnStmt) -> Bool
    
    mutating func visit(node: YieldStmt)
    mutating func visitChildren(node: YieldStmt) -> Bool
    
    mutating func visit(node: DeferStmt)
    mutating func visitChildren(node: DeferStmt) -> Bool
    
    mutating func visit(node: IfStmt)
    mutating func visitChildren(node: IfStmt) -> Bool
    
    mutating func visit(node: GuardStmt)
    mutating func visitChildren(node: GuardStmt) -> Bool
    
    mutating func visit(node: DoStmt)
    mutating func visitChildren(node: DoStmt) -> Bool
    
    mutating func visit(node: WhileStmt)
    mutating func visitChildren(node: WhileStmt) -> Bool
    
    mutating func visit(node: RepeatWhileStmt)
    mutating func visitChildren(node: RepeatWhileStmt) -> Bool
    
    mutating func visit(node: ForEachStmt)
    mutating func visitChildren(node: ForEachStmt) -> Bool
    
    mutating func visit(node: BreakStmt)
    mutating func visitChildren(node: BreakStmt) -> Bool
    
    mutating func visit(node: ContinueStmt)
    mutating func visitChildren(node: ContinueStmt) -> Bool
    
    mutating func visit(node: FallthroughStmt)
    mutating func visitChildren(node: FallthroughStmt) -> Bool
    
    mutating func visit(node: SwitchStmt)
    mutating func visitChildren(node: SwitchStmt) -> Bool
    
    mutating func visit(node: CaseStmt)
    mutating func visitChildren(node: CaseStmt) -> Bool
    
    mutating func visit(node: FailStmt)
    mutating func visitChildren(node: FailStmt) -> Bool
    
    mutating func visit(node: ThrowStmt)
    mutating func visitChildren(node: ThrowStmt) -> Bool
    
    mutating func visit(node: PoundAssert)
    mutating func visitChildren(node: PoundAssert) -> Bool
    
    mutating func visit(node: DoCatchStmt)
    mutating func visitChildren(node: DoCatchStmt) -> Bool
    
    mutating func visit(node: ObjectLiteral)
    mutating func visitChildren(node: ObjectLiteral) -> Bool
    
    mutating func visit(node: TypeError)
    mutating func visitChildren(node: TypeError) -> Bool
    
    mutating func visit(node: TypeAttributed)
    mutating func visitChildren(node: TypeAttributed) -> Bool
    
    mutating func visit(node: TypeIdent)
    mutating func visitChildren(node: TypeIdent) -> Bool
    
    mutating func visit(node: TypeFunction)
    mutating func visitChildren(node: TypeFunction) -> Bool
    
    mutating func visit(node: TypeArray)
    mutating func visitChildren(node: TypeArray) -> Bool
    
    mutating func visit(node: TypeDictionary)
    mutating func visitChildren(node: TypeDictionary) -> Bool
    
    mutating func visit(node: TypeTuple)
    mutating func visitChildren(node: TypeTuple) -> Bool
    
    mutating func visit(node: TypeComposite)
    mutating func visitChildren(node: TypeComposite) -> Bool
    
    mutating func visit(node: TypeMetatype)
    mutating func visitChildren(node: TypeMetatype) -> Bool
    
    mutating func visit(node: TypeProtocol)
    mutating func visitChildren(node: TypeProtocol) -> Bool
    
    mutating func visit(node: TypeInout)
    mutating func visitChildren(node: TypeInout) -> Bool
    
    mutating func visit(node: TypeShared)
    mutating func visitChildren(node: TypeShared) -> Bool
    
    mutating func visit(node: TypeOwned)
    mutating func visitChildren(node: TypeOwned) -> Bool
    
    mutating func visit(node: TypeOptional)
    mutating func visitChildren(node: TypeOptional) -> Bool
    
    mutating func visit(node: TypeImplicitlyUnwrappedOptional)
    mutating func visitChildren(node: TypeImplicitlyUnwrappedOptional) -> Bool
    
    mutating func visit(node: TypeOpaqueReturn)
    mutating func visitChildren(node: TypeOpaqueReturn) -> Bool
    
    mutating func visit(node: TypeFixed)
    mutating func visitChildren(node: TypeFixed) -> Bool
    
    mutating func visit(node: SilBox)
    mutating func visitChildren(node: SilBox) -> Bool
    
    mutating func visit(node: ErrorType)
    mutating func visitChildren(node: ErrorType) -> Bool
    
    mutating func visit(node: BuiltinIntegerType)
    mutating func visitChildren(node: BuiltinIntegerType) -> Bool
    
    mutating func visit(node: BuiltinFloatType)
    mutating func visitChildren(node: BuiltinFloatType) -> Bool
    
    mutating func visit(node: BuiltinVectorType)
    mutating func visitChildren(node: BuiltinVectorType) -> Bool
    
    mutating func visit(node: TypeAliasType)
    mutating func visitChildren(node: TypeAliasType) -> Bool
    
    mutating func visit(node: ParenType)
    mutating func visitChildren(node: ParenType) -> Bool
    
    mutating func visit(node: TupleType)
    mutating func visitChildren(node: TupleType) -> Bool
    
    mutating func visit(node: EnumType)
    mutating func visitChildren(node: EnumType) -> Bool
    
    mutating func visit(node: StructType)
    mutating func visitChildren(node: StructType) -> Bool
    
    mutating func visit(node: ClassType)
    mutating func visitChildren(node: ClassType) -> Bool
    
    mutating func visit(node: ProtocolType)
    mutating func visitChildren(node: ProtocolType) -> Bool
    
    mutating func visit(node: MetatypeType)
    mutating func visitChildren(node: MetatypeType) -> Bool
    
    mutating func visit(node: ExistentialMetatypeType)
    mutating func visitChildren(node: ExistentialMetatypeType) -> Bool
    
    mutating func visit(node: ModuleType)
    mutating func visitChildren(node: ModuleType) -> Bool
    
    mutating func visit(node: DynamicSelfType)
    mutating func visitChildren(node: DynamicSelfType) -> Bool
    
    mutating func visit(node: PrimaryArchetypeType)
    mutating func visitChildren(node: PrimaryArchetypeType) -> Bool
    
    mutating func visit(node: NestedArchetypeType)
    mutating func visitChildren(node: NestedArchetypeType) -> Bool
    
    mutating func visit(node: OpenedArchetypeType)
    mutating func visitChildren(node: OpenedArchetypeType) -> Bool
    
    mutating func visit(node: OpaqueType)
    mutating func visitChildren(node: OpaqueType) -> Bool
    
    mutating func visit(node: GenericTypeParamType)
    mutating func visitChildren(node: GenericTypeParamType) -> Bool
    
    mutating func visit(node: DependentMemberType)
    mutating func visitChildren(node: DependentMemberType) -> Bool
    
    mutating func visit(node: FunctionType)
    mutating func visitChildren(node: FunctionType) -> Bool
    
    mutating func visit(node: GenericFunctionType)
    mutating func visitChildren(node: GenericFunctionType) -> Bool
    
    mutating func visit(node: SilFunctionType)
    mutating func visitChildren(node: SilFunctionType) -> Bool
    
    mutating func visit(node: SilBlockStorageType)
    mutating func visitChildren(node: SilBlockStorageType) -> Bool
    
    mutating func visit(node: SilBoxType)
    mutating func visitChildren(node: SilBoxType) -> Bool
    
    mutating func visit(node: ArraySliceType)
    mutating func visitChildren(node: ArraySliceType) -> Bool
    
    mutating func visit(node: OptionalType)
    mutating func visitChildren(node: OptionalType) -> Bool
    
    mutating func visit(node: DictionaryType)
    mutating func visitChildren(node: DictionaryType) -> Bool
    
    mutating func visit(node: ProtocolCompositionType)
    mutating func visitChildren(node: ProtocolCompositionType) -> Bool
    
    mutating func visit(node: LvalueType)
    mutating func visitChildren(node: LvalueType) -> Bool
    
    mutating func visit(node: InoutType)
    mutating func visitChildren(node: InoutType) -> Bool
    
    mutating func visit(node: UnboundGenericType)
    mutating func visitChildren(node: UnboundGenericType) -> Bool
    
    mutating func visit(node: BoundGenericClassType)
    mutating func visitChildren(node: BoundGenericClassType) -> Bool
    
    mutating func visit(node: BoundGenericStructType)
    mutating func visitChildren(node: BoundGenericStructType) -> Bool
    
    mutating func visit(node: BoundGenericEnumType)
    mutating func visitChildren(node: BoundGenericEnumType) -> Bool
    
    mutating func visit(node: TypeVariableType)
    mutating func visitChildren(node: TypeVariableType) -> Bool
    
    mutating func visit(node: PatternTuple)
    mutating func visitChildren(node: PatternTuple) -> Bool
    
    mutating func visit(node: ParameterList)
    mutating func visitChildren(node: ParameterList) -> Bool
    
    mutating func visit(node: Parameter)
    mutating func visitChildren(node: Parameter) -> Bool
    
    mutating func visit(node: ArgumentShuffleExpr)
    mutating func visitChildren(node: ArgumentShuffleExpr) -> Bool
    
    mutating func visit(node: NodeSyntax)
    mutating func visitChildren(node: NodeSyntax) -> Bool
}

public extension SyntaxVisitor {
	
    mutating func visit(node: SourceFileDecl) {
        // Noop
    }
    mutating func visitChildren(node: SourceFileDecl) -> Bool {
        true
    }
    
    mutating func visit(node: ImportDecl) {
        // Noop
    }
    mutating func visitChildren(node: ImportDecl) -> Bool {
        true
    }
    
    mutating func visit(node: VarDecl) {
        // Noop
    }
    mutating func visitChildren(node: VarDecl) -> Bool {
        true
    }
    
    mutating func visit(node: EnumCaseDecl) {
        // Noop
    }
    mutating func visitChildren(node: EnumCaseDecl) -> Bool {
        true
    }
    
    mutating func visit(node: EnumDecl) {
        // Noop
    }
    mutating func visitChildren(node: EnumDecl) -> Bool {
        true
    }
    
    mutating func visit(node: EnumElementDecl) {
        // Noop
    }
    mutating func visitChildren(node: EnumElementDecl) -> Bool {
        true
    }
    
    mutating func visit(node: StructDecl) {
        // Noop
    }
    mutating func visitChildren(node: StructDecl) -> Bool {
        true
    }
    
    mutating func visit(node: ClassDecl) {
        // Noop
    }
    mutating func visitChildren(node: ClassDecl) -> Bool {
        true
    }
    
    mutating func visit(node: PatternBindingDecl) {
        // Noop
    }
    mutating func visitChildren(node: PatternBindingDecl) -> Bool {
        true
    }
    
    mutating func visit(node: SubscriptDecl) {
        // Noop
    }
    mutating func visitChildren(node: SubscriptDecl) -> Bool {
        true
    }
    
    mutating func visit(node: FuncDecl) {
        // Noop
    }
    mutating func visitChildren(node: FuncDecl) -> Bool {
        true
    }
    
    mutating func visit(node: AccessorDecl) {
        // Noop
    }
    mutating func visitChildren(node: AccessorDecl) -> Bool {
        true
    }
    
    mutating func visit(node: ConstructorDecl) {
        // Noop
    }
    mutating func visitChildren(node: ConstructorDecl) -> Bool {
        true
    }
    
    mutating func visit(node: DestructorDecl) {
        // Noop
    }
    mutating func visitChildren(node: DestructorDecl) -> Bool {
        true
    }
    
    mutating func visit(node: TopLevelCodeDecl) {
        // Noop
    }
    mutating func visitChildren(node: TopLevelCodeDecl) -> Bool {
        true
    }
    
    mutating func visit(node: IfConfigDecl) {
        // Noop
    }
    mutating func visitChildren(node: IfConfigDecl) -> Bool {
        true
    }
    
    mutating func visit(node: PoundDiagnosticDecl) {
        // Noop
    }
    mutating func visitChildren(node: PoundDiagnosticDecl) -> Bool {
        true
    }
    
    mutating func visit(node: PrecedenceGroupDecl) {
        // Noop
    }
    mutating func visitChildren(node: PrecedenceGroupDecl) -> Bool {
        true
    }
    
    mutating func visit(node: InfixOperatorDecl) {
        // Noop
    }
    mutating func visitChildren(node: InfixOperatorDecl) -> Bool {
        true
    }
    
    mutating func visit(node: PrefixOperatorDecl) {
        // Noop
    }
    mutating func visitChildren(node: PrefixOperatorDecl) -> Bool {
        true
    }
    
    mutating func visit(node: PostfixOperatorDecl) {
        // Noop
    }
    mutating func visitChildren(node: PostfixOperatorDecl) -> Bool {
        true
    }
    
    mutating func visit(node: MissingMemberDecl) {
        // Noop
    }
    mutating func visitChildren(node: MissingMemberDecl) -> Bool {
        true
    }
    
    mutating func visit(node: DeclrefExpr) {
        // Noop
    }
    mutating func visitChildren(node: DeclrefExpr) -> Bool {
        true
    }
    
    mutating func visit(node: OverloadedDeclRefExpr) {
        // Noop
    }
    mutating func visitChildren(node: OverloadedDeclRefExpr) -> Bool {
        true
    }
    
    mutating func visit(node: UnresolvedDeclRefExpr) {
        // Noop
    }
    mutating func visitChildren(node: UnresolvedDeclRefExpr) -> Bool {
        true
    }
    
    mutating func visit(node: PatternExpr) {
        // Noop
    }
    mutating func visitChildren(node: PatternExpr) -> Bool {
        true
    }
    
    mutating func visit(node: SemanticExpr) {
        // Noop
    }
    mutating func visitChildren(node: SemanticExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ErrorExpr) {
        // Noop
    }
    mutating func visitChildren(node: ErrorExpr) -> Bool {
        true
    }
    
    mutating func visit(node: CodeCompletionExpr) {
        // Noop
    }
    mutating func visitChildren(node: CodeCompletionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: NilLiteralExpr) {
        // Noop
    }
    mutating func visitChildren(node: NilLiteralExpr) -> Bool {
        true
    }
    
    mutating func visit(node: IntegerLiteralExpr) {
        // Noop
    }
    mutating func visitChildren(node: IntegerLiteralExpr) -> Bool {
        true
    }
    
    mutating func visit(node: FloatLiteralExpr) {
        // Noop
    }
    mutating func visitChildren(node: FloatLiteralExpr) -> Bool {
        true
    }
    
    mutating func visit(node: BooleanLiteralExpr) {
        // Noop
    }
    mutating func visitChildren(node: BooleanLiteralExpr) -> Bool {
        true
    }
    
    mutating func visit(node: StringLiteralExpr) {
        // Noop
    }
    mutating func visitChildren(node: StringLiteralExpr) -> Bool {
        true
    }
    
    mutating func visit(node: InterpolatedStringLiteralExpr) {
        // Noop
    }
    mutating func visitChildren(node: InterpolatedStringLiteralExpr) -> Bool {
        true
    }
    
    mutating func visit(node: MagicIdentifierLiteralExpr) {
        // Noop
    }
    mutating func visitChildren(node: MagicIdentifierLiteralExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DiscardAssignmentExpr) {
        // Noop
    }
    mutating func visitChildren(node: DiscardAssignmentExpr) -> Bool {
        true
    }
    
    mutating func visit(node: SuperRefExpr) {
        // Noop
    }
    mutating func visitChildren(node: SuperRefExpr) -> Bool {
        true
    }
    
    mutating func visit(node: TypeExpr) {
        // Noop
    }
    mutating func visitChildren(node: TypeExpr) -> Bool {
        true
    }
    
    mutating func visit(node: OtherConstructorRefExpr) {
        // Noop
    }
    mutating func visitChildren(node: OtherConstructorRefExpr) -> Bool {
        true
    }
    
    mutating func visit(node: UnresolvedSpecializeExpr) {
        // Noop
    }
    mutating func visitChildren(node: UnresolvedSpecializeExpr) -> Bool {
        true
    }
    
    mutating func visit(node: MemberRefExpr) {
        // Noop
    }
    mutating func visitChildren(node: MemberRefExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DynamicMemberRefExpr) {
        // Noop
    }
    mutating func visitChildren(node: DynamicMemberRefExpr) -> Bool {
        true
    }
    
    mutating func visit(node: UnresolvedMemberExpr) {
        // Noop
    }
    mutating func visitChildren(node: UnresolvedMemberExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DotSelfExpr) {
        // Noop
    }
    mutating func visitChildren(node: DotSelfExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ParenExpr) {
        // Noop
    }
    mutating func visitChildren(node: ParenExpr) -> Bool {
        true
    }
    
    mutating func visit(node: TupleExpr) {
        // Noop
    }
    mutating func visitChildren(node: TupleExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ArrayExpr) {
        // Noop
    }
    mutating func visitChildren(node: ArrayExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DictionaryExpr) {
        // Noop
    }
    mutating func visitChildren(node: DictionaryExpr) -> Bool {
        true
    }
    
    mutating func visit(node: SubscriptExpr) {
        // Noop
    }
    mutating func visitChildren(node: SubscriptExpr) -> Bool {
        true
    }
    
    mutating func visit(node: KeypathApplicationExpr) {
        // Noop
    }
    mutating func visitChildren(node: KeypathApplicationExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DynamicSubscriptExpr) {
        // Noop
    }
    mutating func visitChildren(node: DynamicSubscriptExpr) -> Bool {
        true
    }
    
    mutating func visit(node: UnresolvedDotExpr) {
        // Noop
    }
    mutating func visitChildren(node: UnresolvedDotExpr) -> Bool {
        true
    }
    
    mutating func visit(node: TupleElementExpr) {
        // Noop
    }
    mutating func visitChildren(node: TupleElementExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DestructureTupleExpr) {
        // Noop
    }
    mutating func visitChildren(node: DestructureTupleExpr) -> Bool {
        true
    }
    
    mutating func visit(node: UnresolvedtypeConversionExpr) {
        // Noop
    }
    mutating func visitChildren(node: UnresolvedtypeConversionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: FunctionConversionExpr) {
        // Noop
    }
    mutating func visitChildren(node: FunctionConversionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: CovariantFunctionConversionExpr) {
        // Noop
    }
    mutating func visitChildren(node: CovariantFunctionConversionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: CovariantReturnConversionExpr) {
        // Noop
    }
    mutating func visitChildren(node: CovariantReturnConversionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ImplicitlyUnwrappedFunctionConversionExpr) {
        // Noop
    }
    mutating func visitChildren(node: ImplicitlyUnwrappedFunctionConversionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: UnderlyingToOpaqueExpr) {
        // Noop
    }
    mutating func visitChildren(node: UnderlyingToOpaqueExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ErasureExpr) {
        // Noop
    }
    mutating func visitChildren(node: ErasureExpr) -> Bool {
        true
    }
    
    mutating func visit(node: AnyHashableErasureExpr) {
        // Noop
    }
    mutating func visitChildren(node: AnyHashableErasureExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ConditionalBridgeFromObjcExpr) {
        // Noop
    }
    mutating func visitChildren(node: ConditionalBridgeFromObjcExpr) -> Bool {
        true
    }
    
    mutating func visit(node: BridgeFromObjcExpr) {
        // Noop
    }
    mutating func visitChildren(node: BridgeFromObjcExpr) -> Bool {
        true
    }
    
    mutating func visit(node: BridgeToObjcExpr) {
        // Noop
    }
    mutating func visitChildren(node: BridgeToObjcExpr) -> Bool {
        true
    }
    
    mutating func visit(node: LoadExpr) {
        // Noop
    }
    mutating func visitChildren(node: LoadExpr) -> Bool {
        true
    }
    
    mutating func visit(node: MetatypeConversionExpr) {
        // Noop
    }
    mutating func visitChildren(node: MetatypeConversionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: CollectionUpcastExpr) {
        // Noop
    }
    mutating func visitChildren(node: CollectionUpcastExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DerivedToBaseExpr) {
        // Noop
    }
    mutating func visitChildren(node: DerivedToBaseExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ArchetypeToSuperExpr) {
        // Noop
    }
    mutating func visitChildren(node: ArchetypeToSuperExpr) -> Bool {
        true
    }
    
    mutating func visit(node: InoutExpr) {
        // Noop
    }
    mutating func visitChildren(node: InoutExpr) -> Bool {
        true
    }
    
    mutating func visit(node: VarargExpansionExpr) {
        // Noop
    }
    mutating func visitChildren(node: VarargExpansionExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ForceTryExpr) {
        // Noop
    }
    mutating func visitChildren(node: ForceTryExpr) -> Bool {
        true
    }
    
    mutating func visit(node: OptionalTryExpr) {
        // Noop
    }
    mutating func visitChildren(node: OptionalTryExpr) -> Bool {
        true
    }
    
    mutating func visit(node: TryExpr) {
        // Noop
    }
    mutating func visitChildren(node: TryExpr) -> Bool {
        true
    }
    
    mutating func visit(node: SequenceExpr) {
        // Noop
    }
    mutating func visitChildren(node: SequenceExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ClosureExpr) {
        // Noop
    }
    mutating func visitChildren(node: ClosureExpr) -> Bool {
        true
    }
    
    mutating func visit(node: AutoclosureExpr) {
        // Noop
    }
    mutating func visitChildren(node: AutoclosureExpr) -> Bool {
        true
    }
    
    mutating func visit(node: MetatypeExpr) {
        // Noop
    }
    mutating func visitChildren(node: MetatypeExpr) -> Bool {
        true
    }
    
    mutating func visit(node: OpaqueValueExpr) {
        // Noop
    }
    mutating func visitChildren(node: OpaqueValueExpr) -> Bool {
        true
    }
    
    mutating func visit(node: PropertyWrapperValuePlaceholderExpr) {
        // Noop
    }
    mutating func visitChildren(node: PropertyWrapperValuePlaceholderExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DefaultArgumentExpr) {
        // Noop
    }
    mutating func visitChildren(node: DefaultArgumentExpr) -> Bool {
        true
    }
    
    mutating func visit(node: CallExpr) {
        // Noop
    }
    mutating func visitChildren(node: CallExpr) -> Bool {
        true
    }
    
    mutating func visit(node: PrefixUnaryExpr) {
        // Noop
    }
    mutating func visitChildren(node: PrefixUnaryExpr) -> Bool {
        true
    }
    
    mutating func visit(node: PostfixUnaryExpr) {
        // Noop
    }
    mutating func visitChildren(node: PostfixUnaryExpr) -> Bool {
        true
    }
    
    mutating func visit(node: BinaryExpr) {
        // Noop
    }
    mutating func visitChildren(node: BinaryExpr) -> Bool {
        true
    }
    
    mutating func visit(node: DotSyntaxCallExpr) {
        // Noop
    }
    mutating func visitChildren(node: DotSyntaxCallExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ConstructorRefCallExpr) {
        // Noop
    }
    mutating func visitChildren(node: ConstructorRefCallExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ForcedCheckedCastExpr) {
        // Noop
    }
    mutating func visitChildren(node: ForcedCheckedCastExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ConditionalCheckedCastExpr) {
        // Noop
    }
    mutating func visitChildren(node: ConditionalCheckedCastExpr) -> Bool {
        true
    }
    
    mutating func visit(node: IsSubtypeExpr) {
        // Noop
    }
    mutating func visitChildren(node: IsSubtypeExpr) -> Bool {
        true
    }
    
    mutating func visit(node: CoerceExpr) {
        // Noop
    }
    mutating func visitChildren(node: CoerceExpr) -> Bool {
        true
    }
    
    mutating func visit(node: RebindSelfInConstructorExpr) {
        // Noop
    }
    mutating func visitChildren(node: RebindSelfInConstructorExpr) -> Bool {
        true
    }
    
    mutating func visit(node: IfExpr) {
        // Noop
    }
    mutating func visitChildren(node: IfExpr) -> Bool {
        true
    }
    
    mutating func visit(node: AssignExpr) {
        // Noop
    }
    mutating func visitChildren(node: AssignExpr) -> Bool {
        true
    }
    
    mutating func visit(node: EnumIsCaseExpr) {
        // Noop
    }
    mutating func visitChildren(node: EnumIsCaseExpr) -> Bool {
        true
    }
    
    mutating func visit(node: UnresolvedPatternExpr) {
        // Noop
    }
    mutating func visitChildren(node: UnresolvedPatternExpr) -> Bool {
        true
    }
    
    mutating func visit(node: BindOptionalExpr) {
        // Noop
    }
    mutating func visitChildren(node: BindOptionalExpr) -> Bool {
        true
    }
    
    mutating func visit(node: OptionalEvaluationExpr) {
        // Noop
    }
    mutating func visitChildren(node: OptionalEvaluationExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ForceValueExpr) {
        // Noop
    }
    mutating func visitChildren(node: ForceValueExpr) -> Bool {
        true
    }
    
    mutating func visit(node: OpenExistentialExpr) {
        // Noop
    }
    mutating func visitChildren(node: OpenExistentialExpr) -> Bool {
        true
    }
    
    mutating func visit(node: MakeTemporarilyEscapableExpr) {
        // Noop
    }
    mutating func visitChildren(node: MakeTemporarilyEscapableExpr) -> Bool {
        true
    }
    
    mutating func visit(node: EditorPlaceholderExpr) {
        // Noop
    }
    mutating func visitChildren(node: EditorPlaceholderExpr) -> Bool {
        true
    }
    
    mutating func visit(node: LazyInitializerExpr) {
        // Noop
    }
    mutating func visitChildren(node: LazyInitializerExpr) -> Bool {
        true
    }
    
    mutating func visit(node: ObjcSelectorExpr) {
        // Noop
    }
    mutating func visitChildren(node: ObjcSelectorExpr) -> Bool {
        true
    }
    
    mutating func visit(node: KeypathExpr) {
        // Noop
    }
    mutating func visitChildren(node: KeypathExpr) -> Bool {
        true
    }
    
    mutating func visit(node: KeyPathDotExpr) {
        // Noop
    }
    mutating func visitChildren(node: KeyPathDotExpr) -> Bool {
        true
    }
    
    mutating func visit(node: OneWayExpr) {
        // Noop
    }
    mutating func visitChildren(node: OneWayExpr) -> Bool {
        true
    }
    
    mutating func visit(node: TapExpr) {
        // Noop
    }
    mutating func visitChildren(node: TapExpr) -> Bool {
        true
    }
    
    mutating func visit(node: PatternParen) {
        // Noop
    }
    mutating func visitChildren(node: PatternParen) -> Bool {
        true
    }
    
    mutating func visit(node: PatternNamed) {
        // Noop
    }
    mutating func visitChildren(node: PatternNamed) -> Bool {
        true
    }
    
    mutating func visit(node: PatternAny) {
        // Noop
    }
    mutating func visitChildren(node: PatternAny) -> Bool {
        true
    }
    
    mutating func visit(node: PatternTyped) {
        // Noop
    }
    mutating func visitChildren(node: PatternTyped) -> Bool {
        true
    }
    
    mutating func visit(node: PatternIs) {
        // Noop
    }
    mutating func visitChildren(node: PatternIs) -> Bool {
        true
    }
    
    mutating func visit(node: PatternLet) {
        // Noop
    }
    mutating func visitChildren(node: PatternLet) -> Bool {
        true
    }
    
    mutating func visit(node: PatternVar) {
        // Noop
    }
    mutating func visitChildren(node: PatternVar) -> Bool {
        true
    }
    
    mutating func visit(node: PatternEnumElement) {
        // Noop
    }
    mutating func visitChildren(node: PatternEnumElement) -> Bool {
        true
    }
    
    mutating func visit(node: PatternOptionalSome) {
        // Noop
    }
    mutating func visitChildren(node: PatternOptionalSome) -> Bool {
        true
    }
    
    mutating func visit(node: PatternBool) {
        // Noop
    }
    mutating func visitChildren(node: PatternBool) -> Bool {
        true
    }
    
    mutating func visit(node: ExtensionDecl) {
        // Noop
    }
    mutating func visitChildren(node: ExtensionDecl) -> Bool {
        true
    }
    
    mutating func visit(node: Typealias) {
        // Noop
    }
    mutating func visitChildren(node: Typealias) -> Bool {
        true
    }
    
    mutating func visit(node: GenericTypeParam) {
        // Noop
    }
    mutating func visitChildren(node: GenericTypeParam) -> Bool {
        true
    }
    
    mutating func visit(node: AssociatedTypeDecl) {
        // Noop
    }
    mutating func visitChildren(node: AssociatedTypeDecl) -> Bool {
        true
    }
    
    mutating func visit(node: Protocol) {
        // Noop
    }
    mutating func visitChildren(node: Protocol) -> Bool {
        true
    }
    
    mutating func visit(node: ParamDecl) {
        // Noop
    }
    mutating func visitChildren(node: ParamDecl) -> Bool {
        true
    }
    
    mutating func visit(node: module) {
        // Noop
    }
    mutating func visitChildren(node: module) -> Bool {
        true
    }
    
    mutating func visit(node: BraceStmt) {
        // Noop
    }
    mutating func visitChildren(node: BraceStmt) -> Bool {
        true
    }
    
    mutating func visit(node: ReturnStmt) {
        // Noop
    }
    mutating func visitChildren(node: ReturnStmt) -> Bool {
        true
    }
    
    mutating func visit(node: YieldStmt) {
        // Noop
    }
    mutating func visitChildren(node: YieldStmt) -> Bool {
        true
    }
    
    mutating func visit(node: DeferStmt) {
        // Noop
    }
    mutating func visitChildren(node: DeferStmt) -> Bool {
        true
    }
    
    mutating func visit(node: IfStmt) {
        // Noop
    }
    mutating func visitChildren(node: IfStmt) -> Bool {
        true
    }
    
    mutating func visit(node: GuardStmt) {
        // Noop
    }
    mutating func visitChildren(node: GuardStmt) -> Bool {
        true
    }
    
    mutating func visit(node: DoStmt) {
        // Noop
    }
    mutating func visitChildren(node: DoStmt) -> Bool {
        true
    }
    
    mutating func visit(node: WhileStmt) {
        // Noop
    }
    mutating func visitChildren(node: WhileStmt) -> Bool {
        true
    }
    
    mutating func visit(node: RepeatWhileStmt) {
        // Noop
    }
    mutating func visitChildren(node: RepeatWhileStmt) -> Bool {
        true
    }
    
    mutating func visit(node: ForEachStmt) {
        // Noop
    }
    mutating func visitChildren(node: ForEachStmt) -> Bool {
        true
    }
    
    mutating func visit(node: BreakStmt) {
        // Noop
    }
    mutating func visitChildren(node: BreakStmt) -> Bool {
        true
    }
    
    mutating func visit(node: ContinueStmt) {
        // Noop
    }
    mutating func visitChildren(node: ContinueStmt) -> Bool {
        true
    }
    
    mutating func visit(node: FallthroughStmt) {
        // Noop
    }
    mutating func visitChildren(node: FallthroughStmt) -> Bool {
        true
    }
    
    mutating func visit(node: SwitchStmt) {
        // Noop
    }
    mutating func visitChildren(node: SwitchStmt) -> Bool {
        true
    }
    
    mutating func visit(node: CaseStmt) {
        // Noop
    }
    mutating func visitChildren(node: CaseStmt) -> Bool {
        true
    }
    
    mutating func visit(node: FailStmt) {
        // Noop
    }
    mutating func visitChildren(node: FailStmt) -> Bool {
        true
    }
    
    mutating func visit(node: ThrowStmt) {
        // Noop
    }
    mutating func visitChildren(node: ThrowStmt) -> Bool {
        true
    }
    
    mutating func visit(node: PoundAssert) {
        // Noop
    }
    mutating func visitChildren(node: PoundAssert) -> Bool {
        true
    }
    
    mutating func visit(node: DoCatchStmt) {
        // Noop
    }
    mutating func visitChildren(node: DoCatchStmt) -> Bool {
        true
    }
    
    mutating func visit(node: ObjectLiteral) {
        // Noop
    }
    mutating func visitChildren(node: ObjectLiteral) -> Bool {
        true
    }
    
    mutating func visit(node: TypeError) {
        // Noop
    }
    mutating func visitChildren(node: TypeError) -> Bool {
        true
    }
    
    mutating func visit(node: TypeAttributed) {
        // Noop
    }
    mutating func visitChildren(node: TypeAttributed) -> Bool {
        true
    }
    
    mutating func visit(node: TypeIdent) {
        // Noop
    }
    mutating func visitChildren(node: TypeIdent) -> Bool {
        true
    }
    
    mutating func visit(node: TypeFunction) {
        // Noop
    }
    mutating func visitChildren(node: TypeFunction) -> Bool {
        true
    }
    
    mutating func visit(node: TypeArray) {
        // Noop
    }
    mutating func visitChildren(node: TypeArray) -> Bool {
        true
    }
    
    mutating func visit(node: TypeDictionary) {
        // Noop
    }
    mutating func visitChildren(node: TypeDictionary) -> Bool {
        true
    }
    
    mutating func visit(node: TypeTuple) {
        // Noop
    }
    mutating func visitChildren(node: TypeTuple) -> Bool {
        true
    }
    
    mutating func visit(node: TypeComposite) {
        // Noop
    }
    mutating func visitChildren(node: TypeComposite) -> Bool {
        true
    }
    
    mutating func visit(node: TypeMetatype) {
        // Noop
    }
    mutating func visitChildren(node: TypeMetatype) -> Bool {
        true
    }
    
    mutating func visit(node: TypeProtocol) {
        // Noop
    }
    mutating func visitChildren(node: TypeProtocol) -> Bool {
        true
    }
    
    mutating func visit(node: TypeInout) {
        // Noop
    }
    mutating func visitChildren(node: TypeInout) -> Bool {
        true
    }
    
    mutating func visit(node: TypeShared) {
        // Noop
    }
    mutating func visitChildren(node: TypeShared) -> Bool {
        true
    }
    
    mutating func visit(node: TypeOwned) {
        // Noop
    }
    mutating func visitChildren(node: TypeOwned) -> Bool {
        true
    }
    
    mutating func visit(node: TypeOptional) {
        // Noop
    }
    mutating func visitChildren(node: TypeOptional) -> Bool {
        true
    }
    
    mutating func visit(node: TypeImplicitlyUnwrappedOptional) {
        // Noop
    }
    mutating func visitChildren(node: TypeImplicitlyUnwrappedOptional) -> Bool {
        true
    }
    
    mutating func visit(node: TypeOpaqueReturn) {
        // Noop
    }
    mutating func visitChildren(node: TypeOpaqueReturn) -> Bool {
        true
    }
    
    mutating func visit(node: TypeFixed) {
        // Noop
    }
    mutating func visitChildren(node: TypeFixed) -> Bool {
        true
    }
    
    mutating func visit(node: SilBox) {
        // Noop
    }
    mutating func visitChildren(node: SilBox) -> Bool {
        true
    }
    
    mutating func visit(node: ErrorType) {
        // Noop
    }
    mutating func visitChildren(node: ErrorType) -> Bool {
        true
    }
    
    mutating func visit(node: BuiltinIntegerType) {
        // Noop
    }
    mutating func visitChildren(node: BuiltinIntegerType) -> Bool {
        true
    }
    
    mutating func visit(node: BuiltinFloatType) {
        // Noop
    }
    mutating func visitChildren(node: BuiltinFloatType) -> Bool {
        true
    }
    
    mutating func visit(node: BuiltinVectorType) {
        // Noop
    }
    mutating func visitChildren(node: BuiltinVectorType) -> Bool {
        true
    }
    
    mutating func visit(node: TypeAliasType) {
        // Noop
    }
    mutating func visitChildren(node: TypeAliasType) -> Bool {
        true
    }
    
    mutating func visit(node: ParenType) {
        // Noop
    }
    mutating func visitChildren(node: ParenType) -> Bool {
        true
    }
    
    mutating func visit(node: TupleType) {
        // Noop
    }
    mutating func visitChildren(node: TupleType) -> Bool {
        true
    }
    
    mutating func visit(node: EnumType) {
        // Noop
    }
    mutating func visitChildren(node: EnumType) -> Bool {
        true
    }
    
    mutating func visit(node: StructType) {
        // Noop
    }
    mutating func visitChildren(node: StructType) -> Bool {
        true
    }
    
    mutating func visit(node: ClassType) {
        // Noop
    }
    mutating func visitChildren(node: ClassType) -> Bool {
        true
    }
    
    mutating func visit(node: ProtocolType) {
        // Noop
    }
    mutating func visitChildren(node: ProtocolType) -> Bool {
        true
    }
    
    mutating func visit(node: MetatypeType) {
        // Noop
    }
    mutating func visitChildren(node: MetatypeType) -> Bool {
        true
    }
    
    mutating func visit(node: ExistentialMetatypeType) {
        // Noop
    }
    mutating func visitChildren(node: ExistentialMetatypeType) -> Bool {
        true
    }
    
    mutating func visit(node: ModuleType) {
        // Noop
    }
    mutating func visitChildren(node: ModuleType) -> Bool {
        true
    }
    
    mutating func visit(node: DynamicSelfType) {
        // Noop
    }
    mutating func visitChildren(node: DynamicSelfType) -> Bool {
        true
    }
    
    mutating func visit(node: PrimaryArchetypeType) {
        // Noop
    }
    mutating func visitChildren(node: PrimaryArchetypeType) -> Bool {
        true
    }
    
    mutating func visit(node: NestedArchetypeType) {
        // Noop
    }
    mutating func visitChildren(node: NestedArchetypeType) -> Bool {
        true
    }
    
    mutating func visit(node: OpenedArchetypeType) {
        // Noop
    }
    mutating func visitChildren(node: OpenedArchetypeType) -> Bool {
        true
    }
    
    mutating func visit(node: OpaqueType) {
        // Noop
    }
    mutating func visitChildren(node: OpaqueType) -> Bool {
        true
    }
    
    mutating func visit(node: GenericTypeParamType) {
        // Noop
    }
    mutating func visitChildren(node: GenericTypeParamType) -> Bool {
        true
    }
    
    mutating func visit(node: DependentMemberType) {
        // Noop
    }
    mutating func visitChildren(node: DependentMemberType) -> Bool {
        true
    }
    
    mutating func visit(node: FunctionType) {
        // Noop
    }
    mutating func visitChildren(node: FunctionType) -> Bool {
        true
    }
    
    mutating func visit(node: GenericFunctionType) {
        // Noop
    }
    mutating func visitChildren(node: GenericFunctionType) -> Bool {
        true
    }
    
    mutating func visit(node: SilFunctionType) {
        // Noop
    }
    mutating func visitChildren(node: SilFunctionType) -> Bool {
        true
    }
    
    mutating func visit(node: SilBlockStorageType) {
        // Noop
    }
    mutating func visitChildren(node: SilBlockStorageType) -> Bool {
        true
    }
    
    mutating func visit(node: SilBoxType) {
        // Noop
    }
    mutating func visitChildren(node: SilBoxType) -> Bool {
        true
    }
    
    mutating func visit(node: ArraySliceType) {
        // Noop
    }
    mutating func visitChildren(node: ArraySliceType) -> Bool {
        true
    }
    
    mutating func visit(node: OptionalType) {
        // Noop
    }
    mutating func visitChildren(node: OptionalType) -> Bool {
        true
    }
    
    mutating func visit(node: DictionaryType) {
        // Noop
    }
    mutating func visitChildren(node: DictionaryType) -> Bool {
        true
    }
    
    mutating func visit(node: ProtocolCompositionType) {
        // Noop
    }
    mutating func visitChildren(node: ProtocolCompositionType) -> Bool {
        true
    }
    
    mutating func visit(node: LvalueType) {
        // Noop
    }
    mutating func visitChildren(node: LvalueType) -> Bool {
        true
    }
    
    mutating func visit(node: InoutType) {
        // Noop
    }
    mutating func visitChildren(node: InoutType) -> Bool {
        true
    }
    
    mutating func visit(node: UnboundGenericType) {
        // Noop
    }
    mutating func visitChildren(node: UnboundGenericType) -> Bool {
        true
    }
    
    mutating func visit(node: BoundGenericClassType) {
        // Noop
    }
    mutating func visitChildren(node: BoundGenericClassType) -> Bool {
        true
    }
    
    mutating func visit(node: BoundGenericStructType) {
        // Noop
    }
    mutating func visitChildren(node: BoundGenericStructType) -> Bool {
        true
    }
    
    mutating func visit(node: BoundGenericEnumType) {
        // Noop
    }
    mutating func visitChildren(node: BoundGenericEnumType) -> Bool {
        true
    }
    
    mutating func visit(node: TypeVariableType) {
        // Noop
    }
    mutating func visitChildren(node: TypeVariableType) -> Bool {
        true
    }
    
    mutating func visit(node: PatternTuple) {
        // Noop
    }
    mutating func visitChildren(node: PatternTuple) -> Bool {
        true
    }
    
    mutating func visit(node: ParameterList) {
        // Noop
    }
    mutating func visitChildren(node: ParameterList) -> Bool {
        true
    }
    
    mutating func visit(node: Parameter) {
        // Noop
    }
    mutating func visitChildren(node: Parameter) -> Bool {
        true
    }
    
    mutating func visit(node: ArgumentShuffleExpr) {
        // Noop
    }
    mutating func visitChildren(node: ArgumentShuffleExpr) -> Bool {
        true
    }
    
    mutating func visit(node: NodeSyntax) {
        // Noop
    }

    mutating func visitChildren(node: NodeSyntax) -> Bool {
        true
    }
}
