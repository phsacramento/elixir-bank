defmodule Bank.Invitation.Mutator do
  @moduledoc false

  alias Bank.{Invitation.Changeset, Repo}

  def create(attrs) do
    attrs
    |> Changeset.build()
    |> Repo.insert_or_update()
  end
end
