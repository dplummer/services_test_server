require 'test_helper'
require 'active_record_helper'

class ServicesTestServerTest < Minitest::Test
  def test_start
    ServicesTestServer.start
    client = DRbObject.new nil, ServicesTestServer.url

    user = User.create!(name: 'Bob')

    client.begin_transaction

    user.update_attributes!(name: 'Alice')
    assert_equal 'Alice', user.name

    client.rollback_transaction

    assert_equal 'Bob', user.reload.name
  end
end
