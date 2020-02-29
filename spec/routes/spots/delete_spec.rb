

describe "DELETE /spots/:id" do
    before(:all) do
        result = SpotApi.new.session({email: "fernando@acme.com"})
        @user_id = result.parsed_response["_id"]
    end

    describe "when delete spot" do
        before(:all) do
            spot = { thumbnail: "acme.jpg", company: "Acme", techs: ["c#", "javascript"], price: 10, user: @user_id.to_mongo_id }
            
            @spot_id = MongoDb.new.save_spot(spot)
            @result = SpotApi.new.remove_spot(@user_id, @spot_id)
        end

        it "should return 204" do
            expect(@result.response.code).to eql "204"
        end

        it "should return empty body" do
            expect(@result.parsed_response).to be_empty
        end

        after(:all) do
            result = SpotApi.new.find_spot(@user_id, @spot_id)
            expect(result.response.code).to eql "404"
        end
    end

    describe "when spot does not exist" do
        before(:all) do
            @spot_id = MongoDb.new.mongo_id
            @result = SpotApi.new.remove_spot(@user_id, @spot_id)
        end

        it "should return 204" do
            expect(@result.response.code).to eql "204"
        end

        it "should return empty body" do
            expect(@result.parsed_response).to be_empty
        end
    end
end