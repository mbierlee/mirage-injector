/**
 * Mirage Config value injector for the Poodinis Dependency Injection Framework
 * Copyright 2022-2023 Mike Bierlee
 * This software is licensed under the terms of the MIT license.
 * The full terms of the license can be found in the LICENSE file.
 */

module examples.quickstart.app;

import poodinis : DependencyContainer, Value;
import poodinis.valueinjector.mirage : loadConfig;

import std.stdio : writeln;
import std.conv : to;

class Server
{
    @Value("server.host")
    private string host;

    @Value("server.port")
    private int port;

    public void run()
    {
        writeln("Running server on " ~ host ~ ":" ~ port.to!string);
    }
}

void main()
{
    auto container = new shared DependencyContainer();
    container.register!Server;
    container.loadConfig("config.ini");

    auto server = container.resolve!Server;
    server.run();
}
