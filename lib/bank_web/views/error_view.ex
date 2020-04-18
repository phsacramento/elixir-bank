defmodule BankWeb.ErrorView do
  use BankWeb, :view

  alias Phoenix.Controller

  def render("400.json", %{params: params}) when is_list(params),
    do: %{"errors" => reduce_keys(params)}

  def render("422.json", %{errors: errors}) when is_list(errors),
    do: %{"errors" => format_ecto_errors(errors)}

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Controller.status_message_from_template(template)}}
  end

  defp reduce_keys(keys), do: Enum.reduce(keys, [], &format_item/2)

  defp format_item(key, acc), do: [%{key => "is required"} | acc]

  defp format_ecto_errors(errors), do: Enum.reduce(errors, [], &append_error/2)

  defp append_error({key, {msg, _}}, acc), do: [%{key => msg} | acc]
  defp append_error({key, msg}, acc), do: [%{key => msg} | acc]
end
