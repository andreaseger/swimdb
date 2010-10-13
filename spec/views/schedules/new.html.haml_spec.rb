require 'spec_helper'

describe '/schedules/new.html.haml' do

  before(:each) do
    #evtl noch schauen wie ich das richtig mocken muss
    @schedule = Schedule.new
  end

  it 'should have all nesessary fields ' do
    render
    rendered.should have_selector("form") do
      have_selector("ul", :class => "formlist") do
        have_selector("div", "Name")
        have_selector("ul", :id=>"item_fields")
        have_selector("div", "Description")
        have_selector("div", "Original Date")
      end
    end
  end

end

