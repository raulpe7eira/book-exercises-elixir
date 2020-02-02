defmodule Weather.Spawn.App.Start do
  require Weather

  @moduledoc """
  Documentation for `Weather App Start parellel (spawn version)`.
  """

  @doc """
  Run temperature_of for cities.

  ## Examples

      iex> cities = ["Rio de Janeiro", "Sao Paulo", "Fortaleza"]
      ["Rio de Janeiro", "Sao Paulo", "Fortaleza"]
      iex> Weather.Spawn.App.Start.run cities
      [{#PID<0.236.0>, "Rio de Janeiro"}, {#PID<0.236.0>, "Sao Paulo"}, {#PID<0.236.0>, "Fortaleza"}]
      iex> Fortaleza: 24.5 °C, Rio de Janeiro: 25.7 °C, Sao Paulo: 22.6 °C

  """
  def run(cities) do
    manager_pid = spawn(__MODULE__, :manager, [[], Enum.count(cities)])

    cities |> Enum.map(fn city ->
      pid = spawn(__MODULE__, :get_temperature, [])
      send pid, {manager_pid, city}
    end)
  end

  def get_temperature() do
    receive do
      {manager_pid, location} ->
        send(manager_pid, {:ok, Weather.temperature_of(location)})
      _ ->
        IO.puts "Error"
    end
    get_temperature()
  end

  def manager(cities \\ [], total) do
    receive do
      {:ok, temp} ->
        results = [ temp | cities ]
        if(Enum.count(results) == total) do
          send self(), :exit
        end
        manager(results, total)
      :exit ->
        IO.puts(cities |> Enum.sort |> Enum.join(", "))
      _ ->
        manager(cities, total)
    end
  end
end
