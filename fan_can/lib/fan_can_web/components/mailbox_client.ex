defmodule FanCanWeb.Components.MailboxClient do
  use Phoenix.Component

  def display(assigns) do
    ~H"""
      <section>
          <section class="text-white body-font">
              <div class="container px-5 py-24 mx-auto">
                  <div class="p-5 bg-slate-700 flex items-center mx-auto border-2 mb-10 border-white rounded-lg sm:flex-row flex-col">
                    <ul id="message_list" class="">
                      <%= for message <- @some_id do %>
                        <li>
                          <details class="open:bg-slate-900 duration-300">
                            <summary class="bg-inherit px-5 py-3 text-lg cursor-pointer"><%= message.updated_at %> || <b class="text-green-400">Subject:</b> <%= message.subject %></summary>
                            <div class="px-5 py-3 border border-gray-300 text-sm font-light">
                                <p>Praesent posuere nisi vel diam congue varius. Praesent lacus nulla, congue nec rhoncus nec,
                                    suscipit et enim. Donec ultrices nec arcu et pharetra.</p>
                            </div>
                          </details>
                        </li>
                      <% end %>
                    </ul>
                  </div>
              </div>
          </section>
      </section>
    """
  end
end