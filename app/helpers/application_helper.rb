module ApplicationHelper

  def title
    if controller.action_name == "index"
      "All #{controller.controller_name.titleize}"
    else
      "#{controller.action_name.titleize} #{controller.controller_name.titleize.singularize}"
    end
  end

  def create_or_update_string
    if controller.action_name == "new"
      "Create"
    else
      "Update"
    end
  end

  def first_menu
    Menu.first
  end

  def menu(name)
    render partial: "pages/partials/menu", locals: { name: name}
  end

  def sub_menu(menu_id,banned)
    banned+=[menu_id]
    render partial: "pages/partials/sub_menu", locals: { menu_id: menu_id, banned: banned}
  end

end

