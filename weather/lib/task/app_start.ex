defmodule Weather.Task.App.Start do
  require Weather

  @moduledoc """
  Documentation for `Weather App Start parellel (task version)`.
  """

  @doc """
  Run temperature_of for cities.

  ## Examples

      iex> cities = ["Rio de Janeiro", "Sao Paulo", "Fortaleza"]
      ["Rio de Janeiro", "Sao Paulo", "Fortaleza"]
      iex> Weather.Task.App.Start.run cities
      ["Rio de Janeiro: 25.7 °C", "Sao Paulo: 22.6 °C", "Fortaleza: 24.5 °C"]

  """
  def run(cities) do
    cities
    |> Enum.map(&create_task/1)
    |> Enum.map(&Task.await/1)
  end

  defp create_task(city) do
    Task.async(fn -> Weather.temperature_of(city) end)
  end
end
