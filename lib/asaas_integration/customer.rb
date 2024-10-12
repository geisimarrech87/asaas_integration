module AsaasIntegration
  class Customer
    def self.create(params)
      Client.post('customers', params)
    end

    def self.find(id)
      Client.get("customers/#{id}")
    end
  end
end