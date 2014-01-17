require_relative 'hospital.rb'

describe Controller  do
  controller = Controller.new
  describe "#initialize" do
    it "has an instance of the Model class" do
      expect(controller.model).to be_instance_of(Model)
    end

    it "has an instance of the View class" do
      expect(controller.view).to be_instance_of(View)
    end
  end
end

describe Model do
  # before :each do
  # @model = Model.new
  # end

  describe "#initialize" do

  end
  describe "IO functions" do
    # @model = Model.new
    # @data_to_write = [{a: 1, b: 2, c: 3}, {a: 1, b: 2, c: 3}]
    # @model.write_to_csv!('test.csv', @data_to_write)
    # data = @model.read_from_csv('test.csv')

    # expect(data[0]).to be_instance_of(Hash)
  end

  describe "authentication" do
    model = Model.new
    model.load_patients
    model.load_employees
    # puts model.patient_records
    # model.authenticate_user
  end
end