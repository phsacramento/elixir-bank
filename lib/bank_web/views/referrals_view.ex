defmodule BankWeb.ReferralsView do
  @moduledoc false

  use BankWeb, :view
  alias Bank.BankAccount.Loader, as: AccountLoader

  def render("index.json", %{index: referrals}),
    do: render_many(referrals, __MODULE__, "referral.json")

  def render("referral.json", %{referrals: struct}) do
    account = AccountLoader.get_by(%{id: struct.account_id})

    %{
      account_id: account.id,
      email: account.email,
      inserted_at: struct.inserted_at
    }
  end
end
