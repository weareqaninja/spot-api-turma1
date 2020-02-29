require "httparty"

class SpotApi
    attr_reader :url
    include HTTParty
    #base_uri  CONFIG["base_uri"]

    def initialize
        @url = CONFIG["base_uri"]
    end

    def session(payload)
        return self.class.post(
            @url + "/sessions",
            body: payload.to_json,
            headers: { "content-type": "application/json" }
        )
    end

    def dash(user_id)
        return self.class.get(
            @url + "/dashboard",
            headers: { "user_id" => user_id }
        )
    end

    def find_spot(user_id, spot_id)
        return self.class.get(
            @url + "/spots/" + spot_id,
            headers: { "user_id" => user_id }
        )
    end

    def save_spot(payload, user_id)
        return self.class.post(
            @url + "/spots",
            body: payload,
            headers: { "user_id" => user_id }
        )
    end

    def remove_spot(user_id, spot_id)
        return self.class.delete(
            @url + "/spots/" + spot_id,
            headers: { "user_id" => user_id }
        )
    end
end
