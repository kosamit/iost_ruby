require 'ecdsa'
require 'securerandom'

class Secp256k1
	attr_accessor :group, :private_key, :public_key
	def initialize
		@group = ECDSA::Group::Secp256k1
	end

	def generate_private_key
		@private_key = 1 + SecureRandom.random_number(group.order - 1)
	end

	def generate_public_key
		@public_key = @group.generator.multiply_by_scalar(private_key)
	end

	def encode_public_key_string
		@public_key_string = ECDSA::Format::PointOctetString.encode(public_key, compression: true)
	end

	def decode
		@public_key = ECDSA::Format::PointOctetString.decode(public_key_string, group)
	end

	def debug
		puts 'private key: %#x' % private_key
		puts 'public key: '
		puts '  x: %#x' % public_key.x
		puts '  y: %#x' % public_key.y
	end
end

secp = Secp256k1.new
group = secp.group

private_key = secp.generate_private_key
public_key = secp.generate_public_key

secp.debug

# bytes = secp.encode_public_key_string

# bytes = 1023.bytes
# puts bytes.bytes.to_a

