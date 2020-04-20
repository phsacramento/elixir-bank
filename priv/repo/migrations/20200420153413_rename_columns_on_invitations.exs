defmodule Bank.Repo.Migrations.RenameColumnsOnInvitations do
  use Ecto.Migration

  def up do
    rename table(:invitations), :referral_code_id, to: :referral_account_id
    drop index(:invitations, [:referral_code_id, :account_id])

    create unique_index(:invitations, [:referral_account_id, :account_id],
             name: :unique_indication
           )
  end

  def down do
    rename table(:invitations), :referral_account_id, to: :referral_code_id
    create unique_index(:invitations, [:referral_code_id, :account_id])
    drop index(:invitations, [:referral_account_id, :account_id])
  end
end
