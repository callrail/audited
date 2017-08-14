module Audited
  class Sweeper
    STORED_DATA = {
      current_remote_address: :remote_ip,
      current_request_uuid: :request_uuid,
      current_user: :current_user
    }

    delegate :store, to: ::Audited

    def around(controller)
      self.controller = controller
      STORED_DATA.each { |k,m| store[k] = send(m) }
      yield
    ensure
      self.controller = nil
      STORED_DATA.keys.each { |k| store.delete(k) }
    end

    def current_user
      lambda { controller.send(Audited.current_user_method) if controller.respond_to?(Audited.current_user_method, true) }
    end

    def before_create(audit)
      audit.user ||= current_user
      audit.agency ||= current_agency
      audit.remote_address = controller.try(:request).try(:remote_ip)
      audit.request_uuid = request_uuid if request_uuid
    end

    def remote_ip
      controller.try(:request).try(:remote_ip)
    end

    def current_agency
      controller.send(Audited.current_agency_method) if controller.respond_to?(Audited.current_agency_method, true)
    end

    def request_uuid
      controller.try(:request).try(:uuid)
    end

    def controller
      store[:current_controller]
    end

    def controller=(value)
      store[:current_controller] = value
    end
  end
end

ActiveSupport.on_load(:action_controller) do
  if defined?(ActionController::Base)
    ActionController::Base.around_action Audited::Sweeper.new
  end
  if defined?(ActionController::API)
    ActionController::API.around_action Audited::Sweeper.new
  end
end
