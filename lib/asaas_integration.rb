# frozen_string_literal: true

require_relative "asaas_integration/version"
require_relative 'asaas_integration/client'
require_relative 'asaas_integration/subscription'
require_relative 'asaas_integration/customer'

module AsaasIntegration
  class Error < StandardError; end 

  class Configuration
    attr_accessor :api_key, :base_url

    def initialize
      @api_key = ''
      @base_url = 'https://www.asaas.com/api/v3' # Produção por padrão
    end
  end

  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end
  
end
