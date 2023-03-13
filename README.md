# Mirage Config injector for Poodinis

Version 2.0.0  
Copyright 2022-2023 Mike Bierlee  
Licensed under the terms of the MIT license - See [LICENSE.txt](LICENSE.txt)

[![DUB Package](https://img.shields.io/dub/v/mirage-injector.svg)](https://code.dlang.org/packages/mirage-injector)

A config value injector for the [Poodinis dependency injection framework](https://github.com/mbierlee/poodinis) using [Mirage Config](https://github.com/mbierlee/mirage-config)

## Getting started

### DUB Dependency

See the [DUB project page](https://code.dlang.org/packages/mirage-injector) for instructions on how to include Mirage Config into your project.

### Quickstart

```d
import poodinis : DependencyContainer, Value;
import poodinis.valueinjector.mirage : loadConfig;

import std.stdio : writeln;
import std.conv : to;

class Server {
    @Value("server.host")
    private string host;

    @Value("server.port")
    private int port;

    public void run() {
        writeln("Running server on " ~ host ~ ":" ~ port.to!string);
    }
}

void main() {
    auto container = new shared DependencyContainer();
    container.register!Server;
    container.loadConfig("config.ini");

    auto server = container.resolve!Server;
    server.run();
}
```

Functions such as `loadConfig` are the same as available in Mirage. All individual loaders and parses are available. For more information on how to use Mirage, see https://github.com/mbierlee/mirage-config/blob/main/README.md

## History

For a full overview of changes, see [CHANGES.md](CHANGES.md)
