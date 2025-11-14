require "google/apis/calendar_v3"

class GoogleCalendarService
    def initialize(user)
        @user = user
        refresh_token_if_needed

        @service = Google::Apis::CalendarV3::CalendarService.new
        @service.authorization = @user.google_access_token
    end


    def list_events
        @service.list_events(
            'primary',
            max_results: 10,
            single_events: true,
            order_by: 'startTime',
            time_min: Time.now.iso8601
        )
    end

    def create_event(event_params)
        '''
            event_params e.g. = {
                summary: "Sample Event",
                description: "This is a sample event created via Google Calendar API",
                location: "123 Main St, Anytown, USA",
                start: {
                    date_time: "2024-10-01T10:00:00-07
                },
                end: {
                    date_time: "2024-10-01T11:00:00-07
                }

            }
        '''
        event = Google::Apis::CalendarV3::Event.new(event_params)
        @service.insert_event('primary', event)
    end


    private

    def refresh_token_if_needed
        if @user.google_token_expires_at.present? && @user.google_token_expires_at < Time.current
            GoogleOuathService.refresh!(@user)
        end
    end
end