defmodule FanCanWeb.Components.SendMessage do
  use Phoenix.Component

  # This API sucks. & can't get real IP from Docker.

  def display(assigns) do
    ~H"""
    <dialog open class="flex flex-col gap-4 items-center justify-center">
      <!-- Card -->
      <div class="w-auto border-2 border-white rounded-xl hover:bg-gray-50">
        <!-- Badge -->
        <p class="bg-sky-500 w-fit px-4 py-1 text-sm font-bold text-white rounded-tl-lg rounded-br-xl"> THIS FORUM </p>
        <div class="grid grid-cols-6 p-5 gap-y-2">
          <!-- Price -->
          <div class="flex col-start-2 ml-4 md:col-start-auto md:ml-0 md:justify-end">
            <p class="rounded-lg text-sky-500 font-bold bg-sky-100  py-1 px-3 text-sm w-fit h-fit"> $ 5 </p>
          </div>
          <button phx-click={"send_message"}>Send</button>
        </div>
      </div>
    </dialog>
    """
  end

  def send_message() do

  end
end