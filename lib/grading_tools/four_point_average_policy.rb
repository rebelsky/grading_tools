require 'grading_tools/policy'

# A policy for grading on a four-point scale, taking averages
class GradingTools::FourPointAveragePolicy < GradingTools::Policy
  def initialize()
  end

  def average(grades)
    len = grades.length
    if (0 == len)
      0
    else
      grades.inject(:+)/len.to_f
    end
  end

  def compute(grades)
    if (grades.length > 0)
      (55 + (average(grades) * 10)).round(2)
    end
  end

  def describe(grades)
    if (grades.length > 0)
      "average of #{average(grades).round(1)} on a four-point scale"
    end
  end
end
