defmodule FanCanWeb.Router do
  use FanCanWeb, :router

  import FanCanWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FanCanWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FanCanWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", FanCanWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:fan_can, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: FanCanWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", FanCanWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{FanCanWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", FanCanWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{FanCanWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email

      live "/home", HomeLive
      live "/elections", ElectionLive.Index, :index
      live "/elections/new", ElectionLive.Index, :new
      live "/elections/:id/edit", ElectionLive.Index, :edit

      live "/elections/:id", ElectionLive.Show, :show
      live "/elections/:id/show/edit", ElectionLive.Show, :edit

      live "/states", StateLive.Index, :index
      live "/states/new", StateLive.Index, :new
      live "/states/:id/edit", StateLive.Index, :edit

      live "/states/:id", StateLive.Show, :show
      live "/states/:id/show/edit", StateLive.Show, :edit

      live "/races", RaceLive.Index, :index
      live "/races/new", RaceLive.Index, :new
      live "/races/:id/edit", RaceLive.Index, :edit

      live "/races/:id", RaceLive.Show, :show
      live "/races/:id/show/edit", RaceLive.Show, :edit

      live "/candidates", CandidateLive.Index, :index
      live "/candidates/new", CandidateLive.Index, :new
      live "/candidates/:id/edit", CandidateLive.Index, :edit

      live "/candidates/:id", CandidateLive.Show, :show
      live "/candidates/:id/show/edit", CandidateLive.Show, :edit

      live "/forums", ForumLive.Index, :index
      live "/forums/new", ForumLive.Index, :new
      live "/forums/:id/edit", ForumLive.Index, :edit

      live "/forums/:id", ForumLive.Show, :show
      live "/forums/:id/show/edit", ForumLive.Show, :edit
    end
  end

  scope "/", FanCanWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{FanCanWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
