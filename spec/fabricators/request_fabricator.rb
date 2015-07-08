Fabricator(:request) do
  trap
  remote_ip { '127.0.0.1' }
  request_method { 'GET' }
  scheme { 'http' }
  query_string { 'test=test' }
  query_params {
    { 'test' => 'test' }
  }
  cookies {
    { "_requests-trap_session" => "test" }
  }
  headers {
    {
      "Host" => "localhost:3000",
      "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
      "Cookie" => "test=test",
      "Version" => "HTTP/1.1",
      "Connection" => "keep-alive",
      "User-Agent" => "Mozilla",
      "Accept-Encoding" => "gzip, deflate, sdch",
      "Accept-Language" => "en-US,en;q=0.8,bg;q=0.6,ru;q=0.4,uk;q=0.2"
    }
  }
  raw {
    <<-RAW
Host: localhost:3000
Connection: keep-alive
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
User-Agent: Mozilla
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8,bg;q=0.6,ru;q=0.4,uk;q=0.2
Cookie: test=test
Version: HTTP/1.1

RAW
  }
end
