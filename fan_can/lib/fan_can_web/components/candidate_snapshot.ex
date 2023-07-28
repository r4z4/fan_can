defmodule FanCanWeb.Components.CandidateSnapshot do
  use Phoenix.Component

  def display(assigns) do
    ~H"""
      <section>
          <section class="text-white body-font">
              <div class="container px-5 py-24 mx-auto">
                  <div class="p-5 bg-slate-700 flex items-center mx-auto border-2  mb-10 border-white rounded-lg sm:flex-row flex-col">
                  <div class="text-base md:text-sm sm:text-xs flex-grow sm:text-left text-center mt-6 sm:mt-2">
                      <div class="md:flex font-bold text-zinc-300">
                          <div class="w-full md:w-1/2 flex space-x-3">
                            <%= @mayor.f_name %> <%= @mayor.l_name %>
                          </div>
                      </div>
                  </div>
                  </div>
              </div>
          </section>
      </section>
    """
  end
end