/**
 * Poodinis Dependency Injection Framework
 * Copyright 2022 Mike Bierlee
 * This software is licensed under the terms of the MIT license.
 * The full terms of the license can be found in the LICENSE file.
 */

module poodinis.valueinjector.mirage;

import poodinis : ValueInjector, DependencyContainer, Value, Autowire, existingInstance;

import mirage : ConfigDictionary, mirageLoadConfig = loadConfig;
import mirage.json : mirageLoadJsonConfig = loadJsonConfig;
import mirage.java : mirageLoadJavaConfig = loadJavaConfig;
import mirage.ini : mirageLoadIniConfig = loadIniConfig;

class MirageValueInjector(Type) : ValueInjector!Type
{
    @Autowire
    private ConfigDictionary config;

    public override Type get(string key)
    {
        return config.get!Type(key);
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

/** 
 * Load config from disk.
 * A specific loader will be used based on the file's extension. registerMirageInjectors 
 * will be called by this function. The loaded ConfigDictionary will be registered and available
 * for injection by itself too.
 *
 * Params:
 *   container = Dependency container to register config and injectors with.
 *   configPath = Path to the configuration file.
 * Throws: ConfigCreationException when the file's extension is unrecognized.
 */
public void loadConfig(shared(DependencyContainer) container, const string configPath)
{
    loadConfigWithLoader(container, configPath, &mirageLoadConfig);
}

/** 
 * Load a JSON config from disk.
 * registerMirageInjectors will be called by this function. The loaded ConfigDictionary will be
 * registered and available for injection by itself too.
 * Params:
 *   container = Dependency container to register config and injectors with.
 *   configPath = Path to the configuration file.
 */
public void loadJsonConfig(shared(DependencyContainer) container, const string configPath)
{
    loadConfigWithLoader(container, configPath, &mirageLoadJsonConfig);
}

/** 
 * Load a Java properties from disk.
 * registerMirageInjectors will be called by this function. The loaded ConfigDictionary will be
 * registered and available for injection by itself too.
 * Params:
 *   container = Dependency container to register config and injectors with.
 *   configPath = Path to the configuration file.
 */
public void loadJavaProperties(shared(DependencyContainer) container, const string configPath)
{
    loadConfigWithLoader(container, configPath, &mirageLoadJavaConfig);
}

/// ditto
alias loadJavaConfig = loadJavaProperties;

/** 
 * Load an INI config from disk.
 * registerMirageInjectors will be called by this function. The loaded ConfigDictionary will be
 * registered and available for injection by itself too.
 * Params:
 *   container = Dependency container to register config and injectors with.
 *   configPath = Path to the configuration file.
 */
public void loadIniConfig(shared(DependencyContainer) container, const string configPath)
{
    loadConfigWithLoader(container, configPath, &mirageLoadIniConfig);
}

private void loadConfigWithLoader(
    shared(DependencyContainer) container,
    const string configPath,
    ConfigDictionary function(const string configPath) loaderFunc
)
{
    container.registerMirageInjectors;
    auto config = loaderFunc(configPath);
    container.register!ConfigDictionary.existingInstance(config);
}

version (unittest)
{

    class TestClass
    {
        @Value("horse.name")
        public string horseName;

        @Value("horse.children")
        public uint horseChildCount;
    }

    @("Register primitive value injectors")
    unittest
    {
        auto dependencies = new shared DependencyContainer;
        dependencies.registerMirageInjectors;
    }

    @("Load config file using generic loader")
    unittest
    {
        auto dependencies = new shared DependencyContainer;
        dependencies.loadConfig("testfiles/horses.ini");

        auto config = dependencies.resolve!ConfigDictionary;
        assert(config.get("horse.name") == "Breeeeeezer");
    }

    @("Inject loaded config into class values")
    unittest
    {
        auto dependencies = new shared DependencyContainer;
        dependencies.register!TestClass;
        dependencies.loadConfig("testfiles/horses.ini");

        auto testClass = dependencies.resolve!TestClass;
        assert(testClass.horseName == "Breeeeeezer");
        assert(testClass.horseChildCount == 4);
    }

    @("Load JSON config")
    unittest
    {
        auto dependencies = new shared DependencyContainer;
        dependencies.register!TestClass;
        dependencies.loadJsonConfig("testfiles/horses.json");

        auto testClass = dependencies.resolve!TestClass;
        assert(testClass.horseName == "Maaarrrilll");
    }

    @("Load Java config")
    unittest
    {
        auto dependencies = new shared DependencyContainer;
        dependencies.register!TestClass;
        dependencies.loadJavaConfig("testfiles/horses.properties");

        auto testClass = dependencies.resolve!TestClass;
        assert(testClass.horseName == "Beaaaaaaan");
    }

    
    @("Load INI config")
    unittest
    {
        auto dependencies = new shared DependencyContainer;
        dependencies.register!TestClass;
        dependencies.loadIniConfig("testfiles/horses.ini");

        auto testClass = dependencies.resolve!TestClass;
        assert(testClass.horseName == "Breeeeeezer");
    }
}
