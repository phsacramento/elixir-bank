defmodule Bank.Repo.Migrations.RemoveReferralCodeFromAccounts do
  use Ecto.Migration

  def up do
    alter table(:accounts) do
      remove :referral_code
    end
  end

  def down do
    alter table(:accounts) do
      add :referral_code, :string
    end
  end
end
