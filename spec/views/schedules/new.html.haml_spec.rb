require 'spec_helper'

describe '/schedules/new.html.haml' do

  before(:each) do
    #evtl noch schauen wie ich das richitg mocken muss
    @schedule = Factory.build(:schedule)
  end

  it 'should have all nesessary fields ' do
    render
    rendered.should have_selector("form") do
      have_selector("ul", :class => "formlist") do
        #have_selector("input", "schedule[user_id]")
        have_selector("div", "Name")
        have_selector("ul", :id=>"item_fields")
        have_selector("div", "Description")
        have_selector("div", "Original Date")
        have_selector("div", "Tags")
      end
    end
  end

end

