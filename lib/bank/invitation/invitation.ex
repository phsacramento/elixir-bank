defmodule Bank.Invitation do
  @moduledoc false

  use Bank.Schema

  alias Bank.Account

  schema "invitations" do
    belongs_to :referral_account, Account
    belongs_to :account, Account

    timestamps()
  end
end
