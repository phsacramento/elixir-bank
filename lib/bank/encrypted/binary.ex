defmodule Bank.Encrypted.Binary do
  @moduledoc """
  Provides default crypt method to be used by searchable attributes.
  """

  use Cloak.Ecto.Binary, vault: Bank.Vault
end
