
require_relative 'model.rb'
require_relative 'view.rb'

class Controller
  attr_reader :view, :model

  def initialize
    @view = View.new
    @model = Model.new
    run_login
  end

  def run_login
    view.render_start
    while true
      if check_credentials
        view.render_post_auth("leishman")
        run_command_interface
        break
      else
        puts view.render_redo("password")
      end
    end
  end

  def run_command_interface
    command = view.render_options
    model.execute_command(command)
    view.render(model.response)
  end

  def check_credentials
    credentials = Hash.new
    credentials[:username] = view.username_prompt
    credentials[:password] = view.password_prompt
    model.authenticate_user(credentials)
  end

  def pass_to_view

  end
end

