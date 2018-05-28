require 'grading_tools/policy'

# Count the number of items, up to the required number.
class GradingTools::CountPolicy < GradingTools::Policy
  def initialize(params={})
    @required = params[:required] || 14
  end

  def total(grades)
    if grades.length > 0
      grades.inject(:+)
    else
      0
    end
  end

  def compute(grades)
    len = grades.length
    if (len > 0)
      [100.0*total(grades)/([len,@required].min),100].min
    end
  end

  def describe(grades)
    if (grades.length > 0)
      "#{total(grades)} out of #{@required}"
    end
  end
end
