from encryptor.aes_encryptor import decrypt_file

input_file = 'data/sample.txt.enc'
output_file = 'data/sample.decrypted.txt'
password = input('Enter decryption password: ')

decrypt_file(input_file, output_file, password)
print(f'Decrypted to: {output_file}')
