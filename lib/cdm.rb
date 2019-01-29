# frozen_string_literal: true

require "cdm/version"
require "cdm/api/urls"
require "cdm/error"
require "cdm/config"
require "cdm/api/api_client"
require "cdm/api/collections"
require "cdm/api/item_info"
require "cdm/api/search_query"
require "cdm/api/search_results"
require "cdm/api/compound_object_info"

module CDM
  def self.find(query = {})
    query ||= {}

    if query.instance_of? String
      return find(searchstrings: query)
    end

    CDM::Api::SearchQuery::get(query)
  end
end
