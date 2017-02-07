require 'socket'
server = TCPServer.open(2000)
loop {
  client = server.accept

  filename = client.gets.chomp

  #recupera o que o client enviou para o servidor
  puts "Reading contents of #{filename}"
  raw_data = client.gets("\r\r\n\n").chomp("\r\r\n\n")
  file = File.open(filename, 'wb')
  file.print raw_data
  file.close

  #envia o mesmo arquivo para o client mudando a extensão
  puts "Sending contents of #{filename}"
  data = IO.read(filename)
  client.print data
  client.print "\r\r\n\n" #informa o client que terminou de enviar o arquivo

  puts "Done"
  client.close
}