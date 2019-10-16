class SchedulesController < ApplicationController
    before_action :schedule_params, only: :create
    
    def new
        @schedule = Schedule.new
    end
    
    def create
        # binding.pry
        Schedule.create(schedule_params)
        redirect_to schedules_path
    end
    
    def show 
        
    end
    
    def index
        @schedules =  Schedule.order("start_at ASC")
    end
    # ここからprivate
    private
    
        def schedule_params
            #フォームから受け取ったparamsをストロングパラメータに変換
            strong_params = params.require(:schedule).permit(:user_id, :location, :date, :start_at, :finish_at, :comment)
            # スケジュール作成の為のデータをハッシュ型で定義し、データの編集が必要な:start_at,:finish_atカラム以外のデータを格納
            # schedule_params =  {}
            
            schedule_params = {user_id: strong_params[:user_id],date: strong_params[:date].to_date,
                                    location: strong_params[:location], comment: strong_params[:comment]}
            #:start_at, :finish_atの値をまずは文字列型として型を整形
            string_start_at =strong_params[:date]+" "+"#{strong_params["start_at(4i)"]}:#{strong_params["start_at(5i)"]}"
            string_finish_at =strong_params[:date]+" "+"#{strong_params["finish_at(4i)"]}:#{strong_params["finish_at(5i)"]}"
            #文字列型をDatetime型に変換してデータを格納。ただし、データベースへのcreate時にUTC→JSTに時差変換され、9時間進んだ状態で登録される。
            #なので９時間分差し引いてparamsに代入する。
            schedule_params[:start_at] = DateTime.parse(string_start_at) - 9.0/24
            schedule_params[:finish_at] = DateTime.parse(string_finish_at) - 9.0/24
            
            return schedule_params
        end
end
