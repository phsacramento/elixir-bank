defmodule Bank.ReferralCode.ChangesetTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.ReferralCode
  alias Bank.ReferralCode.Changeset

  describe "accouReferralCodent struct" do
    test "validate fields" do
      assert %{
               code: nil,
               account_id: nil
             } = %ReferralCode{}
    end
  end

  describe "build/2" do
    test "with valid code and account should be valid" do
      attrs = %{code: "ABCDEFGH", account_id: "123"}
      changeset = Changeset.build(%ReferralCode{}, attrs)
      assert changeset.valid?
    end

    test "with blank code should be invalid" do
      attrs = %{code: nil}
      changeset = Changeset.build(%ReferralCode{}, attrs)
      refute changeset.valid?

      assert changeset.errors == [
               {:code, {"can't be blank", [validation: :required]}},
               {:account_id, {"can't be blank", [validation: :required]}}
             ]
    end

    test "with invalid account_id should be invalid" do
      attrs = %{code: "12345678"}
      changeset = Changeset.build(%ReferralCode{}, attrs)
      refute changeset.valid?

      assert changeset.errors == [account_id: {"can't be blank", [validation: :required]}]
    end
  end
end
