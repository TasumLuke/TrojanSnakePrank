require 'net/sftp'

# Replace these values with your own server credentials
server = '155.246.62.110'
username = 'jojo'
password = 'hereboy'

# Set up an SFTP connection to the server
Net::SFTP.start(server, username, password: password) do |sftp|
  # Upload the text file to the server
  file_path = '/path/to/text_file.txt'
  sftp.upload! file_path, '/remote/path/text_file.txt'
end