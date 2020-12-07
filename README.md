# LocaltunnelExClient

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `localtunnel_ex_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:localtunnel_ex_client, "~> 0.1.0"}
  ]
end
```

It's using official CLI under the hood. Make sure that it's available during development.
CLI can be installed via:

```sh
npm i -g localtunnel
```

## Configuration

By default it will try to open a tunnel to local port 4000. This behavior can ba changed via:

```elixir
config :localtunnel_ex_client, local_port: "4001"
```

For production add your publicly url. No connection to external services will be created.

```elixir
config :localtunnel_ex_client, constant_url: "https://wp.pl"
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/localtunnel_ex_client](https://hexdocs.pm/localtunnel_ex_client).
