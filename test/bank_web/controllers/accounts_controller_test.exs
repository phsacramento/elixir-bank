defmodule BankWeb.AccountsControllerTest do
  @moduledoc false

  use BankWeb.ConnCase, async: true

  alias Bank.BankAccount.Loader, as: AccountLoader

  @moduletag capture_log: true

  describe "POST /api/accounts [create]" do
    test "create an invoice with valid cpf", %{conn: conn} do
      cpf = "03480282539"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
      }

      response =
        conn
        |> put_req_header("content-type", "application/json")
        |> post(Routes.accounts_path(conn, :create), body_request)
        |> json_response(201)

      assert %{
               "id" => id,
               "status" => "PENDING"
             } = response

      assert cpf |> AccountLoader.get()
    end

    test "create an invoice with a empty cpf", %{conn: conn} do
      cpf = nil

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
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

    test "create an invoice with a invalid cpf", %{conn: conn} do
      cpf = "12312312312"

      body_request = %{
        cpf: cpf,
        name: "Paulo Henrique dos Santos Sacramento",
        birth_date: "06/01/2990",
        country: "BR",
        email: "contato@henriquesacramento.net",
        gender: "MALE",
        state: "BA",
        city: "Teixeira de Freitas",
        referral_code: "12345678"
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
  end
end
