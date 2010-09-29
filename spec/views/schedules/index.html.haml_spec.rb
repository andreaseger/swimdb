#require File.join(File.dirname(__FILE__), "..", "..", "spec_helper.rb")
#
#describe "schedules/index.html.haml" do
#  it "should list all schedules with name and there date of creation" do
#    assign(:schedules, [
#      stub("schedule1", :name => "First Schedule", :created_at => 1.days.ago),
#      stub("schedule2", :name => "Second Schedule", :created_at => 5.days.ago)
#    ])
#    render
#    rendered.should have_selector("ul") do
#      have_selector("li") do
#        have_selector("strong", "First Schedule")
#        have_selector("em", 1.days.ago.strftime('%d. %b, %Y'))
#      end
#      have_selector("li") do
#        have_selector("strong", "Second Schedule")
#        have_selector("em", 5.days.ago.strftime('%d. %b, %Y'))
#      end
#    end
#  end
#end
#

