defmodule Bank.BankAccount.Loader do
  @moduledoc false

  alias Bank.Account
  alias Bank.Repo

  @doc """
  Returns a account

  ## Examples

      iex> Bank.BankAccount.Loader.get("123.321.222-30")
      %Bank.Account{
        ...
        cpf: "03480282539",
        cpf_hash: <<31, 64, 32, 169, 208, 1, 232, 196, 167, 155, 84, 211, 61, 182,
          136, 129, 226, 150, 250, 185, 239, 23, 57, 151, 124, 172, 92, 235, 35, 218,
          3, 189>>,
        ...
      }

  """
  def get(cpf), do: Repo.get_by(Account, cpf_hash: cpf)
end
