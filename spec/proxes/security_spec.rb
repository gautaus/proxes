# frozen_string_literal: true
require 'spec_helper'
require 'proxes/security'
require 'rack'
require 'pundit/rspec'

describe ProxES::Security do
  def app
    ProxES::Security.new(proc { [200, {}, ['Hello, world.']] })
  end

  context '#call' do
    it 'rejects anonymous requests' do
      expect { get('/') }.to raise_error(Pundit::NotAuthorizedError)
      expect { get('/_search') }.to raise_error(Pundit::NotAuthorizedError)
      expect { get('/index/_search') }.to raise_error(Pundit::NotAuthorizedError)
      expect { get('/_snapshot') }.to raise_error(Pundit::NotAuthorizedError)
      expect { get('/_node') }.to raise_error(Pundit::NotAuthorizedError)
      expect { get('/_cluster') }.to raise_error(Pundit::NotAuthorizedError)
    end

    context 'logged in' do
      context 'normal user' do
        let(:user) { create(:user) }

        before(:each) do
          # Log in
          warden = double(Warden::Proxy)
          allow(warden).to receive(:user).and_return(user)
          allow(warden).to receive(:authenticate!)
          env 'warden', warden
        end

        it 'authorizes calls that return data' do
          expect { get("/notmyindex/_search")  }.to raise_error(Pundit::NotAuthorizedError)
        end

        it 'authorizes calls that do actions' do
          expect { get('/') }.to raise_error(Pundit::NotAuthorizedError)
          expect { get('/_snapshot') }.to raise_error(Pundit::NotAuthorizedError)
        end
      end

      context 'super user' do
        let(:user) { create(:super_admin_user) }

        before(:each) do
          # Log in
          warden = double(Warden::Proxy)
          allow(warden).to receive(:user).and_return(user)
          allow(warden).to receive(:authenticate!)
          env 'warden', warden
        end

        it 'authorizes calls that return data' do
          expect { get("/notmyindex/_search")  }.to_not raise_error(Pundit::NotAuthorizedError)
        end

        it 'authorizes calls that do actions' do
          expect { get('/') }.to_not raise_error(Pundit::NotAuthorizedError)
          expect { get('/_snapshot') }.to_not raise_error(Pundit::NotAuthorizedError)
        end
      end
    end
  end
end
