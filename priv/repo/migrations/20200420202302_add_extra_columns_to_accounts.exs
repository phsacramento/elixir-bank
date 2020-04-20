defmodule Bank.Repo.Migrations.AddExtraColumnsToAccounts do
  use Ecto.Migration

  def up do
    alter table(:accounts) do
      add :birth_date_hash, :binary
      add :name_hash, :binary
      add :email_hash, :binary
    end
  end

  def down do
    alter table(:accounts) do
      remove :birth_date_hash, :binary
      remove :name_hash, :binary
      remove :email_hash, :binary
    end
  end
end
