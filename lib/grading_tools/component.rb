# One component of a student's grade.
class GradingTools::Component
  attr_reader :percent, :type

  @@dots = ".........................."

  def initialize(params={})
    @type = params[:type] || "Unknown"
    @policy = params[:policy] || GradingTools::AveragePolicy.new()
    @percent = params[:percent] || 0
    @patterns = params[:patterns] || [Regexp.new("^#{@type}", "i")]
    @grades = []
    @data = []
  end

  # Try to an item to the component.  Returns true if we add it to
  # the component and false otherwise.
  def consider(name, grade, notes)
    for pattern in @patterns
      if (pattern.match(name))
        info = "#{name}\t#{grade}\t#{notes}"
        @data << info
        if (grade != "X")
          @grades << convertGrade(grade)
        end
        return true
      end
    end
    return false
  end

  # Get the grade
  def grade
    return @policy.compute(@grades)
  end

  # Print the summary information on a component
  def summary
    comment = @policy.describe(@grades)
    if (comment)
      comment = " (#{comment})"
    else
      comment = ""
    end
    mygrade = grade
    if mygrade
      mygrade = "#{mygrade.round(1)}"
    else
      mygrade = "[No grades available]"
    end
    if ((0 == @percent) || (100 == @percent) || (-100 == @percent)) 
      dots = @@dots[@type.length + 1 .. -1]
      puts "#{@type} #{dots}: #{mygrade}#{comment}"
    else
      dots = @@dots[@type.length + 9 .. -1]
      percentText = "#{@percent.round(1)}"
      if (@percent < 10) 
        percentText = " #{percentText}"
      end
      puts "#{@type} #{dots} (#{percentText}%): #{mygrade}#{comment}"
    end
  end

  # Print the detailed information on a component
  def detailed
    if (@data.length > 0)
      mygrade = grade || ""
      puts "#{@type}: #{mygrade.round(1)}"
      for datum in @data
        puts "\t#{datum}"
      end 
      return true
    end
  end

  # Convert a grade to numeric form
  @@conversions = { "0" => 0, "Zero" => 0, "zero" => 0,
    "A" => 96, "A-" => 92, "A-/B+" => 90, "A/B" => 90,
    "B+" => 88, "B" => 86, "B-" => 82, "B-/C+" => 80, "B/C" => 80,
    "C+" => 78, "C" => 76, "C-" => 72, "C-/D+" => 70, "C/D" => 70,
    "D+" => 68, "D" => 66, "D-" => 62, 
    "F" => 55,
    "plus" => 5.5, "excellent" => 5.5, "ex" => 5.5,
    "check++" => 5,
    "checkplus" => 4.5, "check+" => 4.5, "vg" => 4.5, "very good" => 4.5,
    "check" => 3, "good" => 3,
    "check-" => 2.5, "checkminus" => 2.5, "fair" => 2.5,
    "minus" => 1, "poor" => 1
  }

  def convertGrade(grade)
    return @@conversions[grade] || grade.to_f
  end
end
