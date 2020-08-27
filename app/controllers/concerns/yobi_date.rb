module YobiDate
    extend ActiveSupport::Concern

    def get_saturday(date)
        date.ago(((date.wday+1)%7).days)
    end
end