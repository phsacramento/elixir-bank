defmodule BankWeb.ReferralsController do
  @moduledoc false

  use BankWeb, :controller

  alias Bank.Account
  alias Bank.BankAccount.Loader, as: AccountLoader
  alias Bank.Invitation.Loader, as: InvitationLoader
  alias BankWeb.Helpers.Parameters

  def index(conn, params) do
    required_params = ["cpf"]

    params
    |> Parameters.filter(required: required_params)
    |> Parameters.atomize_keys()
    |> get_account()
    |> get_invitations()
    |> render_index(conn)
  end

  defp get_account(%{cpf: cpf}) do
    cpf
    |> AccountLoader.get()
  end

  defp get_invitations(%Account{status: :PENDING} = _account) do
    {:error, %{errors: [cpf: {"Unable to show referrals for pending activation accounts", []}]}}
  end

  defp get_invitations(%Account{status: :COMPLETE} = account) do
    InvitationLoader.get_all_by(%{referral_account_id: account.id})
  end

  defp get_invitations(_) do
    {:error, :params_missing, %{}}
  end
end
