# Take the best of a bunch of other policies
class GradingTools::BestOfPolicy
  def initialize(categories)
    @categories = categories
  end

  # Okay, the logic isn't great here.  We're ignoring the grades.
  def compute(grades)
    result = -1
    for category in @categories
      nextGrade = category.grade
      # puts "Category: #{category.type}, Grade: #{category.grade}"
      if nextGrade
        result = [result,nextGrade].max
      end
    end
    if (result > -1)
      result
    end
  end

  def describe(grades)
    "best of " + @categories.map{|c| c.type}.join(", ").downcase
  end
end
