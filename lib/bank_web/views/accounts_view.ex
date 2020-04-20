defmodule BankWeb.AccountsView do
  use BankWeb, :view

  def render("index.json", %{index: invoices}),
    do: render_many(invoices, __MODULE__, "invoice.json")

  def render("create.json", %{created: account}),
    do: render_one(account, __MODULE__, "account.json")

  def render("account.json", %{accounts: account}) do
    %{
      id: account.id,
      status: account.status,
      cpf: account.cpf_hash,
      name: account.name
    }
  end
end
