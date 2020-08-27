class ApplicationController < ActionController::Base
    def current_user
        # TODO(Tatsuemon): db:seedで作成したユーザーをcurrent_userに
		@current_user ||= User.find(1)
	end
end
