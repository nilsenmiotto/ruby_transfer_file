require 'socket'

host = "localhost"
port = 2000
#caminho onde se encontra o arquivo
@file = "/home/nilsen/Documentos/arquivo.pdf"
client = TCPSocket.open(host, port)

fileName = @file.split("/")[-1].chomp(File.extname(@file))
#envia o arquivo para o servidor
puts "Sending raw file"
client.puts fileName
data = IO.read("#{@file}")
client.print data
client.print "\r\r\n\n"  #informa para o servidor que enviou o arquivo

#recupera o arquivo que o servidor enviou
puts "Receiving raw file"
file = File.open("/home/nilsen/Downloads/#{fileName}.raw", 'wb')
data = client.gets("\r\r\n\n")
file.print data

client.close