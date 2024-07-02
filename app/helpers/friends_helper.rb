module FriendsHelper
  def sort_link(column, label)
    label = "#{label} #{sort_icon}" if params[:sort_by] && column == params[:sort_by].to_sym
    link_to label, friends_path(sort_by: column, sort_direction: sort_direction), class: 'sort-link'
  end

  def sort_direction
    return 'asc' unless params[:sort_direction].present?

    params[:sort_direction] == 'asc' ? 'desc' : 'asc'
  end

  def sort_icon
    sort_direction == 'asc' ? '▼' : '▲'
  end
end
