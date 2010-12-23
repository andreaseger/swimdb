require 'spec_helper'

describe '/schedules/index.html.haml' do
  before(:each) do
    @view.stubs(:user_signed_in?).returns(false)
    @view.stubs(:admin_signed_in?).returns(false)

    #@user = Factory.stub(:amy)
    @schedules = [Factory.stub(:valid_schedule, :created_at => Time.now)]
    @tags = [{'_id' => "foo", 'value' => "2.0"},{'_id' => "bar", 'value' => "1.0"},{'_id' => "baz", 'value' => "5.0"}]
  end

  it 'should show the tag cloud' do
    render :template => '/schedules/index', :layout => "layouts/with_tagcloud"
    rendered.should have_selector('div', :id =>'tag_cloud')
  end
  it 'should show a link for each tag' do
    render :template => '/schedules/index', :layout => "layouts/with_tagcloud"
    rendered.should have_selector("a",{:content => "foo"})
    rendered.should have_selector("a",{:content => "bar"})
    rendered.should have_selector("a",{:content => "baz"})
  end
end

