defmodule Bank.ReferralCode.LoaderTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.ReferralCode.Loader
  alias Bank.ReferralCode.Mutator

  describe "get/1" do
    test "get a referral code by code" do
      code = "12345678"
      account_id = Ecto.UUID.generate()

      attrs = %{
        account_id: account_id,
        code: code
      }

      Mutator.create(attrs)

      referral_code = Loader.get(code)
      assert referral_code
      assert referral_code.code == code
    end

    test "when not found" do
      code = "321321231"

      refute Loader.get(code)
    end
  end
end
