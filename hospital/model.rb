require 'csv'
require 'digest'

class Model

  def initialize
    # load_records
  end

  def load_records

  end

  def execute_command
    send(command.to_sym)
  end

  def authenticate_user(credentials)
    # get_users

  end

  def load_patients

  end

  def load_doctors

  end

  def load_users

  end

  def read_from_csv(file) # returns array of hashes with csv values
    keys = []
    data = []
    CSV.foreach(file) do |row|
     if $. == 1
        keys = row.map{ |element| element.to_sym }
      else
       hash = Hash.new
       row.each_with_index { |element, i|  hash[keys[i]] = element }
       data << hash
     end
    end
    data
  end

  def write_to_csv!(file, data) # creates and writes/overwrites csv file from array of hashes
    CSV.open(file, 'wb') do |csv|
      data.each_with_index do |line, index|
        if index == 0
          headers = []
          line.each{ |k, v| headers << k }
          csv << headers
        end
        data_to_write = []
        line.each{ |k, v| data_to_write << v }
        csv << data_to_write
      end
    end
  end
end

class Patient

  attr_reader :name, :age, :gender, :inpatient, :records

  def initialize(options = {})
    @name = options[:name]
    @age = options[:age]
    @gender = options[:gender]
    @inpatient = options.fetch(:inpatient){ false }
    @records = []
  end

  def check_in
    @inpatient = true
  end

  def check_out
    @inpatient = false
  end

  def add_record(record)
    @records << record
  end
end

class Record
  @@recent_record_id = 0

  attr_reader :id, :content

  def initialize(content)
    @id = @@recent_record_id
    @@recent_record_id += 1
    @content = content
  end
end

class Employee

  attr_reader :name, :position, :salary, :age, :gender, :username, :pwd_hash

  def initialize(options = {})
    @name = options[:name]
    @position = options[:position]
    @salary = options[:salary]
    @age = options[:age]
    @gender = options[:gender]
    @username = options[:username]
    @pwd_hash = hash options[:password]
  end

  private
    def hash(pwd)
      sha256 = Digest::SHA256.new
      digest = sha256.hexdigest pwd
    end
end

# class Admin < Employee

# end


class Hospital
  attr_reader :employees, :patients

  def initialize
    @employees = []
    @patients = []
  end
end
