class ApplicationController < ActionController::Base
    before_action :current_user
    def current_user
        # TODO(Tatsuemon): db:seedで作成したユーザーをcurrent_userに
		@current_user ||= User.find(1)
    end
    
    def authentification_user?
        redirect_to "/" if @current_user.nil?
    end
end
