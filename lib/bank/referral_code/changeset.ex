defmodule Bank.ReferralCode.Changeset do
  @moduledoc """
  Provides Referral Code database related functions.
  """

  import Ecto.Changeset

  alias Bank.ReferralCode

  @params_required ~w(code account_id)a
  @params_optional ~w()a

  @doc false
  def build(struct \\ %ReferralCode{}, attrs) do
    struct
    |> cast(attrs, @params_required ++ @params_optional)
    |> validate_required(@params_required)
    |> validate_length(:code, min: 8)
    |> validate_length(:code, max: 8)
    |> unique_constraint(:code)
  end
end
