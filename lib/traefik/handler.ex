defmodule Traefik.Handler do
	def handle(request) do
		request
		|> parse()
		|> route()
		|> format_response()
	end

	def parse(request) do
		[method, path, _] =
		request
		|> String.split("\n")
		|> List.first()
		|> String.split(" ")

		%{method: method, path: path, response: ""}
	end

	def route(conn)do
		 %{conn | response: "Hello 😛"}
	end

	def format_response(conn) do
		"""
		    HTTP/1.1 200 OK
		    Content-Type: text/html
		    Content-Lenght: #{String.length(conn.response)}
		    @neodevelop, @makingdevs, @elixirlang
		#{conn.response}

		"""
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