defmodule Bank.Repo.Migrations.AddReferralCodesTable do
  use Ecto.Migration

  def up do
    create table(:referral_codes, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :code, :string, null: false
      add :account_id, :binary_id, null: false

      timestamps()
    end

    create(unique_index(:referral_codes, [:code]))
  end

  def down do
    drop table(:referral_codes)
  end
end
