defmodule FanCanWeb.Components.VoterInfo do

  attr :id, :string, required: true
  attr :info, :map, default: %{}

  def get_loc_info() do
    state_str = get_str(state)
    IO.inspect(state_str, label: "State")
    {:ok, resp} = 
      Finch.build(:get, "https://ip.city/api.php?ip=#{ip_addr}&key=#{System.fetch_env!("IP_CITY_API_KEY")}") 
      |> Finch.request(FanCan.Finch)
  end

  def get_voter_info() do
    'https://civicinfo.googleapis.com/civicinfo/v2/voterinfo?address=12%20M%20Lincoln%2C%20NE&electionId=2000&key=#{System.fetch_env!("GCLOUD_API_KEY")}'

    state_str = get_str(state)
    IO.inspect(state_str, label: "State")
    {:ok, resp} = 
      Finch.build(:get, "https://civicinfo.googleapis.com/civicinfo/v2/representatives?address=#{state_str}&key=#{System.fetch_env!("GCLOUD_API_KEY")}") 
      |> Finch.request(FanCan.Finch)

    {:ok, body} = Jason.decode(resp.body)

    IO.inspect(body["offices"], label: "Offices")
    IO.inspect(body["officials"], label: "Officials")

    %{"offices" => body["offices"], "officials" => body["officials"]}

  end

  def display(assigns) do
    ~H"""
    <h4>Voter Info</h4>
      <div class="mt-10 space-y-8 bg-slate-700">
        <%= @info %>
      </div>
    """
  end
end