require 'minitest/autorun'
require 'grading_tools'

class ComponentTest < Minitest::Test
  def basic_test
    @c = GradingTools::Component.new({ :percent => 10,
                                       :type => "Homework" })
    assert_nil @c.grade
    assert @c.consider("Homework", "50", "fifty")
    assert 50, @c.grade
    assert @c.consider("homework", "100", "a lot")
    assert 75, @c.grade
  end

  def test_letter_grades
    @c = GradingTools::Component.new()
    assert(@c.convertGrade("A") >= 94, "A is at least 94")
    assert(@c.convertGrade("A-") >= 90, "A- is at least 90")
  end
end
