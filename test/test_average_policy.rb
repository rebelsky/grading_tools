require 'minitest/autorun'
require 'grading_tools'

class AveragePolicyTest < Minitest::Test
  def setup
    @ap = GradingTools::AveragePolicy.new()
  end

  def test_singleton
    assert_equal 100, @ap.compute([100])
    assert_equal 50, @ap.compute([50])
  end

  def test_simple
    assert_equal 50, @ap.compute([0,100])
  end
end
