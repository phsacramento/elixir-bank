defmodule BankWeb.AccountsController do
  @moduledoc false

  use BankWeb, :controller

  alias Bank.BankAccount.Mutator
  alias BankWeb.Helpers.Controller, as: ControllerHelper

  def create(conn, params) do
    params
    |> Mutator.create()
    |> ControllerHelper.parse_response(:created)
    |> ControllerHelper.inject_response(conn)
  end
end
