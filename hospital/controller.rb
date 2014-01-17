
require_relative 'model.rb'
require_relative 'view.rb'

class Controller
  attr_reader :view, :model

  def initialize
    @view = View.new
    @model = Model.new
    run_program
  end

  def run_program
    view.render_start
    get_credentials
  end

  def get_credentials
    credentials = Hash.new
    credentials[:username] = view.username_prompt
    credentials[:password] = view.password_prompt
    model.authenticate_user(credentials)
  end

  def pass_to_view

  end
end

