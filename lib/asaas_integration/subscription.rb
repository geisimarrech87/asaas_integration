module AsaasIntegration
  class Subscription
    def self.create(params)
      Client.post('subscriptions', params)
    end

    def self.find(id)
      Client.get("subscriptions/#{id}")
    end

    def self.list(params = {})
      Client.get('subscriptions?' + params.to_query)
    end

    def self.cancel(id)
      Client.delete("subscriptions/#{id}")
    end
  end
end