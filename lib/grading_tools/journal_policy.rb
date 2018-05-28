require 'grading_tools/policy'

# Journals are plus/check/minus, can drop some, check is 90
class GradingTools::JournalPolicy < GradingTools::Policy

  def initialize(params={})
    # The number of grades we require before dropping
    @require = params[:require] || 0
    # The number of things we drop
    @drop = params[:drop] || 0
  end

  # Convert a grade to numeric form
  def convertGrade(grade)
    puts "Converting #{grade}"

    @journal_conversions ||= { 
      "plus" => 110, "excellent" => 110, "ex" => 110,
      "check++" => 105,
      "checkplus" => 100, "check+" => 100, "vg" => 100, "very good" => 100,
      "check" => 90, "good" => 90,
      "check-" => 80, "checkminus" => 80, "fair" => 80,
      "minus" => 70, "poor" => 70
    }

    @journal_conversions[grade] || super(grade)
  end

  def average(grades)
    len = grades.length
    if (0 == len)
      0
    elsif ((0 == @drop) || (len <= @drop) || (len <= @require))
      grades.inject(:+)/len.to_f
    else
      sorted = grades.sort
      (grades.inject(:+) - sorted[0..@drop-1].inject(:+))/(len.to_f - @drop)
    end
  end

  def compute(grades)
    if (grades.length > 0)
      average(grades).round(2)
    end
  end

  def describe(grades)
    if (grades.length > 0)
      droptext = ""
      if (@drop > 0)
        droptext = ", dropping the lowest #{@drop}"
      end
      "average#{droptext}"
    end
  end
end
