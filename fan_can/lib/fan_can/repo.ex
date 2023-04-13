defmodule FanCan.Repo do
  use Ecto.Repo,
    otp_app: :fan_can, adapter: Ecto.Adapters.Postgres
    use Scrivener, page_size: 100
end
