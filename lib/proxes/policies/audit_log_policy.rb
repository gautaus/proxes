# frozen_string_literal: true
require 'proxes/policies/application_policy'

module ProxES
  class AuditLogPolicy < ApplicationPolicy
    def create?
      user && user.super_admin?
    end

    def list?
      create?
    end

    def read?
      create?
    end

    def update?
      read?
    end

    def delete?
      create?
    end

    def permitted_attributes
      [:action, :details]
    end

    class Scope < ApplicationPolicy::Scope
      def resolve
        if user && user.super_admin?
          scope
        else
          scope.where(id: -1)
        end
      end
    end
  end
end