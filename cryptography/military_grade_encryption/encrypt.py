from encryptor.aes_encryptor import encrypt_file

input_file = 'data/sample.txt'
output_file = 'data/sample.txt.enc'
password = input('Enter encryption password: ')

encrypt_file(input_file, output_file, password)
print(f'Encrypted to: {output_file}')
