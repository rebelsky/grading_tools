require 'grading_tools/policy'

class GradingTools::SumPolicy < GradingTools::Policy
  def initialize()
  end

  def compute(grades)
    if (grades.length > 0)
      grades.inject(:+)
    end
  end

  def describe(grades)
  end
end


