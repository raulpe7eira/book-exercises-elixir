defmodule Weather do
  @moduledoc """
  Documentation for `Weather`.
  """

  def get_appid() do
    "d39dc56dfb0d20da819b39e2d31c62db"
  end

  def get_endpoint(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{get_appid()}"
  end

  def kelvin_to_celsius(kelvin) do
    (kelvin - 273.15) |> Float.round(1)
  end

  @doc """
  Get temperature of location (concurrent use).

  ## Examples

      iex> cities = ["Rio de Janeiro", "Sao Paulo", "Fortaleza"]
      ["Rio de Janeiro", "Sao Paulo", "Fortaleza"]
      iex> cities |> Enum.map(&(Weather.temperature_of(&1)))
      ["Rio de Janeiro: 26.4 °C", "Sao Paulo: 20.8 °C", "Fortaleza: 28.1 °C"]

  """
  def temperature_of(location) do
    result = get_endpoint(location) |> HTTPoison.get |> parser_response
    case result do
      {:ok, temp} ->
        "#{location}: #{temp} °C"
      :error ->
        "#{location} not found"
    end
  end

  defp parser_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode! |> compute_temperature
  end

  defp parser_response(_), do: :error

  defp compute_temperature(json) do
    try do
      temp = json["main"]["temp"] |> kelvin_to_celsius
      {:ok, temp}
    rescue
      _ -> :error
    end
  end
end
