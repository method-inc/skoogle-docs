require "spec_helper"

describe SkoogleDocs::Configuration do
  subject(:config) { build(:configuration) }
  let(:full_config) { build(:full_configuration) }

  describe "#client_id" do
    it "defaults to nil" do
      expect(config.client_id).to be_nil
    end
  end

  describe "#client_id=" do
    it "can set the value" do
      client_id = "FUNK_ID"
      config.client_id = client_id
      expect(config.client_id).to eq client_id
    end
  end

  describe "#client_secret" do
    it "defaults to nil" do
      expect(config.client_secret).to be_nil
    end
  end

  describe "#client_secret=" do
    it "can set the value" do
      secret = "MY_FUNKY_SECRET"
      config.client_secret = secret
      expect(config.client_secret).to eq secret
    end
  end

  describe "#auth_code" do
    it "defaults to nil" do
      expect(config.auth_code).to be_nil
    end
  end

  describe "#auth_code=" do
    it "can set the value" do
      code = "FUNKYLICIOUS"
      config.auth_code = code
      expect(config.auth_code).to eq code
    end
  end

  describe "#access_token" do
    it "defaults to nil" do
      expect(config.access_token).to be_nil
    end
  end

  describe "#access_token=" do
    it "can set the value" do
      token = "FUNKY_FUNK"
      config.access_token = token
      expect(config.access_token).to eq token
    end
  end

  describe "#refresh_token" do
    it "defaults to nil" do
      expect(config.refresh_token).to be_nil
    end
  end

  describe "#refresh_token=" do
    it "can set the value" do
      token = "FUNKY_FRESH"
      config.refresh_token = token
      expect(config.refresh_token).to eq token
    end
  end

  describe "#redirect_uri" do
    it "defaults to copy code URI" do
      expect(config.redirect_uri).to eq described_class::REDIRECT_URI
    end
  end

  describe "#redirect_uri=" do
    it "can set the value" do
      uri = "https://funk.com/oauth"
      config.redirect_uri = uri
      expect(config.redirect_uri).to eq uri
    end
  end

  describe "#permission_scope" do
    it "defaults to read only permission" do
      expect(config.permission_scope).to eq described_class::PERMISSION_SCOPE
    end
  end

  describe "#permission_scope=" do
    it "can set the value" do
      permission = "funkyonly"
      config.permission_scope = permission
      expect(config.permission_scope).to eq permission
    end
  end

  describe "#application_name" do
    it "defaults to Skoogle Docs" do
      expect(config.application_name).to eq described_class::APP_NAME
    end
  end

  describe "#application_name=" do
    it "can se the value" do
      app_name = "FUNKY DOCS"
      config.application_name = app_name
      expect(config.application_name).to eq app_name
    end
  end

  describe "#application_version" do
    it "defaults to 0.0.1" do
      expect(config.application_version).to eq described_class::APP_VERSION
    end
  end

  describe "#application_version=" do
    it "can set the value" do
      app_version = "7.7.7"
      config.application_version = app_version
      expect(config.application_version).to eq app_version
    end
  end

  describe "#credentials?" do
    context "when there are missing credentials" do
      it "returns false" do
        expect(config.credentials?).to be_falsey
      end
    end

    context "when all credentials are present" do
      it "returns true" do
        expect(full_config.credentials?).to be_truthy
      end
    end
  end

  describe "#credentials" do
    it "returns a hash with all credentials" do
      expect(config.credentials).to be_a Hash
    end

    it "includes the client id" do
      expect(config.credentials.has_key? :client_id).to be_truthy
    end

    it "includes the client secret" do
      expect(config.credentials.has_key? :client_secret).to be_truthy
    end

    it "inlcudes the authentication code" do
      expect(config.credentials.has_key? :auth_code).to be_truthy
    end
  end

  describe "#application_info" do
    it "returns a hash with the application info" do
      expect(config.application_info).to be_a Hash
    end

    it "includes the application name" do
      expect(config.application_info.has_key? :application_name).to be_truthy
    end

    it "includes the application_version" do
      expect(config.application_info.has_key? :application_version).to be_truthy
    end
  end
end
