require 'grading_tools/policy'

class GradingTools::PercentPolicy < GradingTools::Policy
  def initialize(params={})
    @missing = params[:missing] || 0
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
    if (len > @missing)
      [100,100*(grades.inject(:+) + @missing)/len.to_f].min
    end
  end

  def describe(grades)
    len = grades.length
    if (len > 0)
      if (@missing > 0)
        "#{total(grades)} out of #{len}, up to #{@missing} missing permitted"
      else
        "#{total(grades)} out of #{len}"
      end
    end
  end
end
