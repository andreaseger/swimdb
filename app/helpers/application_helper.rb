module ApplicationHelper
  def remove_child_link(name, f)
    #f.hidden_field(:_destroy) +
    link_to(name, "javascript:void(0)", :class => "remove_child")
  end

  def add_child_link(name, association)
    link_to(name, "javascript:void(0)", :class => "add_child", :"data-association" => association)
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.associations[association].klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
      end
    end
  end

  def tag_cloud(tags, classes)
    unless tags.class == [].class
      tags = tags.to_a
    end

    max_count = tags.sort_by {|t| t["value"]}.last["value"].to_f

    tags.each do |tag|
      index = ((tag["value"].to_f / max_count) * (classes.size - 1)).round
      yield tag["_id"], classes[index]
    end
  end
end

