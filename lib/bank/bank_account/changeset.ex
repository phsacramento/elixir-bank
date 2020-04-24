defmodule Bank.BankAccount.Changeset do
  @moduledoc """
  Provides Bank Account database related functions.
  """

  import Ecto.Changeset
  import Brcpfcnpj.Changeset

  alias Bank.Account
  alias Bank.BankAccount.Loader

  # alias Bank.ReferralCode.Loader, as: ReferralCodeLoader

  @params_required ~w(cpf)a
  @params_optional ~w(birth_date city country email gender name state status referral_code)a

  @doc false
  def build(struct \\ %Account{}, attrs) do
    struct
    |> cast(attrs, @params_required ++ @params_optional)
    |> validate_required(@params_required)
    |> validate_cpf(:cpf)
    |> put_hashed_fields()
    |> flag_complete()
    |> validate_finished_account()
  end

  defp put_hashed_fields(changeset) do
    changeset
    |> put_change(:cpf_hash, get_field(changeset, :cpf))
    |> put_change(:email_hash, get_field(changeset, :email))
    |> put_change(:name_hash, get_field(changeset, :name))
    |> put_change(:birth_date_hash, get_field(changeset, :birth_date))
  end

  defp flag_complete(%{valid?: false} = changeset), do: changeset

  defp flag_complete(%{valid?: true} = changeset),
    do: put_change(changeset, :status, change_status_if_complete(changeset))

  defp change_status_if_complete(changeset) do
    if is_complete?(changeset) do
      :COMPLETE
    else
      :PENDING
    end
  end

  defp is_complete?(changeset) do
    Enum.all?(
      [:birth_date, :city, :country, :email, :gender, :name, :state],
      &get_field(changeset, &1, false)
    )
  end

  defp validate_finished_account(changeset) do
    cpf = get_field(changeset, :cpf)

    if is_nil(cpf) do
      changeset
    else
      case Loader.get_by(%{cpf_hash: cpf, status: :COMPLETE}) do
        nil -> changeset
        _account -> add_error(changeset, :cpf, "There is already an account for the cpf informed")
      end
    end
  end
end
