defmodule BankWeb.AccountsController do
  @moduledoc false

  use BankWeb, :controller

  alias Bank.BankAccount.Mutator
  alias BankWeb.Helpers.Parameters

  def create(conn, params) do
    required_params = ["cpf"]

    optional_params = [
      "name",
      "birth_date",
      "country",
      "email",
      "gender",
      "city",
      "state",
      "referral_code"
    ]

    params
    |> Parameters.filter(required: required_params, optional: optional_params)
    |> create_account()
    |> render_create(conn)
  end

  defp create_account(%{} = params), do: Mutator.create(params)
  defp create_account(error), do: error
end
