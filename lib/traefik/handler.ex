defmodule Traefik.Handler do
  def handle(request) do
    request
    |> parse()
    |> log()
    |> route()
    |> format_response()
  end

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, response: "", status: nil}
  end

  def log(conn), do: IO.inspect(conn, label: "LOG")

  def route(conn) do
    route(conn, conn.method, conn.path)
  end

  def route(conn, "GET", "/developers") do
    %{conn | response: "Hello 🤖"}
    %{conn | status: 200, response: "Hello 🤖"}
  end

  def route(conn, "GET", "/developers/" <> id) do
  	%{conn | status: 200, response: "Hello developer #{id}"}
  end

  def route(conn, "GET", "/projects") do
    %{conn | response: "Hola 🌹"}
     %{conn | status: 200, response: "Hola 🌹"}
  end

  def route(conn, _, path) do
  	%{conn | status: 404, response: "No '#{path}' found"}
  end

  def format_response(conn) do
    """
    HTTP/1.1 #{conn.status} #{code_status(conn.status)}
    Content-Type: text/html
    Content-Lenght: #{String.length(conn.response)}

    #{conn.response}
    """
  end

  defp code_status(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unathorized",
      403 => "Forbidden",
      404 => "Not found",
      500 => "Internal Server Error"
    }
    |> Map.get(code, "Not found")
  end
end

request = """
GET /developers HTTP/1.1
Host: makingdevs.com
User-Agent: MyBrowser/0.1
Accept: */*
"""

response = Traefik.Handler.handle(request)
IO.puts(response)

request = """
GET /projects HTTP/1.1
Host: makingdevs.com
User-Agent: MyBrowser/0.1
Accept: */*
"""

response = Traefik.Handler.handle(request)
IO.puts(response)

request = """
GET /developers/1 HTTP/1.1
Host: makingdevs.com
User-Agent: MyBrowser/0.1
Accept: */*
"""

response = Traefik.Handler.handle(request)
IO.puts(response)

request = """
GET /bugme HTTP/1.1
Host: makingdevs.com
User-Agent: MyBrowser/0.1
Accept: */*
"""

response = Traefik.Handler.handle(request)
IO.puts(response)