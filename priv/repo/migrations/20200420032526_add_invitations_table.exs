defmodule Bank.Repo.Migrations.AddInvitationsTable do
  use Ecto.Migration

  def up do
    create table(:invitations, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :referral_code_id, :binary_id, null: false
      add :account_id, :binary_id, null: false

      timestamps()
    end

    create(unique_index(:invitations, [:referral_code_id, :account_id]))
  end

  def down do
    drop table(:invitations)
  end
end
