
# require 'thor'

# class BlockchainInfo < Thor
#   desc "hello NAME", "say hello to NAME"
#   def hello(name)
#     puts "Hello #{name}"
#   end

#   desc ""
# end

require 'httparty'
require 'json'

class BlockchainInfo

  def initialize
    @base_url = "https://blockchain.info/"
  end

  def start_program
    display_welcome
    execute_user_commands
  end

  def display_welcome
      puts <<-eos
    Welcome to the blockchain.info explorer command line program.
    This allows you to get block, transaction and addresss information from the
    Blockchain.info API.
    eos
  end

  def display_options_menu
      puts <<-eos
    Please enter the letter of the information you would like to get:

    b BLOCK_NUMBER - get block information (ex. b 280339)
    t TX_HASH - get transaction information (ex. t b6f6991d03d...)
    a ADDRESS - get address information (ex. a 1AJbsFZ64EpEfS5UAjAfcUG8pH8Jn3rn1F)
    q - quit the program

    eos
  end

  def execute_user_commands

    while true
      display_options_menu
      print "Please enter a command: "
      command, arg = gets.chomp.downcase.split
      puts "\n"

      if command == "b"
        get_block_information(arg)
      elsif command == "t"
        get_transaction_information(arg)
      elsif command == "a"
        get_address_information(arg)
      elsif command == "q"
        break

      else
        puts "Command not valid, please enter new command \n\n"
      end

    end
  end

  def get_block_information
    puts "Enter the desired block number"
    block = HTTParty.get("https://blockchain.info/block-index/#{block_number}?format=json")
    puts JSON.pretty_generate(block)
  end

  def get_transaction_information
    puts "getting tx info"

  end

  def get_address_information
    puts "getting address info"
  end

end

# Functionality
# Display menu
# Get block information
# Get transaction information
# Get singl/multiple address information
block_obj = BlockchainInfo.new
block_obj.start_program