defmodule FanCan.EctoLogger do
  require Logger
  def handle_event([fan_can, :repo, :query], %{query_time: time}, %{query: query, params: params}, _config) do
    time_ms = System.convert_time_unit(time, :native, :millisecond)
    Logger.info("Query time: #{time_ms} with Query: #{query} and Params: ")
  end
  # Catch all
  def handle_event(_event, _, _metadata, _config) do
    # Uses this to debug when we forgot to add the _config arg
    Logger.info(binding())
  end
end