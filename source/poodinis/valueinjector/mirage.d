/**
 * Poodinis Dependency Injection Framework
 * Copyright 2022 Mike Bierlee
 * This software is licensed under the terms of the MIT license.
 * The full terms of the license can be found in the LICENSE file.
 */

module poodinis.valueinjector.mirage;

import poodinis : ValueInjector, DependencyContainer;

class MirageValueInjector(Type) : ValueInjector!Type
{
    public override Type get(string key)
    {
        throw new Exception("Not yet implemented");
    }
}

alias MirageBoolValueInjector = MirageValueInjector!bool;
alias MirageByteValueInjector = MirageValueInjector!byte;
alias MirageUbyteValueInjector = MirageValueInjector!ubyte;
alias MirageCharValueInjector = MirageValueInjector!char;
alias MirageShortValueInjector = MirageValueInjector!short;
alias MirageUshortValueInjector = MirageValueInjector!ushort;
alias MirageWcharValueInjector = MirageValueInjector!wchar;
alias MirageIntValueInjector = MirageValueInjector!int;
alias MirageUintValueInjector = MirageValueInjector!uint;
alias MirageDcharValueInjector = MirageValueInjector!dchar;
alias MirageLongValueInjector = MirageValueInjector!long;
alias MirageUlongValueInjector = MirageValueInjector!ulong;
alias MirageFloatValueInjector = MirageValueInjector!float;
alias MirageDoubleValueInjector = MirageValueInjector!double;
alias MirageRealValueInjector = MirageValueInjector!real;
alias MirageStringValueInjector = MirageValueInjector!string;

/** 
 * Registers Mirage Config value injectors for all primitive types.
 * Params:
 *   container = Dependency container to register injectors with.
 */
public void registerMirageInjectors(shared(DependencyContainer) container)
{
    container.register!(ValueInjector!bool, MirageBoolValueInjector);
    container.register!(ValueInjector!byte, MirageByteValueInjector);
    container.register!(ValueInjector!ubyte, MirageUbyteValueInjector);
    container.register!(ValueInjector!char, MirageCharValueInjector);
    container.register!(ValueInjector!short, MirageShortValueInjector);
    container.register!(ValueInjector!ushort, MirageUshortValueInjector);
    container.register!(ValueInjector!wchar, MirageWcharValueInjector);
    container.register!(ValueInjector!int, MirageIntValueInjector);
    container.register!(ValueInjector!uint, MirageUintValueInjector);
    container.register!(ValueInjector!dchar, MirageDcharValueInjector);
    container.register!(ValueInjector!long, MirageLongValueInjector);
    container.register!(ValueInjector!ulong, MirageUlongValueInjector);
    container.register!(ValueInjector!float, MirageFloatValueInjector);
    container.register!(ValueInjector!double, MirageDoubleValueInjector);
    container.register!(ValueInjector!real, MirageRealValueInjector);
    container.register!(ValueInjector!string, MirageStringValueInjector);
}

version (unittest)
{
    @("Register primitive value injectors")
    unittest
    {
        auto dependencies = new shared DependencyContainer;
        dependencies.registerMirageInjectors;
    }
}
