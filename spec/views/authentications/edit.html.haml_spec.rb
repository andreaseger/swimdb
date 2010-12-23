require 'spec_helper'

describe '/users/authentications/edit.html.haml' do
  include Devise::TestHelpers
  before do
    @authentications = [Factory.stub(:facebook)]
  end

  it 'should show a provider' do
    render
    rendered.should have_selector('div', :class => 'provider')
  end
  it 'should show facebook as linked provider' do
    render
    rendered.should have_selector('div') do
      have_content('Facebook')
    end
  end
end

