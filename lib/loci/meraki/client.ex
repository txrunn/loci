defmodule loci.MerakiApi.Client do
  require Logger
  alias HTTPoison
  alias HTTPoison.Response
  
  @base_url "https://api.meraki.com/api/v1"
  @api_key System.get_env("MERAKI_API_KEY")

  def get_organization(org_id) do
    request(:get, "/organizations/#{org_id}")
  end

  def get_network_devices(network_id) do
    request(:get, "/networks/#{network_id}/devices")
  end

  # ... other API functions ...

  defp request(method, path, params \\ %{}) do
    url = "#{@base_url}#{path}"
    headers = [{"X-Cisco-Meraki-API-Key", @api_key}, {"Content-Type", "application/json"}]

    case HTTPoison.request(method, url, "", headers, []) do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}

      {:ok, %Response{status_code: status_code}} ->
        {:error, "Request failed with status code #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed with reason: #{inspect(reason)}"}
    end
  end
end
