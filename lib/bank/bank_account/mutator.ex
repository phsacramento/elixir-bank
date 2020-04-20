defmodule Bank.BankAccount.Mutator do
  @moduledoc false

  alias Bank.Account
  alias Bank.{BankAccount.Changeset, BankAccount.Loader, Repo}
  alias Bank.ReferralCode.Mutator, as: ReferralCodeMutator

  def create(attrs) do
    attrs
    |> Changeset.build()
    |> Repo.insert()
  end

  def create_or_update(attrs) do
    result =
      case Loader.get(attrs[:cpf]) do
        nil -> %Account{}
        account -> account
      end

    result
    |> Changeset.build(attrs)
    |> Repo.insert_or_update()
    |> create_referral_code()
  end

  defp create_referral_code({:ok, %Account{} = account} = result) do
    if account.status == :COMPLETE do
      attrs = %{
        code: ReferralCode.Code.generate(8, :alpha),
        account_id: account.id
      }

      ReferralCodeMutator.create(attrs)
    end

    result
  end

  defp create_referral_code({:error, _} = error), do: error
end
