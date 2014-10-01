require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_drb_port_config
    ServicesTestServer.control_port = 8008
    assert_equal 8008, ServicesTestServer.control_port
  end

  def test_logger
    sio = StringIO.new
    ServicesTestServer.logger = Logger.new(sio)
    ServicesTestServer.logger.info 'cats'
    sio.rewind
    assert (sio.read =~ /  INFO -- : cats$/), 'Expected logger to log'
  end
end
