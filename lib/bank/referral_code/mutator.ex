defmodule Bank.ReferralCode.Mutator do
  @moduledoc false

  alias Bank.{ReferralCode.Changeset, Repo}

  def create(attrs) do
    attrs
    |> Changeset.build()
    |> Repo.insert()
  end
end
