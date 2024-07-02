module Filterable
  extend ActiveSupport::Concern

  def filter(resource, records)
    save_filters(resource)
    apply_filters(records, resource)
  end

  private

  def save_filters(resource)
    @filter_key = "#{resource.to_s.underscore}_params"
    session[@filter_key] = {} if session[@filter_key].nil?
    session[@filter_key].merge!(params.permit(resource::FILTER_PARAMS))
  end

  def apply_filters(records, resource)
    resource.filter(records, session[@filter_key])
  end
end
