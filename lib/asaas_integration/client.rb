require 'net/http'
require 'json'

require 'asaas_integration/errors'

module AsaasIntegration
  class Client
    def self.get(endpoint)
      uri = URI("#{AsaasIntegration.configuration.base_url}/#{endpoint}")
      request = Net::HTTP::Get.new(uri)
      request['access_token'] = AsaasIntegration.configuration.api_key
      send_request(request)
    end

    def self.post(endpoint, body)
      uri = URI("#{AsaasIntegration.configuration.base_url}/#{endpoint}")
      request = Net::HTTP::Post.new(uri)
      request['access_token'] = AsaasIntegration.configuration.api_key
      request.body = body.to_json
      request['Content-Type'] = 'application/json'
      send_request(request)
    end

    private

    def self.send_request(request)
      response = Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      when Net::HTTPUnauthorized
        raise AsaasIntegration::AuthenticationError, 'Invalid API key'
      when Net::HTTPBadRequest
        raise AsaasIntegration::BadRequestError, "Bad request: #{response.body}"
      when Net::HTTPNotFound
        raise AsaasIntegration::NotFoundError, 'Resource not found'
      when Net::HTTPServerError
        raise AsaasIntegration::ServerError, 'Server error, try again later'
      else
        raise AsaasIntegration::ApiError, "Unhandled error: #{response.body}"
      end
    end
  end
end