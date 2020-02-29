

describe "GET /spots/:id" do
    before(:all) do
        result = SpotApi.new.session({email: "fernando@contoso.com"})
        @user_id = result.parsed_response["_id"]
    end

    describe "when get unique spot" do
        before(:all) do
            spot = { thumbnail: "contoso.jpg", company: "Contoso", techs: ["c#", "javascript"], price: 10, user: @user_id.to_mongo_id }
            
            @spot_id = MongoDb.new.save_spot(spot)
            @result = SpotApi.new.find_spot(@user_id, @spot_id)
        end

        it "should return 200" do
            expect(@result.response.code).to eql "200"
        end

        it "should contain company" do
            expect(@result.parsed_response).to include("company" => "Contoso")
        end

        it "should contain techs" do
            expect(@result.parsed_response).to include("techs" => ["c#", "javascript"])
        end

        it "should contain price" do
            expect(@result.parsed_response).to include("price" => 10)
        end

        it "should contain thumbnail" do
            expect(@result.parsed_response["thumbnail_url"]).to end_with "contoso.jpg"
        end
    end

    describe "when spot does not exist" do
        before(:all) do
            @spot_id = MongoDb.new.mongo_id
            @result = SpotApi.new.find_spot(@user_id, @spot_id)
        end

        it "should return 404" do
            expect(@result.response.code).to eql "404"
        end

        it "shoudl return empty body" do
            expect(@result.parsed_response).to be_empty
        end
    end
end