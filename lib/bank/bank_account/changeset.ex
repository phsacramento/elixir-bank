defmodule Bank.BankAccount.Changeset do
  @moduledoc """
  Provides Bank Account database related functions.
  """

  import Ecto.Changeset
  import Brcpfcnpj.Changeset

  alias Bank.Account
  alias Bank.BankAccount.Loader

  @params_required ~w(cpf)a
  @params_optional ~w(birth_date city country email gender name state referral_code)a

  @doc false
  def build(struct \\ %Account{}, attrs) do
    struct
    |> cast(attrs, @params_required ++ @params_optional)
    |> validate_required(@params_required)
    |> validate_cpf(:cpf)
    |> validate_finished_account()
    |> put_hashed_fields()
  end

  defp put_hashed_fields(changeset) do
    changeset
    |> put_change(:cpf_hash, get_field(changeset, :cpf))
  end

  defp validate_finished_account(changeset) do
    cpf = get_field(changeset, :cpf)

    case Loader.get_by(%{cpf_hash: cpf, status: :COMPLETE}) do
      nil -> changeset
      _account -> add_error(changeset, :cpf, "There is already an account for the cpf informed")
    end
  end
end
