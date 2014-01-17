require 'highline/import'
class View

  def render_start
    puts <<-eos
Welcome to Alex's Hospital
--------------------------
eos
  end
  def username_prompt
    ask("Please enter your username:\n")
  end

  def password_prompt
    ask("Please enter your password:\n") { |entry| entry.echo = "*" }
  end

  def render_redo(field)
    puts "Invalid #{field}, please try again"
  end

  def render_post_auth(username)
    puts <<-eos
---------------------------
Welcome, #{username}.
---------------------------
eos
  end

  def render_options
    puts <<-eos
What would you like to do?
Options:
- list_patients
- view_records <patient_id>
- add_record <patient_id>
- remove_record <patient_id> <record_id>
eos
ask("Please enter your choice\n")
  end

  def render(object)
    puts object
  end

end