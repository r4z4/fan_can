defmodule FanCan.Core.PaginationComponent do
  use FanCanwWeb, :live_component
  alias FanCanWeb.Forms.PaginationForm
  def render(assigns) do
  ~H"""
  <div>
    <div>
      <%= for {page_number, current_page?} <- pages(@pagination) do %>
        <div phx-click="show_page"
             phx-value-page={page_number}
             phx-target={@myself}
             class={if current_page?, do: "active"} 
        >
          <%= page_number %>
        </div>
      <% end %>
    </div>
    
    <div>
      <.form let={f}
        for={:page_size}
        phx-change="set_page_size"
        phx-target={@myself} >
        <%= select f, :page_size,
        [10, 20, 50, 100],
        selected: @pagination.page_size %>
      </.form>
    </div>
 </div>
 """
 end
end
