module HomeHelper

  def satus_label(flag)
    if flag
      "<span class='label label-primary'>有効</span>".html_safe
    else
      "<span class='label label-danger'>無効</span>".html_safe
    end
  end

end
