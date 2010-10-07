module SchedulesHelper
  def add_item_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, "items", :partial => 'item', :object => Item.new
    end
  end
end

