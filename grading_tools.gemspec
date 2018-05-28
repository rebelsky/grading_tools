Gem::Specification.new do |s|
  s.name        = 'grading_tools'
  s.version     = '0.1.0'
  s.date        = '2018-05-27'
  s.summary     = "Tools to help SamR grade."
  s.description = "A collection of tools for using strange grading policies."
  s.authors     = ["Samuel A. Rebelsky"]
  s.email       = 'rebelsky@grinnell.edu'
  s.files       = ["lib/grading_tools.rb",
                   "lib/grading_tools/policy.rb",
		   "lib/grading_tools/average_policy.rb",
		   "lib/grading_tools/best_of_policy.rb",
		   "lib/grading_tools/count_policy.rb",
		   "lib/grading_tools/four_point_average_policy.rb",
		   "lib/grading_tools/journal_policy.rb",
		   "lib/grading_tools/percent_policy.rb",
		   "lib/grading_tools/singleton_policy.rb",
		   "lib/grading_tools/sum_policy.rb",
		   "lib/grading_tools/component.rb",
		   "lib/grading_tools/grader.rb" ]
  s.homepage    =
    'https://github.com/rebelsky/grading_tools'
  s.license       = 'MIT'
end

