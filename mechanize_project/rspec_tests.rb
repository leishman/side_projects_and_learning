require_relative 'rap_genius'
require 'rspec'

  describe RapGenius do

    before(:all) do
      @rap_genius = RapGenius.new ("freaks and geeks")
    end

    it "should have an agent, query and home_page instance variable when created" do
      @rap_genius.agent.should_not be_nil
      @rap_genius.query.should_not be_nil
      @rap_genius.home_page.should_not be_nil
    end

    context 'when search executed' do

      it "should return a search page with a search_results class when submit is executed" do
        @rap_genius.submit_query.search(".search_results").count.should > 0
      end

      it "should test first link" do
        results_page = @rap_genius.submit_query
        @rap_genius.grab_link(results_page, 1).should == 'http://rapgenius.com/Childish-gambino-freaks-and-geeks-lyrics'
      end

    end

  end