module AsaasIntegration
  class ApiError < StandardError; end
  class AuthenticationError < ApiError; end
  class BadRequestError < ApiError; end
  class NotFoundError < ApiError; end
  class ServerError < ApiError; end
end