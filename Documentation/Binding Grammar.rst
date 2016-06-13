

DSL Grammars
============

Binding Grammar
```````````````

.. productionlist::
    bind_stmt   : "binder"
                : `bind_step`
    bind_step   : ".bind(" [ element_metatype_expr ] ")"
                : `collection_step`
    collection_step : [ ".intoCollection()" ]
                    : `tag_step`
    tag_step    : [ ".tagged(with: " tag_metatype_expr ")" ]
                : `scope_step`
    scope_step  : [ ".asSingleton()" ]
                : `terminating_step`
    terminating_step: `provider_terminator`
                  : | `factory_terminator`
                  : | `value_terminator`
    provider_terminator: ".to(provider:)"
    factory_terminator: ".to(factory:)"
    value_terminator: ".to(value:)"


