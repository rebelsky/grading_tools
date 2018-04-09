class GradingTools::SumPolicy
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
