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
end
