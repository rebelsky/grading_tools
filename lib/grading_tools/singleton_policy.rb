require 'grading_tools/policy'

# Things that should only have one grade
class GradingTools::SingletonPolicy < GradingTools::Policy
  def initialize()
  end

  def compute(grades)
    if (grades.length > 0)
      grades.max
    end
  end

  def describe(grades)
  end
end


