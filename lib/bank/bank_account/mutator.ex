defmodule Bank.BankAccount.Mutator do
  @moduledoc false

  alias Bank.Account
  alias Bank.{BankAccount.Changeset, BankAccount.Loader, Repo}

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
  end

  def update(%Account{} = account, %{} = new_attrs) do
    account
    |> Changeset.build(new_attrs)
    |> Repo.update()
  end
end
