defmodule Bank.ReferralCode do
  @moduledoc false

  use Bank.Schema

  alias Bank.Account
  alias Bank.Invitation

  schema "referral_codes" do
    field :code, :string

    belongs_to :account, Account

    timestamps()
  end
end
