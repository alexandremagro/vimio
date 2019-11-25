module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end

  def breadcrumb_item(name, link = nil)
    if link
      content_tag :li, class: 'breadcrumb-item' do
        link_to(name, link)
      end
    else
      content_tag :li, name, class: 'breadcrumb-item active'
    end
  end

  # ISO/IEC 5218
  def gender_options
    [['Male', 1], ['Female', 2], ['Not applicable', 9]]
  end
end
