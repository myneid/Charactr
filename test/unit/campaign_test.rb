require 'test_helper'

class CampaignTest < ActiveSupport::TestCase

  fixtures :campaigns, :users

  def test_created_by_user
    campaign = campaigns(:online)
    assert_equal(users(:sholder), campaign.created_by_user)
  end
end
