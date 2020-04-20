defmodule BankWeb.AccountsControllerTest do
  @moduledoc false

  use BankWeb.ConnCase, async: true

  alias Bank.BankAccount.Loader, as: AccountLoader
  alias Bank.BankAccount.Mutator, as: AccountMutator

  @moduletag capture_log: true

  describe "POST /api/accounts [create]" do
    test "create an account with valid cpf", %{conn: conn} do
      cpf = "03480282539"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(201)

      assert %{
               "id" => id,
               "status" => "COMPLETE",
               "invitation_code" => invitation_code
             } = response

      assert cpf |> AccountLoader.get()
      assert invitation_code
    end

    test "create an account with a empty cpf", %{conn: conn} do
      cpf = ""

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(422)

      assert %{
               "errors" => [
                 %{"cpf" => "can't be blank"}
               ]
             } = response
    end

    test "create an account with a invalid cpf", %{conn: conn} do
      cpf = "12312312312"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(422)

      assert %{
               "errors" => [
                 %{"cpf" => "Invalid Cpf"}
               ]
             } = response
    end

    test "validate duplicated cpf", %{conn: conn} do
      cpf = "03480282539"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas"
      }

      {:ok, _} = AccountMutator.create_or_update(body_request)

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(422)

      assert %{
               "errors" => [
                 %{"cpf" => "There is already an account for the cpf informed"}
               ]
             } = response
    end
  end
end
