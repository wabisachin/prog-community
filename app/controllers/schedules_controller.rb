class SchedulesController < ApplicationController
    
    def new
        @schedule = Schedule.new
    end
    
    def create
        binding.pry
        Schedule.create(schedule_params)
        redirect_to schedules_path
    end
    
    def show 
        @schedule =  Schedule.all
    end
    
    def schedule_params
        params.require(:schedule).permit(:user_id, :start_at, :finish_at, :location, :comment)
    end
end
