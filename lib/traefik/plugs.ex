defmodule Traefik.Plugs do
	alias Traefik.Conn

  def rewrite_path(%Conn{path: "/internal-projects👻"} = conn) do
    %Conn{conn | path: "/secret-projects👻"}
  end

  def rewrite_path(%Conn{} = conn), do: conn

  def track(%Conn{status: 404, path: path} = conn) do
    IO.puts("Warn 💀 #{path} not found!")
    conn
  end

  def track(%Conn{} = conn), do: conn

  def log(%Conn{} = conn), do: IO.inspect(conn, label: "LOG")
end