require 'test_helper'

class TelevisionTest < ActiveSupport::TestCase
  test "Televisions are gathered from Walmart" do
    tvs = Television.from_walmart('Samsung TV')

    assert_present tvs
    assert_not_nil tvs.first.name
    assert_not_nil tvs.first.model
    assert_not_nil tvs.first.rating
    assert_not_nil tvs.first.price
  end

  test "Televisions are not added twice based on model number" do
    Television.from_walmart('Samsung TV')
    Television.from_walmart('Samsung TV')

    assert_equal(1, Television.where(:model => Television.first.model).count)
  end
end
