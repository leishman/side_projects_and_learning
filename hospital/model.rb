require 'csv'
require 'digest'

module Crypto
  def hash(pwd)
    Digest::SHA256.hexdigest pwd
  end
end

class RecordsHolder
  def records_file
    raise "Please implement records_file function in the subclass"
  end

  def raw_data
    @rw = ReadWrite.new(records_file)
    @raw_data ||= ReadWrite.new(records_file).data

  end

  def new_model(data)
    raise "Please implement new_model that takes a hash and creates the new object in the repo"
  end

  def load_all
    raw_data.map { |row| new_model(row) }
  end

  def all
    @all ||= load_all
  end

  def reset!
    @all = nil
  end

  def list
    all
  end

  def add(data)
    all.push new_model(data)
    @rw.data.push data
  end

  def save!
    # raw_data.data = all
    @rw.write_to_csv!
  end

  def find_all_by(field, value)
    all.select{ |obj| obj.instance_variable_get(field) == value }
  end

  # query_result = []
  # raw_data.each do |row|
  #   if values.include?(row[field.to_sym])
  #     query_result.push row
  #   end
  # end
  # query_result
end

class PatientRecords < RecordsHolder

  def records_file
    'patients.csv'
  end

  def new_model(data)
    Patient.new(data)
  end
end

class EmployeeRecords < RecordsHolder

  def records_file
    'employees.csv'
  end

  def new_model(data)
    Employee.new(data)
  end
end

class ReportRecords < RecordsHolder

  def records_file
    'reports.csv'
  end

  def new_model(data)
    Report.new(data)
  end
end

class RecordRepository

  def patients
    PatientRecords.new
  end

  def employees
    EmployeeRecords.new
  end

  def reports
    ReportRecords.new
  end
end

class Model

  include Crypto

  attr_reader :patients, :employees, :reports, :response
  attr_accessor :view_input

  def initialize
    record_repository = RecordRepository.new
    @patients = record_repository.patients
    @employees = record_repository.employees
    @reports = record_repository.reports
  end

  def execute_command(command)
    command_array = command.split(' ')
    @primary_command, @secondary_command = command_array
    send(@primary_command.to_sym)
  end

  def list_patients
    reply patients.list
  end

  def view_records
    reply reports.find_all_by(:@patient_id, @secondary_command)
  end

  def add_report
    reports.load_all
    @input_data = {patient_id: @secondary_command}
    reply :message
    @previous_reply = :message
  end

  def accept_input
    @input_data[:message] = view_input
    reports.add(@input_data)
    reports.save!
  end

  def delete_record

  end

  def reply(message)
    @response = message
  end

  def authenticate_user(credentials)
    user = employees.find_all_by(:@username, credentials[:username])[0]
    password = credentials[:password]
    self.hash(password.to_s) == user.password_hash
  end

  # def find_by_username(username)
  #   employees.list.each do |employee|
  #     puts employee
  #     return employee if employee[:username] == username
  #   end
  # end
end
  ##### Patient methods ####

#   def write_patients!
#     @patient_read_write.write_to_csv patient_records
#   end

#   def load_patients
#     @patient_read_write = ReadWrite.new('patients.csv').data
#     @patient_read_write.each do |patient|
#       patient_records << Patient.new(patient)
#     end
#   end

#   #### Employee methods ####


#   def write_employees!
#     @employee_read_write.write_to_csv employee_records
#   end

#   def load_employees
#     @employee_read_write = ReadWrite.new('employees.csv').data
#     @employee_read_write.each do |employee|
#       employee_records << employee
#     end
#   end
# end

# class GhettoActiveRecord
#   def initialize(read_write_object)
#   end

#   def find_by_field(field_name, value)
#     employee_records.each do |employee|
#       return employee if employee[:username] == username
#     end
#   end
# end


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
    CSV.open(filename, 'wb') do |csv|
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

  attr_reader :id, :name, :age, :gender, :inpatient, :report_ids

  def initialize(options = {})
    @id = options[:id]
    @name = options[:name]
    @age = options[:age]
    @gender = options[:gender]
    @inpatient = options.fetch(:inpatient){ false }
    @report_ids = []
  end

  def check_in
    @inpatient = true
  end

  def check_out
    @inpatient = false
  end

  def add_report(report)
    @report_ids.push report.id
  end
end

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
    @password_hash = options[:password_hash]
  end
end

class Hospital

  attr_reader :employees, :patients

  def initialize
    @employees = []
    @patients = []
  end
end


class Report

  attr_reader :patient_id, :message

  def initialize(options = {})
    @patient_id = options[:patient_id]
    @message = options[:message]
  end
end


# all_records = Model.new
# all_records.load

# record_repository = RecordRepository.new
# patients = record_repository.patients
# employees = record_repository.employees

# p patients.list
# patients.list
# patients.add(name: "username",dob: "10/13/1111")
# patients.save

# employees = record_repository.employees
# prescriptions = record_repository.prescriptions

# model = Model.new
# model.execute_command("list_patients")
# p model.execute_command("view_records 4")