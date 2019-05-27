# Our general policy
class GradingTools::Policy
  def compute(grades)
    return 100
  end

  def describe(grades)
    return nil
  end

  # Convert a grade to numeric form
  def convertGrade(grade)
    @conversions ||= { "0" => 0, "Zero" => 0, "zero" => 0,
      "A+" => 100, "A" => 96, "A-" => 92, "A-/B+" => 90, "A/B" => 90,
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

    @conversions[grade] || grade.to_f
  end
end
