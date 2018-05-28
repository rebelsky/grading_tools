Developer notes
===============

I learned how to set up gems using 
<http://guides.rubygems.org/make-your-own-gem/>.

During development, the useful lines include

    % gem build grading_tools.gemspec
    % gem install ./grading_tools*.gem
    # or sudo gem install ./grading_tools*.gem

To do
-----

* Add tests.  Lots of tests.
