require 'logger'

module ServicesTestServer
  MissingConfiguration = Class.new(StandardError)

  def self.control_port=(port)
    @control_port = port
  end

  def self.control_port
    @control_port || raise(MissingConfiguration.new(<<-MSG))
      You must configure the port ServicesTestServer will start on, ie:
      ServicesTestServer.control_port = 8000
      MSG
  end

  def self.logger
    @logger ||= Logger.new(File.open(File::NULL, 'w'))
  end

  def self.logger=(logger)
    @logger = logger
  end
end

require 'services_test_server/version'
require 'services_test_server/db_controller'
