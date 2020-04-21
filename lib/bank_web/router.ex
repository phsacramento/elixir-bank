defmodule BankWeb.Router do
  use BankWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :restrict_api do
    plug(:api)
    plug(BankWeb.Plugs.Authorization)
  end

  scope "/api", BankWeb do
    pipe_through :restrict_api

    post("/accounts", AccountsController, :create)
    post("/referrals", ReferralsController, :index)
  end
end
