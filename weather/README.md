# Weather

## How to use it

```bash
cd weather
mix test
mix deps.get
iex -S mix
```

```elixir
iex> cities = ["Rio de Janeiro", "Sao Paulo", "Fortaleza"]

# concurrent use
iex> cities |> Enum.map(&(Weather.temperature_of(&1)))
["Rio de Janeiro: 26.4 °C", "Sao Paulo: 20.8 °C", "Fortaleza: 28.1 °C"]

# parallel use (spawn version)
iex> Weather.Spawn.AppStart.run cities
[
  {#PID<0.236.0>, "Rio de Janeiro"},
  {#PID<0.236.0>, "Sao Paulo"},
  {#PID<0.236.0>, "Fortaleza"}
]
iex> Fortaleza: 24.5 °C, Rio de Janeiro: 25.7 °C, Sao Paulo: 22.6 °C

# parallel use (task version)
iex> Weather.Task.AppStart.run cities
["Rio de Janeiro: 25.7 °C", "Sao Paulo: 22.6 °C", "Fortaleza: 24.5 °C"]
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `weather` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:weather, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/weather](https://hexdocs.pm/weather).
