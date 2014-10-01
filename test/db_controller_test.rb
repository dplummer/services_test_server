require 'test_helper'
require 'active_record_helper'

class DbControllerTest < Minitest::Test
  def setup
    ServicesTestServer::DbController.only_one_connection
  end

  def test_transaction
    controller = ServicesTestServer::DbController.new
    user = User.create!(name: 'Bob')

    controller.begin_transaction

    user.update_attributes!(name: 'Alice')
    assert_equal 'Alice', user.name

    controller.rollback_transaction

    assert_equal 'Bob', user.reload.name
  end
end
