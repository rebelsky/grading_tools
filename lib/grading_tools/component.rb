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

  # Convert a grade (included for historical reasons)
  def convertGrade(grade)
    @policy.convertGrade(grade)
  end
end
