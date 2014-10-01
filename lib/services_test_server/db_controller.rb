require 'drb'
require 'thread'

module ServicesTestServer
  class DbController
    def self.only_one_connection
      ActiveRecord::ConnectionAdapters::ConnectionPool.class_eval do
        alias_method :old_checkout, :checkout

        def checkout
          @cached_connection ||= old_checkout
        end
      end
    end

    def initialize
      @mutex = Mutex.new
    end

    def begin_transaction
      @mutex.lock
      ServicesTestServer.logger.debug "Beginning remote transaction"
      ActiveRecord::Base.connection.begin_transaction(joinable: false)
    end

    def rollback_transaction
      ServicesTestServer.logger.debug "Rolling back remote transaction"
      ActiveRecord::Base.connection.rollback_transaction
      @mutex.unlock
    end
  end
end
