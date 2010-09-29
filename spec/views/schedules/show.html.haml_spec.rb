#require 'spec_helper'
#
#describe "/schedules/show.html.haml" do
#  before(:each) do
#    assign(:schedule,
#      stub("schedule4", :name => "First Schedule",
#                        :created_at => 3.days.ago,
#                        :description => "this is my first schedule, its just a test",
#                        :items => [stub("item1", :level => 0, :rank => 0, :text => "400m"),
#                                  stub("item2", :level => 1, :rank => 2, :text => "2000m"),
#                                  stub("item3", :level => 1, :rank => 1, :text => "200m")]))
#  end
#
#  it "should show one schedule with its name, date, description and items in any order" do
#    render
#    rendered.should have_selector("div") do
#      have_selector("strong", "First Schedule")
#      have_selector("em", 3.days.ago.strftime('%d. %b, %Y'))
#      have_selector("p", "this is my first schedule, its just a test")
#      have_selector("ul") do
#        have_selector("li") do
#          have_selector("em", 0)
#          have_selector("div", "400m")
#        end
#        have_selector("li") do
#          have_selector("em", 1)
#          have_selector("div", "2000m")
#        end
#        have_selector("li") do
#          have_selector("em", 1)
#          have_selector("div", "200m")
#        end
#      end
#    end
#  end
#
#end
#

