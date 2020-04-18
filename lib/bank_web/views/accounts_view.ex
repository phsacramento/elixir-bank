defmodule BankWeb.AccountsView do
  use BankWeb, :view

  def render("create.json", %{created: accounts}),
    do: render_many(accounts, __MODULE__, "account.json")

  def render("update.json", %{updated: account}),
    do: render_one(account, __MODULE__, "account.json")

  def render("account.json", %{accounts: account}) do
    %{
      id: account.id
    }
  end
end
