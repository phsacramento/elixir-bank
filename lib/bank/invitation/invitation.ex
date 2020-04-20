defmodule Bank.Invitation do
  @moduledoc false

  use Bank.Schema

  alias Bank.Account
  alias Bank.ReferralCode

  schema "invitations" do
    belongs_to :referral_code, ReferralCode
    belongs_to :account, Account

    timestamps()
  end
end
