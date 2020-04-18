defmodule Bank.Repo.Migrations.AddAccountsTable do
  use Ecto.Migration
  alias Bank.Enums.AccountStatus
  alias Bank.Enums.Gender

  def up do
    AccountStatus.create_type()
    Gender.create_type()

    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :birth_date, :binary
      add :city, :binary
      add :country, :binary
      add :cpf, :binary, null: false
      add :cpf_hash, :binary, null: false
      add :email, :binary
      add :gender, :gender
      add :name, :binary
      add :state, :string
      add :status, :status, null: false
      add :referral_code, :string

      timestamps()
    end

    create(unique_index(:accounts, [:cpf]))
  end

  def down do
    drop table(:accounts)
    AccountStatus.drop_type()
    Gender.drop_type()
  end
end
