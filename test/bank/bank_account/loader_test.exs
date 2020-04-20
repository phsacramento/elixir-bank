defmodule Bank.BankAccount.LoaderTest do
  @moduledoc false

  use Bank.DataCase, async: true

  alias Bank.BankAccount.Loader
  alias Bank.BankAccount.Mutator

  describe "get/1" do
    test "get a account by cpf" do
      cpf = "03480282539"

      attrs = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      Mutator.create(attrs)

      account = Loader.get(cpf)
      assert account
    end

    test "when not found" do
      cpf = Brcpfcnpj.cpf_generate(true)

      refute Loader.get(cpf)
    end
  end
end
