defmodule Bank.Account do
  @moduledoc false

  use Bank.Schema

  schema "accounts" do
    field :birth_date, Cloak.Ecto.SHA256
    field :city, :string
    field :country, :string
    field :cpf, Bank.Encrypted.Binary
    field :cpf_hash, Cloak.Ecto.SHA256
    field :email, Cloak.Ecto.SHA256
    field :gender, Bank.Enums.Gender
    field :name, Cloak.Ecto.SHA256
    field :state, :string
    field :status, Bank.Enums.AccountStatus, default: :PENDING
    field :referral_code, :string

    timestamps()
  end
end
