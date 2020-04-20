defmodule BankWeb.AccountsView do
  use BankWeb, :view

  def render("create.json", %{created: account}),
    do: render_one(account, __MODULE__, "account.json")

  def render("account.json", %{accounts: account}) do
    struct = account |> Bank.Repo.preload(:referral_code)

    %{
      id: struct.id,
      status: struct.status,
      cpf: struct.cpf_hash,
      name: struct.name,
      invitation_code: if(is_nil(struct.referral_code), do: "", else: struct.referral_code.code)
    }
  end
end
