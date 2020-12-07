defmodule LocaltunnelExClient do
  use GenServer

  require Logger

  def start_link(_) do
    case constant_url() do
      {:ok, _url} -> :ignore
      :error -> GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end
  end

  def get_url do
    case constant_url() do
      {:ok, url} -> url
      :error -> GenServer.call(__MODULE__, :get_url)
    end
  end

  @impl true
  def init(nil) do
    send(self(), :boot)
    {:ok, {:not_ready, []}}
  end

  @impl true
  def handle_info(:boot, {:not_ready, awaiting}) do
    lt = System.find_executable("lt")

    if is_nil(lt) do
      raise """
      Local tunnel `lt` binary not found.
      Please install it with "npm i -g localtunnel" for development or define external address in config for production.
      Installation: https://github.com/localtunnel/localtunnel
      """
    end

    {:ok, _spawner_pid, _spawner_os_pid} =
      Exexec.run_link([lt, "--port", local_port()], stdout: true)

    {:noreply, {:not_ready, awaiting}}
  end

  @impl true
  def handle_info({:stdout, _, "your url is: " <> url}, {:not_ready, awaiting}) do
    # remove \n from the end of url
    url = binary_part(url, 0, byte_size(url) - 1)

    Logger.info("Public url: #{url}")

    :ok = flush_awaiting(url, awaiting)

    {:noreply, {:connected, url}}
  end

  defp flush_awaiting(url, awaiting) do
    Enum.each(awaiting, &GenServer.reply(&1, url))
    :ok
  end

  @impl true
  def handle_call(:get_url, from, {:not_ready, awaiting}) do
    {:noreply, {:not_ready, [from | awaiting]}}
  end

  @impl true
  def handle_call(:get_url, _, {:connected, url} = state) do
    {:reply, url, state}
  end

  defp constant_url, do: Application.fetch_env(:localtunnel_ex_client, :constant_url)
  defp local_port, do: Application.get_env(:localtunnel_ex_client, :local_port, "4000")
end
