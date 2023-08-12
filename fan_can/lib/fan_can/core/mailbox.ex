defmodule FanCan.Mailbox do
  use GenServer
  @name __MODULE__

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: @name)
  end

  def get_messages(topic) do
    GenServer.call(@name, {:get_messages, topic})
  end

  def init(_opts), do: start_link(_opts)

  def handle_call({:get_messages, "topic"}, _from, state) do
    # {:messages, [:hi]}
    {_messages, message_list} = Process.info(self(), :messages)
    {:reply, message_list, state}
  end
end