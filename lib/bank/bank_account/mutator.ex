defmodule Bank.BankAccount.Mutator do
  @moduledoc false

  alias Bank.{BankAccount.Changeset, Repo}

  def create(attributes) do
    attributes
    |> Changeset.build()
    |> Repo.insert()
  end
end
