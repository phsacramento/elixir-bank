defmodule Bank.Account do
  @moduledoc false

  use Bank.Schema
  alias Bank.Invitation
  alias Bank.ReferralCode

  schema "accounts" do
    field :birth_date, Bank.Encrypted.Binary
    field :birth_date_hash, Cloak.Ecto.SHA256
    field :city, :string
    field :country, :string
    field :cpf, Bank.Encrypted.Binary
    field :cpf_hash, Cloak.Ecto.SHA256
    field :email, Bank.Encrypted.Binary
    field :email_hash, Cloak.Ecto.SHA256
    field :gender, Bank.Enums.Gender
    field :name, Bank.Encrypted.Binary
    field :name_hash, Cloak.Ecto.SHA256
    field :state, :string
    field :status, Bank.Enums.AccountStatus, default: :PENDING
    field :referral_code, :string, virtual: true

    has_many :invitations, Invitation
    has_one :referral, ReferralCode

    timestamps()
  end
end
