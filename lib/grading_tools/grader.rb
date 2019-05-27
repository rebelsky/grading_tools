class GradingTools::Grader
  attr_reader :name, :userid

  
  def initialize(params = {})
    @name = params[:name] || "No name"          # Student name
    @userid = params[:userid] || "abcdefgh"     # Student idt 
    @absent = params[:absent] || 2              # Penalty for absence
    @excused = params[:excused] || 2            # Excused absences
    @extra = params[:extra] || 0.25             # Points per extra credit

    @ec = GradingTools::Component.new({ :type => "Extra Credit",
                          :patterns => [/^ec/i,/^extra/i],
                          :policy => GradingTools::SumPolicy.new() })
    @absences = GradingTools::Component.new({ :type => "Absent/Late",
                                :patterns => [/^absent/i],
                                :policy => GradingTools::SumPolicy.new() })

    @categories = []
    @ignore = []                                # Names we can ignore
  end

  def addCategory(category)
    @categories << category
    category
  end

  def newCategory(params)
    addCategory(GradingTools::Component.new(params))
  end

  def processFile(fname)
    File.open(fname, "r") do |fh|
      fh.each_line do |line|
        processLine(line.chomp)
      end
    end
  end

  def processLine(line)
    line = line.gsub(/  +/, "\t")      # Replace 2 or more spaces by a tab
    (id,type,grade,notes) = line.split("\t", 4)
    notes = "" if (not notes)
    # STDERR.puts "id: '#{id}', type: '#{type}', grade: '#{grade}', notes: '#{notes}'"
    if id === userid
      processed = false
      for category in @categories + [@ec,@absences]
        if category.consider(type, grade, notes)
          processed = true
        end
      end
      for category in @ignore
        if (category === type)
          processed = true
        end #if
      end # for
      if (!processed)
        STDERR.puts "Unknown category '#{type}' in '#{line}'"
      end
    end
  end

  def report(details=true,skip_ec=false)
    puts <<-HEAD
Estimated grade report for #{name} [#{userid}]

This is an experimental grade report and is not guaranteed to be
accurate.  Estimated grades are based on current status in the
course.  Final grades may therefore be much different.

SUMMARY REPORT
--------------

    HEAD

    total = 0
    possible = 0

    for category in @categories
      grade = category.grade
      if (grade)
        percent = category.percent
        total += grade*percent/100
        possible += percent
      end
      category.summary
    end

    if (possible > 0)
      est = 100*(total/possible)
      ec = @ec.grade || 0
      extra = ec * @extra
      absences = @absences.grade || 0

      penalty = 0;
      if (absences > @excused) 
        penalty = (absences - @excused) * @absent
      end

      puts <<-NUMBERS

Estimated numeric grade = #{(est + extra - penalty).round(1)}
  Base grade: #{total.round(1)}/#{possible.round(1)} = #{est.round(1)}
NUMBERS
      penalty = 0
      if (!skip_ec) 
        puts <<-EC
  with #{ec} units of extra credit: #{(est + extra).round(1)}
EC
      end

      if (absences > @excused) 
        puts "  counting absences: #{(est + extra - penalty).round(1)}"
      end
    end

    if (details)
      puts <<-DETAILED

DETAILED REPORT
---------------

      DETAILED
      for category in @categories + [@ec,@absences]
        if (category.detailed)
	  puts ""
	end
      end
    end
  end

  def ignore(category)
    @ignore << category
  end
end

require 'grading_tools/sum_policy'
require 'grading_tools/component'
