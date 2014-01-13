require 'mechanize'
require 'pry'

class RapGenius
  attr_reader :agent, :query, :home_page

  def initialize(query)
    @agent = Mechanize.new
    @query = query
    @base_url = 'http://rapgenius.com'
    @home_page = agent.get @base_url
  end

  def search
    results_page = submit_query
    result_link = grab_link(results_page, 1)
    grab_lyrics(result_link)
  end

  def submit_query
    form = @home_page.form
    form.q = @query
    results_page = @agent.submit form
  end

  def grab_link(results_page, link_rank)
    relative_link = results_page.search('.song_link')[link_rank - 1].attributes["href"].value
    @base_url + relative_link
  end

  def grab_lyrics(lyrics_page_link)
    lyrics_page = @agent.get lyrics_page_link
    # binding.pry
    # lyrics_page.search('.lyrics').text
    lyrics_page.search('.lyrics a').map{ |link| link.text + "\n" }.join
  end

end

rap_genius = RapGenius.new ARGV.join(' ')
# rap_genius = RapGenius.new('freaks and geeks')
lyrics = rap_genius.search

puts "\n\n\n"
# puts lyrics.length
# puts lyrics
lyrics_file = File.new("lyrics.txt", "w+")
lyrics_file.puts(lyrics)
lyrics_file.close

exec "lolcat lyrics.txt && cat lyrics.txt | say -v Cellos"



