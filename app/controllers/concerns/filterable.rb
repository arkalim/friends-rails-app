module Filterable
  extend ActiveSupport::Concern

  def filter(resource)
    save_filters(resource)
    apply_filters(resource)
  end

  private

  def save_filters(resource)
    @filter_key = "#{resource.to_s.underscore}_params"
    session[@filter_key] = {} if session[@filter_key].nil?
    session[@filter_key].merge!(params.permit(resource::FILTER_PARAMS))
  end

  def apply_filters(resource)
    resource.filter(session[@filter_key])
  end
end
