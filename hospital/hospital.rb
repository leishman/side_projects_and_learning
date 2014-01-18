require_relative 'controller.rb'

Controller.new

# record_1 = Record.new("very sick")
# record_2 = Record.new("all better")
# p record_1.id == 0
# p record_2.id == 1

# rw = ReadWrite.new('sample.csv')

# a = [{a: 1, b: 2, c: 3}, {a: 1, b: 2, c: 3}]
# model.write_to_csv!('sample.csv', a)
# rw.read_from_csv
# p rw

# patient_1_info = {age: 23, name: "Alex", gender: :m, inpatient: false}
# patient_1 = Patient.new(patient_1_info)
# p patient_1.name == "Alex"
# p patient_1.gender == :m

# doctor_1_info = {age: 23, name: "Kevin", gender: :m, salary: 1_000_000, username: "kyeh", password: "simple"}
# doctor_1 = Employee.new(doctor_1_info)
# p doctor_1.password_hash == "a7a39b72f29718e653e73503210fbb597057b7a1c77d1fe321a1afcff041d4e1"