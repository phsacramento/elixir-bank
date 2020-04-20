defmodule Bank.Invitation.ChangesetTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.Invitation
  alias Bank.Invitation.Changeset

  describe "referral code struct" do
    test "validate fields" do
      assert %{
               referral_code_id: nil,
               account_id: nil
             } = %Invitation{}
    end
  end

  describe "build/2" do
    test "with valid referral code and account should be valid" do
      attrs = %{referral_code_id: "123", account_id: "123"}
      changeset = Changeset.build(%Invitation{}, attrs)
      assert changeset.valid?
    end

    test "with blank referral code should be invalid" do
      attrs = %{referral_code_id: nil, account_id: "123"}
      changeset = Changeset.build(%Invitation{}, attrs)
      refute changeset.valid?

      assert changeset.errors == [
               {:referral_code_id, {"can't be blank", [validation: :required]}}
             ]
    end

    test "with invalid account_id should be invalid" do
      attrs = %{referral_code_id: "12345678", account_id: ""}
      changeset = Changeset.build(%Invitation{}, attrs)
      refute changeset.valid?

      assert changeset.errors == [account_id: {"can't be blank", [validation: :required]}]
    end
  end
end
