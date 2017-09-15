require_relative '../config/ruby_manifest.rb'
require_relative '../models/movie.rb'


class SchedulerController
  attr_reader :load_view, :runner_view, :movie_loader, :today
  attr_accessor :finished

  def initialize
    @load_view = LoadView.new
    @runner_view = RunnerView.new
    @movie_loader = MovieLoader.new
    @today = Time.now
    @finished = false
  end

  def run_program #This is the flow of your program, call other classes and methods to complete
    runner_view.reset_screen!
    load_view.ask_to_reload(today)
    reload_input = gets.chomp

    if reload_input == 'yes'
      movie_loader.compile_todays_list
      load_view.finished
    end

    until finished
      file = File.read('movie_list.json')
      data_hash = JSON.parse(file)
      movies = []
      data_hash.each do |movie|
        movies << Movie.new(movie["title"], movie["time"], movie["rating"])
      end
      p movies

      movies. each do |movie|
        p movie.title
      end

      runner_view.ask_if_user_is_finished
      user_choice = gets.chomp


    if user_choice == 'end'
        exit_program 
    else 
        movies.each do |movie|
          if user_choice == movie.title.downcase
            p "This movie is #{movie.time.split().join(" ") } long." 
          end
        end
        break
      end
    end
  end


  def exit_program
    self.finished = true
    runner_view.good_bye_message
  end
end
