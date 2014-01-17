require 'csv'
require 'digest'

module Crypto
  def hash(pwd)
    sha256 = Digest::SHA256.new
    digest = sha256.hexdigest pwd
  end
end

class Model
  include Crypto
  attr_reader :patient_records, :employee_records, :response

  def initialize
    @patient_records = []
    @employee_records = []
    load_records
  end

  def load_records
    load_employees
    load_patients
    # load_records
  end

  def execute_command(command)
    command_array = command.split(' ')
    send(command_array[0].to_sym)
  end

  def list_patients
    @response = @patient_records
  end

  def view_records
  end

  def add_record
  end

  def remove_record
  end

  def authenticate_user(credentials)
    username = credentials[:username]
    user = find_by_username(username)
    # puts user#[:password_hash]
    password = credentials[:password]
    self.hash(password) == user[:password_hash]
  end

  def find_by_username(username)
    employee_records.each do |employee|
      return employee if employee[:username] == username
    end
  end

  ##### Patient methods ####

  def write_patients!
    @patient_read_write.write_to_csv employee_records
  end

  def load_patients
    @patient_read_write = ReadWrite.new('patients.csv').data
    @patient_read_write.each do |patient|
      patient_records << Patient.new(patient)
    end
  end

  def add_patient

  end

  def add_record

  end

  #### Employee methods ####

  def add_employee

  end

  def write_employees!
    @employee_read_write.write_to_csv employee_records
  end

  def load_employees
    @employee_read_write = ReadWrite.new('employees.csv').data
    @employee_read_write.each do |employee|
      employee_records << employee
    end
  end
end

class GhettoActiveRecord
  def initialize(read_write_object)
  end

   def find_by_field(field_name, value)
    employee_records.each do |employee|
      return employee if employee[:username] == username
    end
  end
end


class ReadWrite
  attr_reader :filename, :headers
  attr_accessor :data

  def initialize(filename)
    @filename = filename
    @headers = []
    @data = []
    read_from_csv # read data to memory on initialization
  end

  def read_from_csv # returns array of hashes with csv values
    keys = []
    CSV.foreach(filename) do |row|
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

  def write_to_csv! # creates and writes/overwrites csv file from array of hashes
    CSV.open(file, 'wb') do |csv|
      write_header(csv)
      write_body(csv)
    end
  end

  def write_header(csv)
    headers = []
    data[0].each{ |k, v| headers << k  }
    csv << headers
  end

  def write_body(csv)
    data.each_with_index do |line|
      data_to_write = []
      line.each{ |k, v| data_to_write << v }
      csv << data_to_write
    end
  end
end

class Patient
  # @@id = 0

  attr_reader :id, :name, :age, :gender, :inpatient, :records

  def initialize(options = {})
    # @id = @@id
    # @@id += 1
    @id = options[:id]
    @name = options[:name]
    @age = options[:age]
    @gender = options[:gender]
    @inpatient = options.fetch(:inpatient){ false }
    @record_ids = []
  end

  def check_in
    @inpatient = true
  end

  def check_out
    @inpatient = false
  end

  def add_record(record)
    @records << record.id
  end

  def record

  end

end

# class Record
#   @@recent_record_id = 0

#   attr_reader :id, :content

#   def initialize(content)
#     @id = @@recent_record_id
#     @@recent_record_id += 1
#     @content = content
#   end
# end

class Employee
  include Crypto

  attr_reader :name, :position, :salary, :age, :gender, :username, :password_hash

  def initialize(options = {})
    @name = options[:name]
    @position = options[:position]
    @salary = options[:salary]
    @age = options[:age]
    @gender = options[:gender]
    @username = options[:username]
    p options[:password]
    @password_hash = self.hash options[:password]
  end
end

class Hospital
  attr_reader :employees, :patients

  def initialize
    @employees = []
    @patients = []
  end
end
